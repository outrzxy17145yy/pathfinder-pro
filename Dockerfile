# 使用官方 Node.js 20 版本 (Debian Slim 基础，兼容性较好)
FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 安装 Playwright 和系统依赖
# Playwright 需要 Chromium 运行所需的库
# curl 和 unzip 用于代码动态下载 cloudflared 和 xray
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# 复制 package.json 并安装依赖
COPY package.json package-lock.json* ./
RUN npm install

# 复制源代码
COPY index.js ./

# 安装 Playwright 的 Chromium 浏览器
RUN npx playwright install --with-deps chromium

# 暴露端口
# 4237 是主应用端口
# 8080 是代理服务器端口
EXPOSE 4237 8080

# 设置环境变量 (可选，代码里默认也有配置)
ENV NODE_ENV=production

# 启动应用
CMD ["node", "index.js"]
