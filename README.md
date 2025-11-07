# Jekyll Docker 博客开发指南

这是一个使用 Jekyll + Docker 开发的 GitHub Pages 个人博客项目。

## 🚀 快速开始

### 1. 安装依赖

确保您的系统已安装：
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Git](https://git-scm.com/)

### 2. 克隆项目

```bash
git clone https://github.com/JianlongLei/JianlongLei.github.io.git
cd JianlongLei.github.io
```

### 3. 启动开发环境

#### 方法一：使用 PowerShell 模块（推荐）

```powershell
# 导入开发模块
Import-Module .\blog-dev.psm1

# 查看可用命令
Show-BlogHelp

# 启动开发服务器
Start-Blog
```

#### 方法二：直接使用 Docker Compose

```bash
docker-compose up --build
```

### 4. 访问博客

开发服务器启动后，访问：
- 博客主页：http://localhost:4000
- LiveReload会自动刷新页面

## 📝 内容管理

### 创建新文章

```powershell
# 使用PowerShell模块
New-Post "我的新文章标题"

# 或手动创建
# 在 _posts 目录下创建文件：YYYY-MM-DD-title.md
```

### 创建草稿

```powershell
# 使用PowerShell模块
New-Draft "草稿标题"

# 草稿文件在 _drafts 目录下
# 开发环境会显示草稿（使用 --drafts 参数）
```

### 文章格式

```yaml
---
layout: post
title: "文章标题"
date: 2025-11-07 12:00:00 +0800
categories: 分类
tags: [标签1, 标签2]
---

文章内容使用 Markdown 语法...
```

## 🔧 开发命令

```powershell
# 导入开发模块
Import-Module .\blog-dev.psm1

# 启动开发服务器
Start-Blog

# 停止服务器
Stop-Blog

# 重启服务器
Restart-Blog

# 创建新文章
New-Post "文章标题"

# 创建草稿
New-Draft "草稿标题"

# 部署到GitHub Pages
Deploy-Blog

# 清理Docker资源
Clean-Blog
```

## 🚀 部署到 GitHub Pages

### 自动部署

每次推送到 `main` 分支时，GitHub Pages 会自动构建和部署：

```powershell
# 使用部署命令
Deploy-Blog

# 或手动执行
git add .
git commit -m "更新博客内容"
git push origin main
```

### 部署流程

1. 本地开发和测试
2. 提交更改到 Git
3. 推送到 GitHub
4. GitHub Pages 自动构建和部署
5. 几分钟后在 https://jianglonglei.github.io 查看更新

## 📁 项目结构

```
├── _config.yml          # Jekyll 配置文件
├── _posts/              # 博客文章
├── _drafts/             # 草稿文章
├── _layouts/            # 页面布局模板
├── _includes/           # 可重用的页面片段
├── _sass/               # Sass 样式文件
├── assets/              # 静态资源（图片、CSS、JS）
├── index.md             # 首页
├── about.md             # 关于页面
├── Dockerfile           # Docker 构建文件
├── docker-compose.yml   # Docker Compose 配置
├── Gemfile              # Ruby 依赖
└── blog-dev.psm1        # 开发工具脚本
```

## ⚙️ 配置说明

### Jekyll 配置 (_config.yml)

- 修改 `title`、`email`、`description` 等基本信息
- 配置社交媒体链接
- 自定义permalink格式
- 添加插件和主题

### Docker 配置

- `Dockerfile`：定义构建环境
- `docker-compose.yml`：本地开发配置
- 支持热重载和LiveReload

## 🎨 自定义主题

1. 修改 `_config.yml` 中的 `theme` 设置
2. 或创建自定义布局文件在 `_layouts/` 目录
3. 添加自定义样式到 `_sass/` 目录
4. 静态资源放在 `assets/` 目录

## 🔍 SEO 优化

已包含的SEO插件：
- `jekyll-seo-tag`：自动生成meta标签
- `jekyll-sitemap`：生成网站地图
- `jekyll-feed`：RSS订阅源

## 📊 分析和监控

可以添加：
- Google Analytics
- Google Search Console
- 网站性能监控

## 🐛 常见问题

### Docker相关

```bash
# 如果遇到权限问题
docker-compose down -v
docker system prune -f

# 重新构建
docker-compose up --build
```

### Jekyll相关

```bash
# 清除缓存
docker-compose exec jekyll bundle exec jekyll clean

# 更新依赖
docker-compose exec jekyll bundle update
```

## 📚 参考资源

- [Jekyll 官方文档](https://jekyllrb.com/docs/)
- [GitHub Pages 文档](https://docs.github.com/en/pages)
- [Liquid 模板语言](https://shopify.github.io/liquid/)
- [Markdown 语法](https://www.markdownguide.org/)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License