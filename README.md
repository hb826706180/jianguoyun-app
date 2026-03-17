# 坚果云文件操作 API

基于 Golang 的坚果云文件管理工具，通过 WebDAV 协议实现文件的增删改查操作。

## 功能特性

### 核心功能
- ✅ 文件列表查询
- ✅ 文件上传/下载
- ✅ 文件删除
- ✅ 目录创建
- ✅ 账户信息查询
- ✅ 批量操作（支持并发控制）
- ✅ 断点续传支持

### 高级功能
- ✅ 自动备份（定时任务）
- ✅ 单向/双向同步
- ✅ 配置项加密存储
- ✅ API 请求速率限制
- ✅ 日志文件轮转
- ✅ Docker 部署支持

### 技术特性
- ✅ 跨平台支持（Windows/Linux/macOS）
- ✅ 配置文件管理
- ✅ 单元测试
- ✅ 完整的错误码文档

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

### 基础文件操作

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/webdav/files/list?path=/` | 列出目录内容 |
| POST | `/webdav/files/upload` | 上传文件 (form-data: path, file) |
| GET | `/webdav/files/download?path=` | 下载文件 |
| DELETE | `/webdav/files/delete?path=` | 删除文件 |
| POST | `/webdav/files/mkdir` | 创建目录 (form-data: path) |

### 账户管理

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/webdav/account/info` | 获取账户信息 |



### 高级功能

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/webdav/files/batch-upload` | 批量上传 |
| POST | `/webdav/files/batch-delete` | 批量删除 |

详细 API 文档请查看 [api-doc.json](api-doc.json) 和 [ERROR_CODES.md](ERROR_CODES.md)。

## 使用示例

### 基础操作

```bash
# 列出文件
curl http://localhost:8081/webdav/files/list?path=/

# 上传文件
curl -X POST http://localhost:8081/webdav/files/upload -F "path=/test.txt" -F "file=@./file.txt"

# 下载文件
curl -o out.txt "http://localhost:8081/webdav/files/download?path=/test.txt"

# 删除文件
curl -X DELETE "http://localhost:8081/webdav/files/delete?path=/test.txt"

# 创建目录
curl -X POST http://localhost:8081/webdav/files/mkdir -F "path=/new-folder"
```

### 账户管理

```bash
# 获取账户信息
curl http://localhost:8081/webdav/account/info
```



### 批量操作

```bash
# 批量上传（并发数 5）
curl -X POST "http://localhost:8081/webdav/files/batch-upload?concurrency=5" \
  -F "base_path=/backup" \
  -F "files=@file1.txt" \
  -F "files=@file2.txt" \
  -F "files=@file3.txt"

# 批量删除
curl -X POST http://localhost:8081/webdav/files/batch-delete \
  -H "Content-Type: application/json" \
  -d '["/file1.txt", "/file2.txt", "/file3.txt"]'
```

## 配置说明

### 服务器配置 [server]

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| port | 8081 | 服务端口 |
| host | "" | 监听地址（留空表示所有网卡） |
| mode | release | 运行模式（debug/release） |

### MySQL 配置 [mysql]（预留）

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| host | 127.0.0.1 | 数据库地址 |
| port | 3306 | 数据库端口 |
| user | root | 用户名 |
| password | - | 密码 |
| database | jianguoyun_db | 数据库名 |
| max_idle_conns | 10 | 最大空闲连接 |
| max_open_conns | 100 | 最大打开连接 |
| conn_max_lifetime | 3600 | 连接最大生命周期（秒） |

### 坚果云配置 [jianguoyun]

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| webdav_url | https://dav.jianguoyun.com/dav/ | WebDAV 地址 |
| username | - | 坚果云账号（邮箱） |
| password | - | 坚果云应用密码（非登录密码） |
| upload_max_size | 100 | 上传大小限制 (MB) |
| cache_dir | ./cache | 缓存目录 |

### 日志配置 [log]

| 配置项 | 默认值 | 说明 |
|--------|--------|------|
| level | info | 日志级别（debug/info/warn/error） |
| file_path | ./logs/app.log | 日志文件路径 |
| max_size | 100 | 单个日志文件最大大小 (MB) |
| max_backups | 5 | 最大备份数量 |
| compress | true | 是否压缩备份日志 |

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

或使用编译脚本：

```bash
# Windows
编译 wins.bat

# Linux
编译 linux.bat

# 所有平台
编译 all.bat
```

## Docker 部署

### 使用 Docker Compose（推荐）

```bash
# 启动服务
docker-compose up -d

# 查看日志
docker-compose logs -f

# 停止服务
docker-compose down
```

### 使用 Docker

```bash
# 构建镜像
docker build -t jianguoyun-app .

# 运行容器
docker run -d \
  -p 8081:8081 \
  -v $(pwd)/config.ini:/app/config.ini \
  -v $(pwd)/logs:/app/logs \
  -v $(pwd)/cache:/app/cache \
  jianguoyun-app
