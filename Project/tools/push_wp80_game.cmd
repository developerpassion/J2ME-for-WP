@echo off
rem Push J2ME .jar games into the WP8.0 app over USB (phone unlocked, app closed).
rem   push_wp80_game.cmd game1.jar [game2.jar ...]   (drag & drop .jar files onto this file also works)
if "%~1"=="" (
  echo Usage: %~nx0 game1.jar [game2.jar ...]
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0push_wp80_game.ps1" %*
if errorlevel 1 pause
