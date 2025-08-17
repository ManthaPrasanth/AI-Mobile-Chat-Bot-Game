📱 AI-Powered Mobile Chat Game Prototype

Developer: Sai Prasanth Mantha

🌟 Overview

This project is a real-time chat game prototype where humans and AI bots interact inside game lobbies.
It demonstrates:

Real-time messaging with Socket.IO

Lobby creation/joining (public & private)

Mixed Human + AI chat with streaming AI replies

Lightweight game events (trivia injection)

Mobile-ready Flutter client packaged as APK

✨ Features

🔹 Home Screen → See all active lobbies with participant counts

🔹 Lobby Creation → Create public/private lobbies with optional passwords

🔹 Lobby Chat → Real-time human + AI conversation

🔹 AI Bot → Replies in ~2s, streams content token-by-token

🔹 Game Loop → Trivia question every 5 messages

🔹 System Events → Join/leave notifications

🏗 Architecture
<img width="1053" height="188" alt="ai_chat_game_architecture_detailed" src="https://github.com/user-attachments/assets/3ecde36e-489c-4b79-9cd3-a9dc0c3afc5e" />

Workflow

User connects to Node.js server via Socket.IO (ngrok tunnel).

Server manages lobbies, chat, and broadcasts events.

On each message, server calls OpenAI GPT API for AI bot reply.

AI bot streams tokens → sent back to Flutter client in real-time.

Every 5th message → trivia event injected.

⚙️ Tech Stack
Frontend (Flutter Client)

Flutter SDK (3.x)

socket_io_client (WebSocket client)

Material UI

Backend (Node.js Server)

Node.js 18+

Express.js

Socket.IO

OpenAI SDK

ngrok

🚀 Setup & Run Instructions
🔹 1. Clone Repository
git clone https://github.com/yourusername/ai-chat-game-prototype.git
cd ai-chat-game-prototype

🔹 2. Backend Setup (Node.js)
cd server
npm install


Create .env in /server/:

OPENAI_API_KEY=your_openai_api_key


Start server:

node server.js


✅ You should see: ✅ Server running on port 3000

Expose server with ngrok:

ngrok http 3000


Copy the HTTPS URL (e.g. https://46b13e416632.ngrok-free.app).

🔹 3. Frontend Setup (Flutter)
cd client
flutter pub get


Open lib/main.dart and update:

serverUrl: "https://<your-ngrok-url>"


Run on emulator:

flutter run


Or build APK:

flutter build apk --release


APK will be in:

client/build/app/outputs/flutter-apk/app-release.apk

🔹 4. Connect & Test

Launch the app on emulator or phone.

Home screen shows lobbies list (auto-updates).

Tap ➕ to create lobby → enter Lobby ID.

Inside chat:

Send message → AI replies in ~2s.

After 5 messages → trivia event appears.

Open another emulator/phone to join same lobby → test multiplayer.

📦 Deliverables

✅ Signed APK (Android 10+)

✅ Source repo (this GitHub)

✅ Documentation (this README + diagrams in /docs/)

✅ Demo video (screen recording with voice-over)

⚠️ Known Limitations

Single AI bot per lobby

Stateless AI (no long-term context memory)

In-memory server state (resets on restart)

Simple UI (minimal, not production styled)

🔮 Future Work

Persistent DB (MongoDB/Postgres)

Multiple AI bots with personalities

Richer gameplay loops (polls, votes, scoring)

Authentication & user profiles

Better UI/UX (avatars, themes, notifications)
