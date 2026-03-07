@echo off
REM 运行测试套件 (Windows)

echo 正在运行数风流测试套件...
echo.

love tests\main.lua

if errorlevel 1 (
    echo.
    echo 错误: 运行失败，请确保 Love2D 已安装并添加到 PATH
    pause
)
