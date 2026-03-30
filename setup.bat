@echo off
title ATS Notifier Bot - Setup
color 0A

echo ============================================================
echo    ATS Notifier Bot - First Time Setup
echo    Daily Activity Tracker via Telegram
echo ============================================================
echo.

:: Check Node.js
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is NOT installed!
    echo Please install Node.js from: https://nodejs.org/
    echo Download the LTS version and run the installer.
    echo After installing, close this window and run setup.bat again.
    pause
    exit /b 1
)
echo [OK] Node.js found: 
node --version

:: Check Ollama
where ollama >nul 2>nul
if %errorlevel% neq 0 (
    echo.
    echo [WARNING] Ollama is NOT installed.
    echo Please install Ollama from: https://ollama.com/download/windows
    echo After installing, close this window and run setup.bat again.
    echo.
    echo The bot can still work with cloud models if Ollama is running.
    pause
    exit /b 1
)
echo [OK] Ollama found:
ollama --version

:: Install OpenClaw locally
echo.
echo [STEP 1/4] Installing OpenClaw...
cd /d "%~dp0"
call npm init -y >nul 2>nul
call npm install openclaw@latest
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install OpenClaw. Check your internet connection.
    pause
    exit /b 1
)
echo [OK] OpenClaw installed.

:: Install plugin dependencies
echo.
echo [STEP 2/4] Installing plugin dependencies...
cd /d "%~dp0plugins\daily-activity-tracker"
call npm install @sinclair/typebox >nul 2>nul
cd /d "%~dp0"
echo [OK] Plugin dependencies installed.

:: Generate config with correct Windows paths
echo.
echo [STEP 3/4] Generating configuration...
set "BOT_DIR=%~dp0"
set "BOT_DIR=%BOT_DIR:~0,-1%"

:: Create the .openclaw state directory
if not exist "%BOT_DIR%\.openclaw\extensions\daily-activity-tracker" mkdir "%BOT_DIR%\.openclaw\extensions\daily-activity-tracker"

:: Copy plugin files to extensions
xcopy /Y /Q "%BOT_DIR%\plugins\daily-activity-tracker\*.*" "%BOT_DIR%\.openclaw\extensions\daily-activity-tracker\" >nul

echo [OK] Configuration generated.

:: Sign in to Ollama for cloud models
echo.
echo [STEP 4/4] Ollama Cloud Setup...
echo To use kimi-k2.5:cloud (free cloud model), you need to sign in to Ollama.
echo.
set /p OLLAMA_SIGNIN="Do you want to sign in to Ollama now? (Y/N): "
if /i "%OLLAMA_SIGNIN%"=="Y" (
    ollama signin
)

echo.
echo ============================================================
echo    Setup Complete!
echo ============================================================
echo.
echo To start the bot, double-click: start_bot.bat
echo.
echo Your Telegram bot: @ATSNotifierBOT
echo.
pause
