@echo off
title ATS Notifier Bot - Pull Fallback Model
color 0E

echo ============================================================
echo    Download Fallback Model: gpt-oss:20b (~13 GB)
echo ============================================================
echo.
echo This will download the local fallback model.
echo It will be used when cloud tokens run out.
echo.
set /p CONFIRM="Start download? (Y/N): "
if /i not "%CONFIRM%"=="Y" (
    echo Download cancelled.
    pause
    exit /b 0
)

echo.
echo Downloading gpt-oss:20b... This may take 20-30 minutes.
ollama pull gpt-oss:20b

if %errorlevel% equ 0 (
    echo.
    echo [OK] Model downloaded successfully!
    echo The fallback model is now available.
) else (
    echo.
    echo [ERROR] Download failed. Make sure Ollama is running.
)

pause
