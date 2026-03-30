# OpenClaw-Attendance 🚀

A high-fidelity, Telegram-based Daily Activity Tracker and Attendance companion bot. Driven by **OpenClaw**, utilizing high-end AI models (Kimi K2.5 Cloud / gpt-oss:20b) to track and summarize your daily work life.

---

## 🛠 Tech Stack

- **Core Framework**: [OpenClaw](https://openclaw.ai) (The multi-channel AI gateway)
- **Primary AI**: Ollama `kimi-k2.5:cloud` (Ollama's cloud-native high-context model)
- **Fallback AI**: Local `gpt-oss:20b` (for offline stability)
- **Integration**: Telegram Bot API (via `grammY`)
- **Plugin System**: Native OpenClaw Plugin SDK (Node.js/TypeScript)
- **Storage**: Persistent local JSON-based activity store

---

## 🏗 Project Architecture

```bash
OpenClaw-Attendance/
├── plugins/
│   └── daily-activity-tracker/ # The brain: Tool plugin that logs tasks
├── workspace/
│   └── AGENTS.md               # Personality & Instructions for the bot
├── openclaw.json               # The configuration hub
├── .env.example                # Environment template
├── setup.bat / setup.sh        # Deployment scripts
└── start_bot.bat / start_bot.sh # Launchers
```

---

## 🚀 Quick Setup Guide

### 1. Prerequisites
Ensure the following are installed:
- [Node.js](https://nodejs.org) (v18.0.0+)
- [Ollama](https://ollama.com) (For local and cloud model hosting)

### 2. Deployment
Clone this repository and run the setup script:

**Windows:**
```cmd
setup.bat
```

**macOS / Linux:**
```bash
./setup.sh
```

### 3. Setup Telegram
1. Open Telegram and search for [@BotFather](https://t.me/botfather).
2. Create a new bot and copy the **API Token**.
3. Create a `.env` file from the example: `cp .env.example .env`.
4. Add your token: `TELEGRAM_BOT_TOKEN="YOUR_TOKEN_HERE"`.

---

## 🔧 Configuring Access & Persistence

### Adding your Phone/User ID:
The first time you message the bot, it will ask for **Pairing Approval** due to strict security.
1. Send any message to your new bot.
2. It will reply with a **Pairing Code** (e.g., `5GQJBQ`).
3. Run this command in your terminal to approve your account:
   ```bash
   npx openclaw pairing approve telegram <YOUR_CODE>
   ```

### Persistent Activity Tracking:
All tasks you log are stored in your workspace. You can use these commands with the bot:
- *"I just finished the attendance module"* → Logs a task with timestamp.
- *"Show my activities from today"* → Retreives and summarizes your logs using the `get_activities` tool.

---

## ☁️ Setting Up The Environment

Configure your `openclaw.json` or `.env` for seamless model switching:

```json
{
  "agents": {
    "defaults": {
      "model": {
        "primary": "ollama/kimi-k2.5:cloud",
        "fallbacks": ["ollama/gpt-oss:20b"]
      }
    }
  }
}
```

- **Ollama Cloud**: Run `ollama signin` to auth with Ollama Cloud for zero-CPU inference.
- **Failover**: If cloud tokens run out, it automatically falls back to your local hardware.

---

## ⚡ Technical Statistics
- **Quantization Support**: Native vector quantization (TurboQuant) compatible for KV cache efficiency.
- **Context Handling**: Up to **128k context** via Kimi cloud.
- **Response Latency**: ~50ms (Gateway overhead) + Model TTFT.

---

## 📜 License
ISC License. Built with ❤️ by Koustubh Deodhar using the OpenClaw community.
