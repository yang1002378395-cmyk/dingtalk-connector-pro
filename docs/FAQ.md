# 常见问题（FAQ）

## 安装相关

### Q1: 支持哪些操作系统？

**A**: 支持 macOS、Linux、Windows（WSL）。

推荐系统：
- macOS 12+
- Ubuntu 20.04+
- Windows 10/11 + WSL2

---

### Q2: 需要什么前置条件？

**A**:
- Node.js 18+
- npm 或 pnpm
- 钉钉开发者账号
- AI API Key（DeepSeek/OpenAI 等）

---

### Q3: 安装脚本执行失败？

**A**: 检查以下几点：
1. 网络是否正常
2. Node.js 版本是否 18+
3. 是否有写入权限

```bash
# 检查 Node.js 版本
node -v

# 检查权限
ls -la ~/.openclaw
```

---

## 配置相关

### Q4: 如何获取钉钉 Client ID？

**A**:
1. 登录 https://open.dingtalk.com
2. 创建应用 → 机器人
3. 在「凭证与基础信息」中查看

---

### Q5: 如何配置多个 AI 模型？

**A**: 编辑 `~/.openclaw/config.json`：

```json
{
  "providers": {
    "deepseek": {
      "apiKey": "sk-xxx"
    },
    "openai": {
      "apiKey": "sk-yyy"
    }
  },
  "defaultModel": "deepseek-chat"
}
```

---

### Q6: 如何启用流式响应？

**A**: 默认已启用。如需关闭：

```json
{
  "streaming": false
}
```

---

## 使用相关

### Q7: 支持哪些消息类型？

**A**:
- ✅ 文本消息
- ✅ AI Card（流式）
- ✅ 图片
- ✅ 文件（PDF/Word/Excel）
- ✅ Markdown

---

### Q8: 如何清空对话历史？

**A**: 发送以下命令之一：
- `/new`
- `/reset`
- `/clear`
- `新会话`
- `重新开始`

---

### Q9: 群聊中如何使用？

**A**: 在群聊中 @机器人 即可。

示例：
```
@AI助手 帮我写一个 Python 脚本
```

---

### Q10: 如何处理敏感信息？

**A**:
1. 不要在对话中发送密码、密钥等
2. 使用环境变量存储敏感配置
3. 定期清理日志文件

---

## 故障排除

### Q11: 消息发送成功但无响应？

**A**: 检查：
1. OpenClaw 是否运行：`openclaw status`
2. 日志是否有错误：`tail -f ~/.openclaw/logs/openclaw.log`
3. API Key 是否有效

---

### Q12: WebSocket 断开？

**A**:
- Pro 版已内置自动重连
- 如仍断开，检查网络稳定性
- 可配置重连间隔：

```json
{
  "reconnectInterval": 5000
}
```

---

### Q13: 消息重复处理？

**A**:
- Pro 版已修复消息去重问题
- 如仍重复，检查是否启动了多个实例

```bash
# 检查实例
ps aux | grep openclaw
```

---

## 商业支持

### Q14: 是否提供付费服务？

**A**: 是的。

| 服务 | 价格 | 说明 |
|------|------|------|
| 基础安装 | ¥99 | 远程安装配置 |
| 高级配置 | ¥299 | 多账号 + 自定义 |
| 企业定制 | ¥999-2999 | 专属功能开发 |
| 技术培训 | ¥499/小时 | OpenClaw 开发 |
| 专属支持 | ¥1999/月 | 7x24 技术支持 |

---

### Q15: 如何联系开发者？

**A**:
- GitHub Issues: https://github.com/yang1002378395-cmyk/dingtalk-connector-pro/issues
- 微信: 添加好友备注「钉钉AI」

---

## 没找到答案？

在 GitHub 提 Issue，我会尽快回复！

https://github.com/yang1002378395-cmyk/dingtalk-connector-pro/issues
