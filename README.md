🌟 Overview

This project is a real-time multiplayer chat game where humans and AI bots interact inside lobbies.
It demonstrates:
✅ Real-time messaging with Socket.IO
✅ Lobby management (create/join public or private rooms)
✅ Mixed Human + AI chat with streaming GPT replies
✅ Lightweight game events (e.g., trivia every 5 messages)
✅ Mobile-ready Flutter app packaged as APK

✨ Features

🔹 Home Screen → View all active lobbies with live participant counts
🔹 Lobby Creation → Create public/private lobbies with optional passwords
🔹 Lobby Chat → Real-time human + AI conversations
🔹 AI Bot 🤖 → Responds in ~2s, streams reply token-by-token
🔹 Game Loop 🎮 → Trivia question injected every 5 messages
🔹 System Events 📢 → Notifications when users join/leave

🏗 Architecture
<img width="1053" height="188" alt="ai_chat_game_architecture_detailed" src="https://github.com/user-attachments/assets/fa1316dd-c4c6-424e-8c89-7eee22c8a8ef" />

🔄 Workflow

1️⃣ Client (Flutter app) connects to server via Socket.IO (ngrok tunnel)
2️⃣ Server (Node.js) manages lobbies, chat, and event broadcasting
3️⃣ On message → server calls OpenAI GPT API for AI reply
4️⃣ AI bot replies streamed live into lobby chat
5️⃣ Every 5th message → Trivia event injected

⚙️ Tech Stack
🎨 Frontend (Flutter)

Flutter SDK (3.x)

socket_io_client (WebSocket client)

Material UI

🖥 Backend (Node.js)

Node.js 18+

Express.js

Socket.IO

OpenAI SDK

ngrok (for tunneling)

🚀 Setup & Run Instructions
🔹 1. Clone Repository
git clone https://github.com/yourusername/ai-chat-game-prototype.git
cd ai-chat-game-prototype

🔹 2. Backend Setup (Node.js)
cd server
npm install


Create .env inside /server/:

OPENAI_API_KEY=your_openai_api_key


Start server:

node server.js


✅ Output: Server running on port 3000

Expose with ngrok:

ngrok http 3000


👉 Copy HTTPS URL (example: https://46b13e416632.ngrok-free.app)

🔹 3. Frontend Setup (Flutter)
cd client
flutter pub get


Update lib/main.dart:

serverUrl: "https://<your-ngrok-url>"


Run on emulator:

flutter run


Build APK:

flutter build apk --release


📂 APK Location:
client/build/app/outputs/flutter-apk/app-release.apk

🔹 4. Connect & Test

Launch app → Home screen shows lobbies

Tap ➕ → Create Lobby (public/private)

Inside chat:

Send message → 🤖 AI responds in ~2s

After 5 messages → 🎮 Trivia event appears

Open another device/emulator → test multiplayer

📦 Deliverables

✅ Signed APK (Android 10+)
✅ Source repo (this GitHub)
✅ Documentation (README + diagrams in /docs/)
✅ Demo video (screen recording with voice-over)

⚠️ Known Limitations

⚡ Only 1 AI bot per lobby
⚡ AI is stateless (no memory across chats)
⚡ Server state is in-memory (resets on restart)
⚡ UI is minimal (MVP style)

🔮 Future Work

🔹 Add persistent DB (MongoDB/Postgres)
🔹 Support multiple AI bots with personalities
🔹 Richer gameplay loops (polls, scoring, mini-games)
🔹 Add authentication & persistent profiles
🔹 Improved UI/UX (avatars, themes, animations)

🎥 Demo Video → [Link to YouTube/Google Drive once uploaded]

📂 APK Download → [Link or GitHub Releases]
