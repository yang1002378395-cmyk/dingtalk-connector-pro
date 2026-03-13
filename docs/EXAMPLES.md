# 钉钉 OpenClaw 连接器 Pro 版 - 使用示例

## 示例 1：基础对话

用户发送：
```
你好
```

AI 回复（流式卡片）：
```
你好！我是钉钉 AI 助手，有什么可以帮助你的吗？
```

---

## 示例 2：多轮对话

用户：
```
帮我写一个 Python 脚本，读取 Excel 文件
```

AI：
```
好的，这是一个读取 Excel 文件的 Python 脚本：

\`\`\`python
import pandas as pd

# 读取 Excel 文件
df = pd.read_excel('data.xlsx')

# 显示前 5 行
print(df.head())
\`\`\`

需要我解释每行代码吗？
```

用户：
```
解释一下
```

AI：
```
当然！

1. \`import pandas as pd\` - 导入 pandas 库，简称 pd
2. \`pd.read_excel('data.xlsx')\` - 读取 Excel 文件
3. \`df.head()\` - 显示前 5 行数据

pandas 是 Python 最常用的数据处理库...
```

---

## 示例 3：Slash 命令

用户发送：
```
/new
```

系统回复：
```
✅ 已开始新对话
```

---

## 示例 4：企业通讯录

用户（已登录员工）发送消息，AI 可以识别：

```json
{
  "senderName": "张三",
  "department": "技术部",
  "employeeId": "EMP001"
}
```

AI 回复：
```
张三你好！我是技术部 AI 助手...
```

---

## 示例 5：多账号场景

公司有 2 个钉钉机器人：
- 客服机器人（处理客户咨询）
- 内部助手（处理员工问题）

配置文件：

```json
{
  "accounts": {
    "customer-service": {
      "clientId": "dingxxx",
      "clientSecret": "secxxx",
      "description": "客服机器人"
    },
    "internal-helper": {
      "clientId": "dingyyy",
      "clientSecret": "secyyy",
      "description": "内部助手"
    }
  }
}
```

---

## 示例 6：自定义命令

在 OpenClaw 配置中添加自定义命令：

```json
{
  "commands": {
    "/help": "显示帮助信息",
    "/status": "查询订单状态",
    "/ticket": "创建工单"
  }
}
```

用户发送 `/help`，AI 返回：
```
📖 可用命令：

/help - 显示帮助信息
/status - 查询订单状态
/ticket - 创建工单

有任何问题随时问我！
```

---

## 示例 7：文件处理

用户发送一个 PDF 文件，AI 自动解析：

```
📄 已收到文件：产品说明书.pdf

我已阅读这份产品说明书，主要内容包括：

1. 产品概述
2. 技术规格
3. 使用方法
4. 注意事项

你想了解哪个部分？
```

---

## 示例 8：群聊场景

在钉钉群中 @机器人：

```
@AI助手 今天天气怎么样
```

AI 回复（仅回复 @它的消息）：
```
@用户 北京今天晴天，温度 15-25°C，适合户外活动！
```

---

## 获取更多帮助

- GitHub Issues: https://github.com/yang1002378395-cmyk/dingtalk-connector-pro/issues
- 技术支持: 联系开发者（备注「钉钉AI」）
