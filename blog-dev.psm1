# Jekyll Blog Development Scripts

# 启动开发服务器
function Start-Blog {
    Write-Host "🚀 启动Jekyll博客开发环境..." -ForegroundColor Green
    docker-compose up --build
}

# 停止开发服务器
function Stop-Blog {
    Write-Host "⏹️  停止Jekyll博客..." -ForegroundColor Yellow
    docker-compose down
}

# 重新构建并启动
function Restart-Blog {
    Write-Host "🔄 重新启动Jekyll博客..." -ForegroundColor Blue
    docker-compose down
    docker-compose up --build
}

# 创建新文章
function New-Post {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title
    )
    
    $date = Get-Date -Format "yyyy-MM-dd"
    $slug = $Title.ToLower() -replace '\s+', '-' -replace '[^\w\-]', ''
    $filename = "${date}-${slug}.md"
    $filepath = "_posts/$filename"
    
    $content = @"
---
layout: post
title: "$Title"
date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss +0800")
categories: blog
tags: []
---

# $Title

在这里写您的文章内容...

"@
    
    New-Item -Path $filepath -ItemType File -Value $content -Force
    Write-Host "✅ 新文章已创建: $filepath" -ForegroundColor Green
}

# 创建新草稿
function New-Draft {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title
    )
    
    $slug = $Title.ToLower() -replace '\s+', '-' -replace '[^\w\-]', ''
    $filename = "${slug}.md"
    $filepath = "_drafts/$filename"
    
    $content = @"
---
layout: post
title: "$Title"
categories: draft
tags: []
---

# $Title

在这里写您的草稿内容...

"@
    
    New-Item -Path $filepath -ItemType File -Value $content -Force
    Write-Host "✅ 新草稿已创建: $filepath" -ForegroundColor Green
}

# 部署到GitHub Pages
function Deploy-Blog {
    Write-Host "🚀 部署博客到GitHub Pages..." -ForegroundColor Green
    git add .
    $commitMessage = Read-Host "请输入提交信息"
    if ([string]::IsNullOrEmpty($commitMessage)) {
        $commitMessage = "Update blog $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    }
    git commit -m $commitMessage
    git push origin main
    Write-Host "✅ 部署完成！您的博客将在几分钟内更新。" -ForegroundColor Green
}

# 清理Docker资源
function Clean-Blog {
    Write-Host "🧹 清理Docker资源..." -ForegroundColor Yellow
    docker-compose down -v
    docker system prune -f
    Write-Host "✅ 清理完成！" -ForegroundColor Green
}

# 显示帮助信息
function Show-BlogHelp {
    Write-Host @"
📚 Jekyll Blog 开发命令：

基本操作:
  Start-Blog     - 启动开发服务器 (http://localhost:4000)
  Stop-Blog      - 停止开发服务器
  Restart-Blog   - 重新启动开发服务器

内容管理:
  New-Post "标题"   - 创建新文章
  New-Draft "标题"  - 创建新草稿

部署:
  Deploy-Blog    - 提交并推送到GitHub Pages

维护:
  Clean-Blog     - 清理Docker资源
  Show-BlogHelp  - 显示此帮助信息

使用示例:
  PS> New-Post "我的新文章"
  PS> Start-Blog
  PS> Deploy-Blog

"@ -ForegroundColor Cyan
}

# 导出函数
Export-ModuleMember -Function Start-Blog, Stop-Blog, Restart-Blog, New-Post, New-Draft, Deploy-Blog, Clean-Blog, Show-BlogHelp

Write-Host "✅ Jekyll Blog 开发模块已加载！输入 'Show-BlogHelp' 查看可用命令。" -ForegroundColor Green