# 多阶段构建 - 编译阶段
FROM golang:1.25-alpine AS builder

# 设置工作目录
WORKDIR /build

# 设置 Go 代理（加速下载）
ENV GOPROXY=https://goproxy.cn,direct
ENV GO111MODULE=on

# 安装 git（用于 go mod）
RUN apk add --no-cache git

# 复制 go.mod 和 go.sum
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码
COPY . .

# 编译程序
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o jianguoyun-app .

# 运行阶段
FROM alpine:latest

# 安装必要的证书
RUN apk --no-cache add ca-certificates tzdata

# 设置时区
ENV TZ=Asia/Shanghai

# 创建应用目录
WORKDIR /app

# 从编译阶段复制二进制文件
COPY --from=builder /build/jianguoyun-app .

# 复制示例配置文件
COPY --from=builder /build/config.ini.example ./config.ini.example

# 创建必要的目录
RUN mkdir -p /app/logs /app/cache /app/data

# 暴露端口
EXPOSE 8081

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8081/api/account/info || exit 1

# 启动服务
CMD ["./jianguoyun-app"]
