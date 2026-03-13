# 性能监控指南

钉钉 OpenClaw 连接器 Pro 版内置性能监控，帮助你了解系统运行状态。

## 监控指标

### 1. 消息处理延迟

```json
{
  "metric": "message_latency",
  "value": 125,
  "unit": "ms",
  "description": "从收到消息到开始处理的时间"
}
```

**正常范围**: < 500ms
**警告范围**: 500ms - 2s
**异常范围**: > 2s

---

### 2. AI 响应时间

```json
{
  "metric": "ai_response_time",
  "value": 2500,
  "unit": "ms",
  "description": "AI API 响应时间"
}
```

**正常范围**: < 3s
**警告范围**: 3s - 10s
**异常范围**: > 10s

---

### 3. 消息队列长度

```json
{
  "metric": "queue_length",
  "value": 5,
  "unit": "messages",
  "description": "待处理消息数量"
}
```

**正常范围**: < 10
**警告范围**: 10 - 50
**异常范围**: > 50

---

### 4. WebSocket 连接状态

```json
{
  "metric": "ws_connected",
  "value": true,
  "description": "钉钉 WebSocket 连接状态"
}
```

---

### 5. 错误率

```json
{
  "metric": "error_rate",
  "value": 0.02,
  "unit": "%",
  "description": "消息处理错误率"
}
```

**正常范围**: < 1%
**警告范围**: 1% - 5%
**异常范围**: > 5%

---

## 查看监控数据

### 方法 1: 日志文件

```bash
tail -f ~/.openclaw/logs/metrics.log
```

### 方法 2: API 端点

```bash
curl http://localhost:3000/metrics
```

### 方法 3: OpenClaw CLI

```bash
openclaw status
```

---

## 告警配置

编辑 `~/.openclaw/config.json`:

```json
{
  "alerts": {
    "latency": {
      "warning": 1000,
      "critical": 3000
    },
    "errorRate": {
      "warning": 0.01,
      "critical": 0.05
    },
    "queueLength": {
      "warning": 10,
      "critical": 50
    }
  },
  "notifications": {
    "webhook": "https://your-webhook-url",
    "dingtalk": "https://oapi.dingtalk.com/robot/send?access_token=xxx"
  }
}
```

---

## 性能优化建议

### 1. 降低延迟

- 使用更快的 AI API（DeepSeek 国内访问快）
- 减少中间件数量
- 启用消息缓存

### 2. 提高吞吐量

- 增加并发处理数
- 使用消息队列
- 启用批量处理

### 3. 减少错误

- 添加重试机制
- 检查 API Key 余额
- 监控网络状态

---

## 监控仪表盘（企业版）

企业定制客户可获得：

- 实时监控仪表盘
- 历史数据查询
- 自定义告警规则
- 多账号统一管理

联系开发者获取：¥1999/月
