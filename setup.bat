@echo off
setlocal
set "TARGET_DIR=%~dp0"
:: Remove trailing backslash if present
if "%TARGET_DIR:~-1%"=="\" set "TARGET_DIR=%TARGET_DIR:~0,-1%"

echo ======================================================
echo          🌙 Nythsleep One-Click Setup 🌙
echo ======================================================
echo.
echo This script will add the Nythsleep folder to your PATH
echo so you can run 'nythsleep' or 'nsleep' from anywhere.
echo.

:: Check for Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] WARNING: Python was not found on your system.
    echo Please install Python 3.8+ before using Nythsleep.
    echo.
)

:: Use PowerShell to update PATH safely (no 1024 char limit like setx)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$p='%TARGET_DIR%'; $u=[Environment]::GetEnvironmentVariable('Path','User'); ^
    if ($u -split ';' -notcontains $p) { ^
        if ($u -and -not $u.EndsWith(';')) { $u += ';' }; ^
        [Environment]::SetEnvironmentVariable('Path', $u + $p, 'User'); ^
        Write-Host '[+] Successfully added to User PATH!' -ForegroundColor Green; ^
        Write-Host '    You can now use nsleep or nythsleep from any NEW terminal window.' -ForegroundColor Green; ^
    } else { ^
        Write-Host '[i] Nythsleep is already in your PATH.' -ForegroundColor Cyan; ^
    }"

echo.
echo ======================================================
echo Setup Complete! Press any key to exit.
echo ======================================================
pause >nul
