# 坚果云文件操作 API

基于 Golang 的坚果云文件管理工具，通过 WebDAV 协议实现文件的增删改查操作。

## 功能特性

- ✅ 文件列表查询
- ✅ 文件上传/下载
- ✅ 文件删除
- ✅ 目录创建
- ✅ 配置文件管理
- ✅ 跨平台支持（Windows/Linux/macOS）

## 快速开始

### 1. 下载程序

从 [Releases](https://github.com/your-username/jianguoyun-app/releases) 下载对应系统的可执行文件。

### 2. 创建配置文件

在项目目录下创建 `config.ini` 文件：

```ini
[server]
port = 8081
mode = release

[jianguoyun]
webdav_url = https://dav.jianguoyun.com/dav/
username = your-email@example.com
password = your-webdav-password
```

### 3. 运行程序

```bash
# Windows
jianguoyun-app.exe

# Linux
./jianguoyun-app-linux

# macOS
./jianguoyun-app-darwin
```

## API 接口

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/files/list?path=/` | 列出目录内容 |
| POST | `/api/files/upload` | 上传文件 |
| GET | `/api/files/download?path=` | 下载文件 |
| DELETE | `/api/files/delete?path=` | 删除文件 |
| POST | `/api/files/mkdir` | 创建目录 |

详细 API 文档请查看 [api-doc.json](api-doc.json)。

## 使用示例

```bash
# 列出文件
curl http://localhost:8081/api/files/list?path=/

# 上传文件
curl -X POST http://localhost:8081/api/files/upload -F "path=/test.txt" -F "file=@./file.txt"

# 下载文件
curl -o out.txt "http://localhost:8081/api/files/download?path=/test.txt"

# 创建目录
curl -X POST http://localhost:8081/api/files/mkdir -F "path=/new-folder"
```

## 配置说明

### 服务器配置 [server]

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| port | 8081 | 服务端口 |
| host | "" | 监听地址（留空表示所有网卡） |
| mode | release | 运行模式（debug/release） |

### 坚果云配置 [jianguoyun]

| 配置项 | 说明 |
|--------|------|
| webdav_url | 坚果云 WebDAV 地址 |
| username | 坚果云账号（邮箱） |
| password | 坚果云应用密码（非登录密码） |

> **获取坚果云应用密码**：登录坚果云官网 → 账户信息 → 安全选项 → 应用密码

## 编译说明

如需自行编译，请确保已安装 Go 1.25.1+：

```bash
# Windows
go build -o jianguoyun-app.exe

# Linux
CGO_ENABLED=0 GOOS=linux go build -o jianguoyun-app-linux

# macOS
CGO_ENABLED=0 GOOS=darwin go build -o jianguoyun-app-darwin
```

## 注意事项

1. **应用密码**：必须使用坚果云应用专用密码，不能使用登录密码
2. **速率限制**：坚果云 API 有请求频率限制，请合理使用
3. **生产部署**：建议设置 `mode = release` 并配置合适的日志级别

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 问题反馈

如有问题或建议，请在 [Issues](https://github.com/your-username/jianguoyun-app/issues) 中反馈。
