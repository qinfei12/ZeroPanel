#!/bin/bash
# ZeroPanel v2.0 - Linux (Ubuntu/Debian) 版安装入口
# 下载并执行面板专用安装脚本

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

print_separator() {
    echo -e "${CYAN}══════════════════════════════════════════════════════════════════${NC}"
}

print_title() {
    print_separator
    echo -e "                    ${WHITE}ZeroPanel v2.0${NC}"
    echo -e "                ${CYAN}Linux (Ubuntu/Debian) 版${NC}"
    print_separator
}

# 检测环境类型
detect_environment() {
    local distro=""

    if [ -f "/etc/os-release" ]; then
        distro=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    fi

    if [ "$distro" = "debian" ] || [ "$distro" = "ubuntu" ]; then
        echo "linux"
        return
    fi

    echo "unsupported"
}

main() {
    print_title
    echo ""

    local env_type
    env_type=$(detect_environment)

    case "$env_type" in
        linux)
            echo -e "  ${GREEN}检测到 Ubuntu / Debian Linux 环境${NC}"
            echo -e "  ${WHITE}将下载并执行 Linux 版安装脚本${NC}"
            echo ""

            local tmp_script
            tmp_script=$(mktemp)
            if curl -fsSL -o "$tmp_script" "https://raw.githubusercontent.com/qinfei12/ZeroPanel/trae/agent-zipvKL/zeropanel/install.sh"; then
                chmod +x "$tmp_script"
                bash "$tmp_script" "$@"
                rm -f "$tmp_script"
            else
                echo -e "  ${RED}下载安装脚本失败，请检查网络${NC}"
                exit 1
            fi
            ;;
        unsupported)
            echo -e "  ${RED}错误：当前环境不受支持${NC}"
            echo ""
            echo -e "  ${WHITE}ZeroPanel 支持以下环境：${NC}"
            echo -e "    ${CYAN}Ubuntu / Debian 等 Linux 服务器${NC}"
            echo ""
            echo -e "  ${YELLOW}请使用对应命令安装：${NC}"
            echo -e "    ${CYAN}Linux:${NC}  bash <(curl -fsSL https://raw.githubusercontent.com/qinfei12/ZeroPanel/trae/agent-zipvKL/install.sh)"
            echo ""
            exit 1
            ;;
    esac
}

main "$@"
