# 快速配置指南（5 分钟完成）

## 第 1 步：创建钉钉机器人

1. 打开钉钉开发者后台：https://open.dingtalk.com
2. 创建应用 → 机器人
3. 获取 `Client ID` 和 `Client Secret`

⏱️ 预计用时：2 分钟

---

## 第 2 步：运行安装脚本

```bash
curl -fsSL https://raw.githubusercontent.com/yang1002378395-cmyk/dingtalk-connector-pro/main/install-pro.sh | bash
```

⏱️ 预计用时：1 分钟

---

## 第 3 步：配置 API Key

编辑配置文件：

```bash
nano ~/.openclaw/config.json
```

添加你的 AI API Key：

```json
{
  "model": "deepseek-chat",
  "apiKey": "your-api-key-here"
}
```

⏱️ 预计用时：1 分钟

---

## 第 4 步：启动服务

```bash
openclaw start
```

⏱️ 预计用时：30 秒

---

## 第 5 步：测试

在钉钉中发送消息给机器人：

```
你好
```

如果收到 AI 回复，恭喜你，配置成功！🎉

⏱️ 预计用时：30 秒

---

## 总用时：5 分钟

---

## 遇到问题？

### 问题 1：消息无响应

检查：
- OpenClaw 是否在运行：`openclaw status`
- 配置文件是否正确：`cat ~/.openclaw/config.json`
- 钉钉机器人是否启用 Stream 模式

### 问题 2：API Key 报错

检查：
- API Key 是否有效
- 是否有余额
- 模型名称是否正确

### 问题 3：安装失败

检查：
- Node.js 版本：`node -v`（需要 18+）
- npm 版本：`npm -v`
- 网络连接

---

## 获取帮助

- GitHub Issues: https://github.com/yang1002378395-cmyk/dingtalk-connector-pro/issues
- 付费支持: ¥99 起步（远程安装配置）
