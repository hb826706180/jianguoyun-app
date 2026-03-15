@echo off
chcp 65001 >nul
setlocal

echo ========================================
echo   编译 Linux 版本
echo ========================================

set PROJECT_NAME=jianguoyun-app
set OUTPUT_DIR=build
set OUTPUT_NAME=%PROJECT_NAME%-linux-amd64

REM 创建输出目录
if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

echo [1/2] 清理旧的构建文件...
if exist %OUTPUT_DIR%\%OUTPUT_NAME% del %OUTPUT_DIR%\%OUTPUT_NAME%

echo [2/2] 开始编译 Linux amd64 版本...
set GOOS=linux
set GOARCH=amd64
set CGO_ENABLED=0

go build -o %OUTPUT_DIR%\%OUTPUT_NAME% -ldflags="-s -w" %PROJECT_NAME%

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo   编译成功!
    echo   输出文件：%OUTPUT_DIR%\%OUTPUT_NAME%
    echo ========================================
) else (
    echo ========================================
    echo   编译失败!
    echo ========================================
)

endlocal
