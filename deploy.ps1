#!/usr/bin/env pwsh

# 部署脚本 - 简化版本管理和推送流程

# GitHub API Token (从环境变量获取 - 支持多种方式读取)
$githubToken = [System.Environment]::GetEnvironmentVariable("GITHUB_TOKEN", "User")
if (-not $githubToken) {
    $githubToken = [System.Environment]::GetEnvironmentVariable("GITHUB_TOKEN", "Machine")
}
if (-not $githubToken) {
    $githubToken = $env:GITHUB_TOKEN
}
if (-not $githubToken) {
    Write-Host "警告：未设置 GITHUB_TOKEN 环境变量，将跳过创建 GitHub Release" -ForegroundColor Yellow
    Write-Host "提示：请在系统环境变量中设置 GITHUB_TOKEN" -ForegroundColor Cyan
} else {
    Write-Host "成功读取 GITHUB_TOKEN 环境变量" -ForegroundColor Green
}

Write-Host "=== 坚果云项目部署脚本 ===" -ForegroundColor Green

# 完整部署流程
Write-Host "\n=== 完整部署模式 ===" -ForegroundColor Green

# 1. 检查当前状态
Write-Host "1. 检查当前状态..." -ForegroundColor Yellow
git status

# 2. 提示用户输入提交信息
$commitMessage = Read-Host "请输入提交信息:"
if ([string]::IsNullOrEmpty($commitMessage)) {
    $commitMessage = "更新部署文件"
}

# 3. 添加更改的文件
Write-Host "2. 添加更改的文件..." -ForegroundColor Yellow
git add build/ README.md api-doc.json .gitignore .dockerignore .trae/ Dockerfile ERROR_CODES.md LICENSE deploy.ps1 docker-compose.yml

# 4. 提交更改
Write-Host "3. 提交更改..." -ForegroundColor Yellow
git commit -m "$commitMessage"

# 5. 推送到远程仓库
Write-Host "4. 推送到远程仓库..." -ForegroundColor Yellow
git push origin master

# 6. 自动生成版本号（基于最新标签）
Write-Host "5. 自动生成版本号..." -ForegroundColor Yellow
$latestTag = git describe --tags --abbrev=0 2>$null
if ($latestTag) {
    # 解析版本号
    $versionParts = $latestTag -replace '^v', '' -split '\.'
    if ($versionParts.Length -eq 3) {
        $major = [int]$versionParts[0]
        $minor = [int]$versionParts[1]
        $patch = [int]$versionParts[2]
        $patch++
        $version = "v$major.$minor.$patch"
    } else {
        $version = "v1.0.0"
    }
} else {
    $version = "v1.0.0"
}

Write-Host "生成的版本号: $version" -ForegroundColor Green

$tagMessage = Read-Host "请输入标签描述 (默认: 版本 $version):"
if ([string]::IsNullOrEmpty($tagMessage)) {
    $tagMessage = "版本 $version"
}

Write-Host "6. 创建版本标签..." -ForegroundColor Yellow
git tag -a $version -m "$tagMessage"

Write-Host "7. 推送标签到远程仓库..." -ForegroundColor Yellow
git push origin $version

# 8. 创建GitHub Release
Write-Host "8. 创建GitHub Release..." -ForegroundColor Yellow
if (-not [string]::IsNullOrEmpty($githubToken)) {
    $owner = "hb826706180"
    $repo = "jianguoyun-app"
    $releaseTitle = Read-Host "请输入Release标题 (默认: $version):"
    if ([string]::IsNullOrEmpty($releaseTitle)) {
        $releaseTitle = $version
    }
    $releaseBody = Read-Host "请输入Release描述 (默认: $tagMessage):"
    if ([string]::IsNullOrEmpty($releaseBody)) {
        $releaseBody = $tagMessage
    }
    
    # 构建API请求
    $apiUrl = "https://api.github.com/repos/$owner/$repo/releases"
    $body = @{
        tag_name = $version
        name = $releaseTitle
        body = $releaseBody
        draft = $false
        prerelease = $false
    } | ConvertTo-Json
    
    try {
        Invoke-RestMethod -Uri $apiUrl -Method POST -Headers @{"Authorization"="token $githubToken"} -Body $body -ContentType "application/json"
        Write-Host "GitHub Release 创建成功!" -ForegroundColor Green
    } catch {
        Write-Host "GitHub Release 创建失败: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "请手动在GitHub网页上创建Release" -ForegroundColor Yellow
    }
} else {
    Write-Host "未设置GitHub API Token，跳过创建GitHub Release" -ForegroundColor Yellow
    Write-Host "请手动在GitHub网页上创建Release" -ForegroundColor Yellow
}


Write-Host "\n=== 操作完成! ===" -ForegroundColor Green
