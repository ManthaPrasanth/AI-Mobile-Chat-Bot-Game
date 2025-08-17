// server.js - AI Chat Game Backend
// For ideatrix Cogn AI Lab Take-Home Assessment
// Uses Socket.IO + OpenAI v4+ + Streaming + Game Events

require('dotenv').config();
const express = require('express');
const http = require('http');
const { Server } = require('socket.io');
const { OpenAI } = require('openai');

// Initialize Express & HTTP Server
const app = express();
const server = http.createServer(app);

// Configure Socket.IO
const io = new Server(server, {
  cors: {
    origin: "*", // Allow all origins
    methods: ["GET", "POST"]
  }
});

// Initialize OpenAI API (v4+)
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY, // From .env
});

// In-memory lobbies
const lobbies = {};

io.on('connection', (socket) => {
  console.log('✅ New client connected:', socket.id);

  // Join lobby
  socket.on('join', ({ lobbyId, username, password }) => {
    const lobby = lobbies[lobbyId];
    if (!lobby || (lobby.type === 'private' && lobby.password !== password)) {
      socket.emit('error', 'Invalid lobby or password');
      return;
    }
    socket.join(lobbyId);
    socket.lobbyId = lobbyId;
    socket.username = username;
    io.to(lobbyId).emit('user_joined', { username });
  });

  // Send message
  socket.on('message', async ({ content }) => {
    const lobbyId = socket.lobbyId;
    const username = socket.username;

    if (!lobbyId) return;

    // Save and broadcast message
    const message = { sender: username, content, timestamp: new Date().toISOString() };
    io.to(lobbyId).emit('message', message);

    if (!lobbies[lobbyId].messages) lobbies[lobbyId].messages = [];
    lobbies[lobbyId].messages.push(message);

    // 🔁 Trigger trivia every 5 messages
    if (lobbies[lobbyId].messages.length % 5 === 0) {
      io.to(lobbyId).emit('game_event', {
        type: 'trivia',
        question: "Quick poll: Cats or Dogs?",
        options: ["Cats", "Dogs"]
      });
    }

    // 🤖 AI Bot: Reply after 2s
    setTimeout(async () => {
      const botName = "AI_Bot";
      const prompt = `You are ${botName}, a fun AI in a chat game. Respond naturally to: "${content}"`;

      try {
        const stream = await openai.chat.completions.create({
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: prompt }],
          stream: true,
        });

        let replyContent = '';
        const botMsgId = Date.now();

        // Notify: AI is typing
        io.to(lobbyId).emit('ai_typing', { sender: botName, isTyping: true });

        // ✅ Correct way to consume stream
        for await (const chunk of stream) {
          const token = chunk.choices[0]?.delta?.content || '';
          if (token) {
            replyContent += token;
            // ✅ Emit live chunks
            io.to(lobbyId).emit('ai_chunk', {
              id: botMsgId,
              sender: botName,
              content: token
            });
          }
        }

        // Done streaming
        io.to(lobbyId).emit('ai_typing', { sender: botName, isTyping: false });

        // ✅ Send final assembled AI message
        io.to(lobbyId).emit('ai_message', {
          id: botMsgId,
          sender: botName,
          content: replyContent
        });

      } catch (err) {
        console.error('OpenAI API error:', err);
        io.to(lobbyId).emit('message', {
          sender: 'System',
          content: '[AI: Error]'
        });
      }
    }, 2000);
  });

  // Create lobby
  socket.on('create_lobby', (lobby) => {
    lobbies[lobby.id] = { ...lobby, messages: [] };
    socket.join(lobby.id);
    socket.lobbyId = lobby.id;
    broadcastLobbies();
  });

  // Disconnect
  socket.on('disconnect', () => {
    if (socket.lobbyId) {
      io.to(socket.lobbyId).emit('user_left', { username: socket.username });
    }
  });
});

// Broadcast lobbies every 5s
function broadcastLobbies() {
  const lobbyList = Object.keys(lobbies).map(id => {
    const room = io.sockets.adapter.rooms.get(id);
    return {
      id,
      type: lobbies[id].type,
      playerCount: room?.size || 0
    };
  });
  io.emit('lobbies_update', lobbyList);
}

setInterval(broadcastLobbies, 5000);

// Start server
const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});
