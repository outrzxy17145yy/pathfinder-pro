注意：不要用 alpine，因为代码中下载的 Xray/Nezha 等二进制文件通常依赖 glibc

FROM node:20-slim

设置工作目录

WORKDIR /app

设置时区（可选，避免日志时间混乱）

ENV TZ=Asia/Shanghai

复制 package.json 和 package-lock.json

COPY package*.json ./

安装依赖

RUN npm install

复制项目其余文件

COPY . .

创建一个数据目录（可选，用于持久化数据，但你的代码默认写在根目录，这里仅作演示）
如果你想把数据持久化，通常直接挂载 /app 目录
声明端口
4237: Web控制面板
8080: 代理服务端口

EXPOSE 4237 8080

启动命令

CMD ["node", "index.js"]
