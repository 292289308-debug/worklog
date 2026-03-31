# 日常工作日志系统

## 功能规划

### 核心字段
- 日期 (Date)
- 时间 (Time)
- 工作内容 (Work content)
- 备件 (Spare parts)
- 工具 (Tools)
- 注意事项 (Precautions)
- 工作步骤 (Work steps)
- 工作图片 (Work images - 支持上传/插入)

### 技术方案
- 单HTML文件 + TailwindCSS CDN
- localStorage本地存储
- 图片Base64存储
- 数据可导出为JSON/打印

### 页面结构
1. 顶部：标题 + 新增按钮
2. 左侧：日志列表（按日期排序）
3. 右侧：日志详情表单
4. 支持新增、编辑、删除、搜索

## 交付物
- `worklog.html` - 完整的单文件应用
