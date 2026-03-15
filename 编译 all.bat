@echo off
chcp 65001 >nul
setlocal

echo ========================================
echo   编译所有平台版本
echo ========================================

set PROJECT_NAME=jianguoyun-app
set OUTPUT_DIR=build

REM 创建输出目录
if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

set CGO_ENABLED=0

echo.
echo --- 编译 Windows amd64 ---
set GOOS=windows
set GOARCH=amd64
go build -o %OUTPUT_DIR%\%PROJECT_NAME%-windows-amd64.exe -ldflags="-s -w" %PROJECT_NAME%
if %ERRORLEVEL% EQU 0 (
    echo [OK] Windows amd64 编译成功
) else (
    echo [FAIL] Windows amd64 编译失败
)

echo.
echo --- 编译 Windows arm64 ---
set GOOS=windows
set GOARCH=arm64
go build -o %OUTPUT_DIR%\%PROJECT_NAME%-windows-arm64.exe -ldflags="-s -w" %PROJECT_NAME%
if %ERRORLEVEL% EQU 0 (
    echo [OK] Windows arm64 编译成功
) else (
    echo [FAIL] Windows arm64 编译失败
)

echo.
echo --- 编译 Linux amd64 ---
set GOOS=linux
set GOARCH=amd64
go build -o %OUTPUT_DIR%\%PROJECT_NAME%-linux-amd64 -ldflags="-s -w" %PROJECT_NAME%
if %ERRORLEVEL% EQU 0 (
    echo [OK] Linux amd64 编译成功
) else (
    echo [FAIL] Linux amd64 编译失败
)

echo.
echo --- 编译 Linux arm64 ---
set GOOS=linux
set GOARCH=arm64
go build -o %OUTPUT_DIR%\%PROJECT_NAME%-linux-arm64 -ldflags="-s -w" %PROJECT_NAME%
if %ERRORLEVEL% EQU 0 (
    echo [OK] Linux arm64 编译成功
) else (
    echo [FAIL] Linux arm64 编译失败
)

echo.
echo --- 编译 macOS amd64 ---
set GOOS=darwin
set GOARCH=amd64
go build -o %OUTPUT_DIR%\%PROJECT_NAME%-darwin-amd64 -ldflags="-s -w" %PROJECT_NAME%
if %ERRORLEVEL% EQU 0 (
    echo [OK] macOS amd64 编译成功
) else (
    echo [FAIL] macOS amd64 编译失败
)

echo.
echo --- 编译 macOS arm64 (M1/M2) ---
set GOOS=darwin
set GOARCH=arm64
go build -o %OUTPUT_DIR%\%PROJECT_NAME%-darwin-arm64 -ldflags="-s -w" %PROJECT_NAME%
if %ERRORLEVEL% EQU 0 (
    echo [OK] macOS arm64 编译成功
) else (
    echo [FAIL] macOS arm64 编译失败
)

echo.
echo ========================================
echo   编译完成，输出目录：%OUTPUT_DIR%
echo ========================================

dir %OUTPUT_DIR%

endlocal
