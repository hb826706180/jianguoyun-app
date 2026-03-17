工程结构规范（强制）
project-name/
├─ build/             // 构建相关
│   ├─ scripts/       // 编译脚本
│   └─ config/        // 构建配置
├─ api/               // 接口层（控制器）
│   ├─ handler/       // 接口处理函数（按模块分）
│   │   ├─ user.go    // 用户模块接口
│   │   └─ goods.go   // 商品模块接口
│   ├─ router/        // 路由注册
│   │   └─ router.go  // 路由配置
│   └─ middleware/    // 中间件
│       ├─ auth.go    // 认证中间件
│       ├─ cors.go    // CORS中间件
│       └─ logger.go  // 日志中间件
├─ service/           // 业务逻辑层
├─ model/             // 数据模型层（GORM）
├─ dao/               // 数据访问层
├─ pkg/               // 公共工具包
├─ config/            // 配置文件（yaml/toml）
├─ test/              // 测试目录
├─ docs/              // 文档目录
├─ vendor/            // 依赖管理（go mod vendor生成）
├─ apifox.json        // Apifox接口文档（兼容旧版本）
├─ main.go            // 启动文件
├─ go.mod             // 依赖管理
├─ go.sum             // 依赖校验
├─ .gitignore         // Git忽略文件
├─ CHANGELOG.md	      // 更新日志,便于记录项目版本功能差异,如新增/优化等
└─ README.md          // 项目说明文档
