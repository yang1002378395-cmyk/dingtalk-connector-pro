#!/usr/bin/env python3
"""
钉钉 Pro 版推广任务
目标：获取第一个付费客户
"""

import os
import json
from datetime import datetime

# 推广渠道
CHANNELS = [
    {
        "name": "掘金",
        "url": "https://juejin.cn",
        "status": "已发布",
        "article": "https://juejin.cn/post/7616576373167718442"
    },
    {
        "name": "知乎",
        "url": "https://zhihu.com",
        "status": "待发布",
        "topic": "OpenClaw 钉钉连接器 - 企业微信/钉钉 AI 助手一键部署"
    },
    {
        "name": "V2EX",
        "url": "https://v2ex.com",
        "status": "待发布",
        "section": "分享创造"
    },
    {
        "name": "即刻",
        "url": "https://okjike.com",
        "status": "待发布",
        "topic": "开源项目分享"
    }
]

# 目标客户画像
TARGET_CUSTOMERS = [
    {
        "type": "中小企业",
        "痛点": "需要钉钉 AI 客服，但不会开发",
        "方案": "¥999 基础套餐",
        "渠道": "知乎/V2EX"
    },
    {
        "type": "开发者",
        "痛点": "想学习 OpenClaw 开发",
        "方案": "¥499/小时 技术培训",
        "渠道": "掘金/GitHub"
    },
    {
        "type": "企业IT",
        "痛点": "需要定制化功能",
        "方案": "¥2999 企业定制",
        "渠道": "LinkedIn/知乎"
    }
]

def print_plan():
    print("=" * 50)
    print("钉钉 Pro 版推广计划")
    print("=" * 50)
    print(f"\n📅 日期: {datetime.now().strftime('%Y-%m-%d %H:%M')}")
    
    print("\n📢 推广渠道:")
    for ch in CHANNELS:
        print(f"  - {ch['name']}: {ch['status']}")
    
    print("\n🎯 目标客户:")
    for c in TARGET_CUSTOMERS:
        print(f"  - {c['type']}: {c['方案']}")
    
    print("\n💰 定价:")
    print("  - 基础安装: ¥99")
    print("  - 高级配置: ¥299")
    print("  - 企业定制: ¥999-2999")
    print("  - 技术培训: ¥499/小时")
    print("  - 专属支持: ¥1999/月")
    
    print("\n📋 下一步行动:")
    print("  1. 发布到知乎（流量大）")
    print("  2. 发布到 V2EX（开发者多）")
    print("  3. GitHub 添加 Topics 和描述")
    print("  4. 寻找第一个客户")

if __name__ == "__main__":
    print_plan()
