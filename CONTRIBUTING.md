# 贡献指南

感谢你对钉钉 OpenClaw 连接器 Pro 版的兴趣！

## 如何贡献

### 报告 Bug

1. 在 [GitHub Issues](https://github.com/yang1002378395-cmyk/dingtalk-connector-pro/issues) 搜索是否已有相同问题
2. 如果没有，创建新 Issue，包含：
   - 问题描述
   - 复现步骤
   - 期望行为
   - 实际行为
   - 环境信息（OS、Node.js 版本等）

### 提交代码

1. Fork 本仓库
2. 创建分支：`git checkout -b feature/your-feature`
3. 提交更改：`git commit -m "Add your feature"`
4. 推送分支：`git push origin feature/your-feature`
5. 创建 Pull Request

### 代码规范

- 使用 TypeScript
- 遵循 ESLint 规则
- 添加必要的注释
- 编写单元测试

### 提交信息格式

```
<type>: <subject>

<body>

<footer>
```

类型：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式
- `refactor`: 重构
- `test`: 测试
- `chore`: 构建/工具

示例：
```
feat: 添加消息重试机制

- 添加最多 3 次重试
- 支持自定义重试间隔
- 添加重试日志

Closes #123
```

## 开发环境

### 安装依赖

```bash
npm install
```

### 运行测试

```bash
npm test
```

### 类型检查

```bash
npm run type-check
```

## 行为准则

- 尊重所有贡献者
- 接受建设性批评
- 关注对社区最有利的事情

## 许可证

本仓库采用 MIT 许可证。
