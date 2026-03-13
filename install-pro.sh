#!/bin/bash
# 钉钉 OpenClaw 连接器 Pro 版 - 一键安装脚本
# 作者: OpenClaw Pro Team
# 版本: 1.0.0

set -e

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查系统依赖
check_dependencies() {
    log_info "检查系统依赖..."

    # 检查 Node.js
    if ! command -v node &> /dev/null; then
        log_error "未安装 Node.js，请先安装 Node.js 18+"
        exit 1
    fi

    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        log_error "Node.js 版本过低（需要 18+），当前版本: $(node -v)"
        exit 1
    fi

    # 检查 npm
    if ! command -v npm &> /dev/null; then
        log_error "未安装 npm"
        exit 1
    fi

    # 检查 OpenClaw
    if ! command -v openclaw &> /dev/null; then
        log_error "未安装 OpenClaw，请先安装: npm install -g openclaw"
        exit 1
    fi

    log_success "系统依赖检查通过 ✓"
    log_info "  - Node.js: $(node -v)"
    log_info "  - npm: $(npm -v)"
    log_info "  - OpenClaw: $(openclaw --version 2>/dev/null || echo '未知版本')"
}

# 交互式配置向导
run_config_wizard() {
    echo ""
    log_info "=========================================="
    log_info "   钉钉 OpenClaw 连接器 Pro - 配置向导"
    log_info "=========================================="
    echo ""

    # 1. 钉钉机器人信息
    log_info "请准备以下信息："
    log_info "  1. 钉钉机器人 Client ID"
    log_info "  2. 钉钉机器人 Client Secret"
    log_info "  3. 钉钉企业 Corp ID（可选）"
    echo ""

    read -p "$(echo -e ${YELLOW}请输入钉钉机器人 Client ID: ${NC})" CLIENT_ID
    if [ -z "$CLIENT_ID" ]; then
        log_error "Client ID 不能为空"
        exit 1
    fi

    read -p "$(echo -e ${YELLOW}请输入钉钉机器人 Client Secret: ${NC})" CLIENT_SECRET
    if [ -z "$CLIENT_SECRET" ]; then
        log_error "Client Secret 不能为空"
        exit 1
    fi

    read -p "$(echo -e ${YELLOW}请输入钉钉企业 Corp ID（可选，直接回车跳过）: ${NC})" CORP_ID

    # 2. OpenClaw 配置
    echo ""
    log_info "OpenClaw Gateway 配置"
    read -p "$(echo -e ${YELLOW}Gateway 地址（默认: http://localhost:4480）: ${NC})" GATEWAY_URL
    GATEWAY_URL=${GATEWAY_URL:-http://localhost:4480}

    read -p "$(echo -e ${YELLOW}Gateway Token（可选，直接回车跳过）: ${NC})" GATEWAY_TOKEN

    # 3. 高级配置
    echo ""
    log_info "高级配置"
    read -p "$(echo -e ${YELLOW}会话隔离策略（1: 按群隔离，2: 按群+用户隔离，默认: 1）: ${NC})" SESSION_SCOPE
    SESSION_SCOPE=${SESSION_SCOPE:-1}

    if [ "$SESSION_SCOPE" = "2" ]; then
        GROUP_SESSION_SCOPE="group_sender"
    else
        GROUP_SESSION_SCOPE="group"
    fi

    read -p "$(echo -e ${YELLOW}会话超时时间（分钟，默认: 30）: ${NC})" SESSION_TIMEOUT
    SESSION_TIMEOUT=${SESSION_TIMEOUT:-30}

    # 4. 确认配置
    echo ""
    log_info "=========================================="
    log_info "   配置确认"
    log_info "=========================================="
    log_info "Client ID: $CLIENT_ID"
    log_info "Client Secret: ${CLIENT_SECRET:0:10}***"
    log_info "Corp ID: ${CORP_ID:-未配置}"
    log_info "Gateway URL: $GATEWAY_URL"
    log_info "Gateway Token: ${GATEWAY_TOKEN:+已配置}"
    log_info "会话隔离: $GROUP_SESSION_SCOPE"
    log_info "会话超时: $SESSION_TIMEOUT 分钟"
    echo ""

    read -p "$(echo -e ${YELLOW}确认配置并继续安装？(y/n): ${NC})" CONFIRM
    if [ "$CONFIRM" != "y" ] && [ "$CONFIRM" != "Y" ]; then
        log_warning "用户取消安装"
        exit 0
    fi
}

# 生成配置文件
generate_config() {
    log_info "生成配置文件..."

    CONFIG_FILE="$HOME/.openclaw/config/dingtalk-connector.json"
    mkdir -p "$(dirname "$CONFIG_FILE")"

    cat > "$CONFIG_FILE" <<EOF
{
  "clientId": "$CLIENT_ID",
  "clientSecret": "$CLIENT_SECRET",
  "corpId": "$CORP_ID",
  "gateway": {
    "baseUrl": "$GATEWAY_URL",
    "token": "$GATEWAY_TOKEN"
  },
  "session": {
    "separateByConversation": true,
    "groupSessionScope": "$GROUP_SESSION_SCOPE",
    "timeoutMinutes": $SESSION_TIMEOUT
  },
  "features": {
    "aiCardStreaming": true,
    "asyncMode": false,
    "markdownTables": true
  }
}
EOF

    log_success "配置文件已生成: $CONFIG_FILE"
}

# 安装插件
install_plugin() {
    log_info "安装钉钉连接器插件..."

    # 检查是否已安装
    if openclaw plugins list | grep -q "dingtalk-connector"; then
        log_warning "插件已安装，正在更新..."
        openclaw plugins update dingtalk-connector
    else
        log_info "安装最新版本..."
        openclaw plugins install @dingtalk-real-ai/dingtalk-connector
    fi

    log_success "插件安装完成 ✓"
}

# 验证安装
verify_installation() {
    log_info "验证安装..."

    # 检查插件是否加载
    if ! openclaw plugins list | grep -q "dingtalk-connector"; then
        log_error "插件加载失败"
        exit 1
    fi

    # 检查配置文件
    if [ ! -f "$HOME/.openclaw/config/dingtalk-connector.json" ]; then
        log_error "配置文件生成失败"
        exit 1
    fi

    log_success "安装验证通过 ✓"
}

# 显示后续步骤
show_next_steps() {
    echo ""
    log_info "=========================================="
    log_info "   安装完成！"
    log_info "=========================================="
    echo ""
    log_success "钉钉 OpenClaw 连接器 Pro 已成功安装"
    echo ""
    log_info "后续步骤："
    echo ""
    log_info "1. 启动 OpenClaw Gateway:"
    log_info "   ${GREEN}openclaw start${NC}"
    echo ""
    log_info "2. 在钉钉群中添加机器人，使用以下 Webhook:"
    log_info "   ${GREEN}$GATEWAY_URL/webhook/dingtalk${NC}"
    echo ""
    log_info "3. 测试机器人："
    log_info "   在钉钉群中发送: @机器人 你好"
    echo ""
    log_info "4. 查看日志："
    log_info "   ${GREEN}tail -f ~/.openclaw/logs/dingtalk-connector.log${NC}"
    echo ""
    log_info "5. 管理面板（Pro 版专属）："
    log_info "   ${GREEN}openclaw dingtalk panel${NC}"
    echo ""
    log_info "=========================================="
    log_info "   技术支持"
    log_info "=========================================="
    log_info "GitHub: https://github.com/YOUR_USERNAME/dingtalk-connector-pro"
    log_info "文档: https://github.com/YOUR_USERNAME/dingtalk-connector-pro/wiki"
    log_info "微信: [扫描二维码]"
    echo ""
}

# 主函数
main() {
    log_info "钉钉 OpenClaw 连接器 Pro - 一键安装"
    log_info "版本: 1.0.0"
    echo ""

    check_dependencies
    run_config_wizard
    generate_config
    install_plugin
    verify_installation
    show_next_steps
}

# 运行主函数
main
