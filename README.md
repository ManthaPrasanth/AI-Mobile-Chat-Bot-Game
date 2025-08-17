# 🤖🎮 AI Chat Game Prototype

## 🌟 What is this?
This project is a **multiplayer chat game** where real people and AI bots hang out in the same lobby.  
Think of it as a group chat that’s a little more playful: bots reply in real time, trivia questions pop up, and everyone gets to interact together.

---

## ✨ What you can do
- 🏠 **Home Screen** → See all active lobbies and how many people are inside  
- ➕ **Create or Join Lobbies** → Public or private (with a password if you like)  
- 💬 **Chat in Real Time** → Humans and AI chatting side by side  
- 🤖 **AI Bot** → Chimes in within ~2 seconds, typing out responses token by token  
- 🎮 **Mini-Game Loop** → A trivia question drops in every 5 messages  
- 📢 **System Messages** → Clear notifications when people join or leave  

---

## 🏗 How it works

<img width="1053" height="188" alt="ai_chat_game_architecture_detailed" src="https://github.com/user-attachments/assets/ffcb6e40-e5c7-492a-94c2-b3d0a6f0b8c9" />


### 🔄 Behind the scenes
1. The **Flutter mobile app** connects to the server through Socket.IO (with ngrok for tunneling).  
2. A **Node.js backend** handles lobbies, chat, and events.  
3. When someone sends a message, the server calls the **OpenAI GPT API**.  
4. The AI’s reply is **streamed live into the chat**, just like a person typing.  
5. Every few messages, the game engine injects a trivia question to keep things lively.  

---

## 🚀 Why build this?
It’s a small but working prototype to show how **AI + real-time networking** can make online interactions more fun.  
Perfect as a starting point for bigger ideas like social games, study groups, or AI companions in multiplayer apps.


---

## ⚙ Tech Stack

### 🎨 Frontend (Flutter)
- Flutter SDK (3.x)  
- `socket_io_client` (WebSocket client)  
- Material UI  

### 🖥 Backend (Node.js)
- Node.js 18+  
- Express.js  
- Socket.IO  
- OpenAI SDK  
- ngrok (for tunneling)  

---

## 🚀 Setup & Run Instructions

### 1. Clone Repository
```bash
git clone https://github.com/yourusername/ai-chat-game-prototype.git
cd ai-chat-game-prototype
````

### 2. Backend Setup (Node.js)

```bash
cd server
npm install
```

Create `.env` inside `/server/`:

```env
OPENAI_API_KEY=your_openai_api_key
```

Start server:

```bash
node server.js
```

✅ Output: `Server running on port 3000`

Expose with ngrok:

```bash
ngrok http 3000
```

👉 Copy HTTPS URL (e.g., `https://46b13e416632.ngrok-free.app`)

---

### 3. Frontend Setup (Flutter)

```bash
cd client
flutter pub get
```

Update `lib/main.dart`:

```dart
serverUrl: "https://<your-ngrok-url>"
```

Run on emulator:

```bash
flutter run
```

Build APK:

```bash
flutter build apk --release
```

📂 APK Location:
`client/build/app/outputs/flutter-apk/app-release.apk`

---

### 4. Connect & Test

1. Launch app → Home screen shows lobbies
2. Tap ➕ → Create Lobby (public/private)
3. Inside chat:

   * Send message → 🤖 AI responds in \~2s
   * After 5 messages → 🎮 Trivia event appears
4. Open another device/emulator → test multiplayer

---

## 📦 Deliverables

* ✅ Signed APK (Android 10+)
* ✅ Source repo (this GitHub)
* ✅ Documentation (README + diagrams in `/docs/`)
* ✅ Demo video (screen recording with voice-over)

---

## ⚠ Known Limitations

* ⚡ Only **1 AI bot per lobby**
* ⚡ AI is **stateless** (no memory across chats)
* ⚡ Server state is **in-memory** (resets on restart)
* ⚡ UI is **minimal** (MVP style)

---

## 🔮 Future Work

* 🔹 Add persistent DB (MongoDB/Postgres)
* 🔹 Support **multiple AI bots** with personalities
* 🔹 Richer gameplay loops (polls, scoring, mini-games)
* 🔹 Add **authentication & persistent profiles**
* 🔹 Improved UI/UX (avatars, themes, animations)

---

## 🎥 Demo Video

📺 \https://www.youtube.com/watch?v=3YYPvKHovhQ

## 📂 APK Download

📦 Apk Provided in The Folder above

"# AI-Powered-Mobile-Chat-Game" 
"# AI-Powered-Mobile-Chat-Game" 
"# AI-Mobile-Chat-Bot-Game" 
"# AI-Mobile-Chat-Bot-Game" 
"# AI-Mobile-Chat-Bot-Game" 
"# AI-Mobile-Chat-Bot-Game" 



