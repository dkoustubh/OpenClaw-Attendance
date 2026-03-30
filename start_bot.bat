@echo off
title ATS Notifier Bot - Running
color 0B

echo ============================================================
echo    ATS Notifier Bot - Daily Activity Tracker
echo    Telegram: @ATSNotifierBOT
echo ============================================================
echo.

:: Set paths relative to this script
set "BOT_DIR=%~dp0"
set "BOT_DIR=%BOT_DIR:~0,-1%"

:: Set environment variables
set "OPENCLAW_CONFIG_PATH=%BOT_DIR%\openclaw.json"
set "OPENCLAW_STATE_DIR=%BOT_DIR%\.openclaw"
set "OLLAMA_API_KEY=ollama-local"

:: Check if setup was run
if not exist "%BOT_DIR%\node_modules\openclaw" (
    echo [ERROR] OpenClaw is not installed. Please run setup.bat first!
    pause
    exit /b 1
)

:: Check if Ollama is running
curl -s http://127.0.0.1:11434/api/tags >nul 2>nul
if %errorlevel% neq 0 (
    echo [WARNING] Ollama doesn't seem to be running.
    echo Starting Ollama...
    start /b ollama serve >nul 2>nul
    timeout /t 3 /nobreak >nul
)

echo [INFO] Starting OpenClaw Gateway...
echo [INFO] Config: %OPENCLAW_CONFIG_PATH%
echo [INFO] Primary Model: kimi-k2.5:cloud
echo [INFO] Fallback Model: gpt-oss:20b (local)
echo.
echo Press Ctrl+C to stop the bot.
echo ============================================================
echo.

:: Start the gateway
cd /d "%BOT_DIR%"
npx openclaw gateway

:: If gateway exits, pause so user can see errors
echo.
echo [INFO] Gateway stopped.
pause
