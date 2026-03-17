# 更新日志 (CHANGELOG)

本项目所有重要的功能更新都将在此文件中进行记录。

***

## 2026-03-16

### 新增

- 基于 WebDAV 协议的坚果云文件管理功能
- 文件上传功能 (支持大文件)
- 文件下载功能
- 文件删除功能
- 文件列表查询
- 批量文件删除功能
- 批量文件上传功能 (支持并发控制)
- 账户信息查询
- RESTful API 接口设计
- 跨平台支持 (Windows/Linux/macOS)
- 配置文件管理 (INI 格式)
- 结构化日志 (支持日志轮转)
- 错误码规范文档

### 技术栈

- Go 1.21+
- Gin 1.9+ (Web 框架)
- GORM 1.25+ (ORM 框架)
- WebDAV 协议
- MySQL 8.0+ (预留支持)

### API 接口

- **基础文件操作**
  - `GET /webdav/files/list` - 列出目录内容
  - `POST /webdav/files/upload` - 上传文件
  - `GET /webdav/files/download` - 下载文件
  - `DELETE /webdav/files/delete` - 删除文件
  - `POST /webdav/files/batch-delete` - 批量删除
- **账户管理**
  - `GET /webdav/account/info` - 获取账户信息
- **高级功能**
  - `POST /webdav/files/batch-upload` - 批量上传 (支持并发控制)

### 配置项

- **服务器配置**
  - 端口设置 (默认 8081)
  - 运行模式 (debug/release)
  - 上传大小限制 (MB)
- **坚果云配置**
  - WebDAV URL
  - 用户名/密码
  - 缓存目录
- **日志配置**
  - 日志级别 (debug/info/warn/error)
  - 日志文件大小限制
  - 日志备份数量
  - 日志压缩

### 安全特性

- 应用密码认证 (非登录密码)
- 敏感配置不提交到版本控制
- 错误信息规范化处理

***

## 版本说明

### 版本号规则

遵循语义化版本规范 (Semantic Versioning): `主版本号。次版本号。修订号`

- **主版本号**: 不兼容的 API 变更
- **次版本号**: 向后兼容的功能新增
- **修订号**: 向后兼容的问题修正

### 注意事项

- 使用坚果云应用专用密码，非登录密码
- 注意坚果云单文件大小限制 (免费用户 1GB)
- 批量操作时建议并发数不超过 5

