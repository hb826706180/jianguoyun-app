# 数据库操作规范（强制）
## 1. GORM 规范
- 模型必须包含主键（ID uint `gorm:"primaryKey"`）、时间戳（CreatedAt/UpdatedAt）；
- 关联查询使用 Preload，禁止 N+1 查询；
- 批量操作使用 CreateInBatches/UpdateInBatches，批次大小≤100；
- 敏感操作（如扣库存）必须用事务；
- 所有数据库操作错误信息使用中文描述。

## 2. SQL 规范
- 禁止拼接 SQL 字符串，使用参数化查询；
- 高频查询字段加索引，避免全表扫描。