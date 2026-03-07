#!/bin/bash
# 运行测试套件

cd "$(dirname "$0")"
echo "正在运行数风流测试套件..."
echo ""

# 使用love运行测试
love tests/main.lua

# 如果love命令不存在，尝试其他方式
if [ $? -ne 0 ]; then
    echo "尝试使用绝对路径..."
    
    # Windows
    if [ -f "/c/Program Files/LOVE/love.exe" ]; then
        "/c/Program Files/LOVE/love.exe" tests/main.lua
    elif [ -f "/c/Program Files (x86)/LOVE/love.exe" ]; then
        "/c/Program Files (x86)/LOVE/love.exe" tests/main.lua
    else
        echo "错误: 未找到 Love2D，请确保已安装并添加到PATH"
        exit 1
    fi
fi
