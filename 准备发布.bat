@echo off
chcp 65001 >nul
setlocal

echo ========================================
echo   准备发布版本
echo ========================================

set VERSION=1.0.0
set DIST_DIR=dist\jianguoyun-app-v%VERSION%

echo [1/4] 清理旧的发布包...
if exist dist rmdir /s /q dist

echo [2/4] 创建发布目录...
mkdir %DIST_DIR%
mkdir %DIST_DIR%\build

echo [3/4] 复制发布文件...
copy README.md %DIST_DIR%\
copy LICENSE %DIST_DIR%\
copy api-doc.json %DIST_DIR%\
copy config.ini.example %DIST_DIR%\
copy 说明文档.md %DIST_DIR%\
copy build\*.exe %DIST_DIR%\build\
copy build\jianguoyun-app-linux* %DIST_DIR%\build\
copy build\jianguoyun-app-darwin* %DIST_DIR%\build\

echo [4/4] 创建压缩包...
powershell -Command "Compress-Archive -Path '%DIST_DIR%' -DestinationPath 'dist\jianguoyun-app-v%VERSION%.zip' -Force"

echo ========================================
echo   发布包创建完成!
echo   位置：dist\jianguoyun-app-v%VERSION%.zip
echo ========================================

dir dist

endlocal
