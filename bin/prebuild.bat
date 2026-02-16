@echo off
REM ─────────────────────────────────────────────────────────────
REM  O.R.I.O.N. All-In-One Prebuild — Windows launcher
REM
REM  Usage:  prebuild.bat
REM          prebuild.bat --install-dir "D:\Projects"
REM          prebuild.bat --branch dev
REM          prebuild.bat --skip-ollama --skip-python --skip-playwright
REM ─────────────────────────────────────────────────────────────

set "SCRIPT_DIR=%~dp0"
set "PS_ARGS="

:parse_args
if "%~1"=="" goto run
if /i "%~1"=="--skip-ollama"      set "PS_ARGS=%PS_ARGS% -SkipOllama"       & shift & goto parse_args
if /i "%~1"=="--skip-python"      set "PS_ARGS=%PS_ARGS% -SkipPython"       & shift & goto parse_args
if /i "%~1"=="--skip-playwright"  set "PS_ARGS=%PS_ARGS% -SkipPlaywright"   & shift & goto parse_args
if /i "%~1"=="--skip-clone"       set "PS_ARGS=%PS_ARGS% -SkipClone"        & shift & goto parse_args
if /i "%~1"=="--install-dir"      set "PS_ARGS=%PS_ARGS% -InstallDir '%~2'" & shift & shift & goto parse_args
if /i "%~1"=="--branch"           set "PS_ARGS=%PS_ARGS% -Branch '%~2'"     & shift & shift & goto parse_args
echo Unknown argument: %~1
shift
goto parse_args

:run
powershell -ExecutionPolicy Bypass -NoProfile -File "%SCRIPT_DIR%prebuild.ps1"%PS_ARGS%
exit /b %ERRORLEVEL%
