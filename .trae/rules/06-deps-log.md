# 依赖管理规范（强制）
1. 使用 go mod 管理依赖，禁止手动下载第三方包；
2. 依赖版本固定（如 github.com/gin-gonic/gin v1.9.1），禁止使用 latest；
3. 项目内部包导入使用模块名（如 import "project-name/pkg/response"）。

# 日志规范（强制）
1. 日志级别：DEBUG（调试）、INFO（常规）、WARN（警告）、ERROR（错误）；
2. 日志内容包含：时间、级别、TraceID、模块、具体信息（中文）；
3. 错误日志必须包含堆栈信息（如 logger.Error("查询用户失败", zap.Error(err))）；
4. 所有日志信息优先使用中文描述，技术术语可保留英文并附带中文解释。