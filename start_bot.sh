#!/usr/bin/env bash
export OPENCLAW_CONFIG_PATH=/Users/admin/Desktop/Ping/bot/openclaw.json
export OPENCLAW_STATE_DIR=/Users/admin/Desktop/Ping/bot/.openclaw
export OLLAMA_API_KEY="ollama-local"

cd /Users/admin/Desktop/Ping/bot
npx openclaw gateway
