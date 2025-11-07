#!/usr/bin/env pwsh

# 快速启动脚本 - PowerShell版本

Write-Host "🚀 Jekyll Blog Quick Start" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

# 检查Docker是否运行
$dockerRunning = docker info 2>$null
if (-not $dockerRunning) {
    Write-Host "❌ Docker未运行，请先启动Docker Desktop" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Docker正在运行" -ForegroundColor Green

# 导入开发模块
if (Test-Path ".\blog-dev.psm1") {
    Import-Module .\blog-dev.psm1 -Force
    Write-Host "✅ 已导入开发模块" -ForegroundColor Green
} else {
    Write-Host "❌ 未找到开发模块文件" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "选择操作:" -ForegroundColor Yellow
Write-Host "1. 启动博客开发环境"
Write-Host "2. 创建新文章"
Write-Host "3. 创建新草稿"
Write-Host "4. 部署到GitHub Pages"
Write-Host "5. 查看帮助"
Write-Host "6. 退出"

$choice = Read-Host "请输入选择 (1-6)"

switch ($choice) {
    "1" {
        Write-Host "🚀 启动开发环境..." -ForegroundColor Green
        Start-Blog
    }
    "2" {
        $title = Read-Host "请输入文章标题"
        if ($title) {
            New-Post $title
        } else {
            Write-Host "❌ 标题不能为空" -ForegroundColor Red
        }
    }
    "3" {
        $title = Read-Host "请输入草稿标题"
        if ($title) {
            New-Draft $title
        } else {
            Write-Host "❌ 标题不能为空" -ForegroundColor Red
        }
    }
    "4" {
        Deploy-Blog
    }
    "5" {
        Show-BlogHelp
    }
    "6" {
        Write-Host "👋 再见!" -ForegroundColor Green
        exit 0
    }
    default {
        Write-Host "❌ 无效选择" -ForegroundColor Red
    }
}