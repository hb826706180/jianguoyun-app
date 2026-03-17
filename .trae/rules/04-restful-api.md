# RESTful 接口规范（强制）
## 1. URL 规范
- 资源名用复数名词（如 /users、/goods），禁止动词（如 /getUser）；
- 层级用 / 分隔，如 /users/123/orders（用户123的订单）；
- 过滤/分页参数用 query（如 /users?page=1&size=10）。

## 2. 响应规范
### 统一响应结构体：
type Response struct {
    Code    int         `json:"code"`    // 0成功，4xx参数错误，5xx服务器错误
    Message string      `json:"message"` // 提示信息（中文）
    Data    interface{} `json:"data"`    // 业务数据
    TraceID string      `json:"trace_id"`// 链路ID（排查问题用）
}

### 错误码规范：
- 0：成功；
- 400：参数错误；
- 401：未登录；
- 403：无权限；
- 404：资源不存在；
- 500：服务器内部错误。