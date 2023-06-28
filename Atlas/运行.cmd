@echo off

rem 转区到中文编码,避免部分电脑乱码
CHCP  65001>nul

echo 欢迎使用atlas图集分割工具!

:Input
echo.
rem 用户输入
set/p file_path=[36m把要解压的atlas文件拖进来:[0m
echo.

rem 检测输入非空
if defined file_path (
    rem 调用Python脚本
    rem 如果在python里获取输入, 转义字符会导致纯数字命名的文件出现问题
    python unpack.py %file_path%
)

goto Input
