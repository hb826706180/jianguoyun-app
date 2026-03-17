#!/bin/bash

# 构建脚本 - 编译全平台版本

# 创建构建目录
mkdir -p build

# 设置Go环境变量
export GO111MODULE=on

# 编译Windows版本
echo "编译Windows x86_64版本..."
go build -o build/jianguoyun-app-windows-amd64.exe main.go

# 编译Linux版本
echo "编译Linux x86_64版本..."
GOOS=linux GOARCH=amd64 go build -o build/jianguoyun-app-linux-amd64 main.go

# 编译macOS版本
echo "编译macOS x86_64版本..."
GOOS=darwin GOARCH=amd64 go build -o build/jianguoyun-app-darwin-amd64 main.go

# 编译ARM版本（可选）
echo "编译Windows ARM64版本..."
GOOS=windows GOARCH=arm64 go build -o build/jianguoyun-app-windows-arm64.exe main.go

echo "编译Linux ARM64版本..."
GOOS=linux GOARCH=arm64 go build -o build/jianguoyun-app-linux-arm64 main.go

echo "编译macOS ARM64版本..."
GOOS=darwin GOARCH=arm64 go build -o build/jianguoyun-app-darwin-arm64 main.go

echo "构建完成！"
ls -la build/