```

## 项目结构

```
jianguoyun/
├── build/                  # 编译输出目录（保留各平台编译产物）
├── pkg/
│   ├── config/             # 配置模块
│   │   └── config.go       # 配置加载与访问
│   ├── file/               # 文件操作模块
│   │   ├── handlers/       # API 处理器
│   │   ├── models/         # 数据模型
│   │   └── services/       # 业务逻辑（含备份/同步/断点续传）
│   ├── middleware/         # 中间件（速率限制）
│   ├── routes/             # 路由配置（集中管理）
│   └── utils/              # 工具函数（加密/日志轮转）
├── .aiassistant/           # AI 助手配置
├── .idea/                  # IDE 配置
├── config.ini.example      # 配置示例（模板文件）
├── main.go                 # 程序入口
├── api-doc.json            # OpenAPI 文档
├── ERROR_CODES.md          # 错误码文档
├── Dockerfile              # Docker 构建文件
├── docker-compose.yml      # Docker Compose 配置
├── go.mod                  # Go 模块定义
├── README.md               # 本文件
└── LICENSE                 # 许可证
```

**不生成/忽略的目录：**
- `cache/` - 缓存目录（运行时创建）
- `logs/` - 日志目录（运行时创建）
- `config.ini` - 实际配置文件（不提交）
- `dist/` - 旧发布包目录（已清理）

## 项目规划

### 项目目标
开发一个基于 Golang 的坚果云文件操作 API 服务，通过 WebDAV 协议实现文件管理功能。

### 技术栈
| 组件 | 版本 | 说明 |
|------|------|------|
| Go | 1.25.1 | 编程语言 |
| Gin | 1.12.0 | Web 框架 |
| ini | 1.67.1 | 配置文件解析 |
| WebDAV | - | 文件传输协议 |

## 进度记录

| 时间 | 任务 | 状态 | 说明 |
|------|------|------|------|
| 2026-03-15 | 创建项目结构 | ✅ 已完成 | 基础目录结构搭建 |
| 2026-03-15 | 实现文件操作 API | ✅ 已完成 | 增删改查功能 |
| 2026-03-15 | 创建配置文件模块 | ✅ 已完成 | config.ini + pkg/config |
| 2026-03-15 | 创建编译脚本 | ✅ 已完成 | Windows/Linux 编译 |
| 2026-03-15 | 更新 API 文档 | ✅ 已完成 | api-doc.json v1.0.0 |
| 2026-03-15 | 准备公开发布 | ✅ 已完成 | 创建 README、LICENSE、发布脚本 |
| 2026-03-15 | 功能增强开发 | ✅ 已完成 | 新增账户信息、回收站、批量操作、断点续传、备份同步、加密、限流、日志轮转、Docker 部署、单元测试、错误码文档 |
| 2026-03-15 | 路由重构 | ✅ 已完成 | 将路由代码独立到 pkg/routes，便于扩展维护 |
| 2026-03-15 | 命名规范修正 | ✅ 已完成 | 所有函数和变量使用中文命名，公开函数使用 A_ 前缀 |
| 2026-03-15 | 文档合并 | ✅ 已完成 | 将说明文档内容整合到 README，删除重复文档 |

## 待办任务

- [ ] 添加 MySQL 数据库支持（配置已预留）
- [ ] 添加日志文件轮转功能
- [ ] 添加单元测试
- [ ] 添加 Docker 部署配置

## 注意事项

1. **应用密码**：必须使用坚果云应用专用密码，不能使用登录密码
2. **配置文件安全**：`config.ini` 已加入 `.gitignore`，请勿提交到公开仓库
3. **速率限制**：坚果云 API 有请求频率限制，建议不低于 1 次/秒
4. **生产部署**：建议设置 `mode = release` 并配置合适的日志级别
5. **文件大小**：注意坚果云单文件大小限制（免费用户 1GB）
6. **并发控制**：批量操作时建议 concurrency 不超过 5

## 常见问题

**Q: 如何获取坚果云授权码？**

A: 登录坚果云官网 → 账户信息 → 安全选项 → 应用密码

**Q: 编译失败怎么办？**

A: 运行 `go mod tidy` 更新依赖

**Q: 如何修改服务端口？**

A: 修改 `config.ini` 中 `[server]` 的 `port` 配置项

**Q: 日志文件太大怎么办？**

A: 配置 `[log]` 段的 `max_size` 和 `max_backups` 参数启用日志轮转

**Q: Docker 部署后无法访问？**

A: 确保防火墙开放 8081 端口，检查容器日志 `docker-compose logs`

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 问题反馈

如有问题或建议，请在 [Issues](https://github.com/your-username/jianguoyun-app/issues) 中反馈。

## 致谢

感谢 [坚果云](https://www.jianguoyun.com/) 提供的云存储服务。
