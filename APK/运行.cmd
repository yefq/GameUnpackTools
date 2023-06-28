@echo off

rem apktool: https://bitbucket.org/iBotPeaches/apktool/downloads/
rem 批处理: @鹿力半仙 2023-3-20

rem 转区到中文编码,避免部分电脑乱码
chcp 65001>nul

echo  ______            __          ______                 ___      
echo /\  _  \          /\ \  _     /\__  _\               /\_ \     
echo \ \ \_\ \   _____ \ \ \/ \    \/_/\ \/    ___     ___\//\ \    
echo  \ \  __ \ /\  __ \\ \   ^<       \ \ \   / __`\  / __`\\ \ \   
echo   \ \ \/\ \\ \ \_\ \\ \ \\`\      \ \ \ /\ \_\ \/\ \_\ \\_\ \_ 
echo    \ \_\ \_\\ \  __/ \ \_\ \_\     \ \_\\ \____/\ \____//\____\
echo     \/_/\/_/ \ \ \/   \/_/\/_/      \/_/ \/___/  \/___/ \/____/
echo               \ \_\                                            
echo                \/_/                                            
echo.
echo.

:Input
rem 用户输入
set/p apk=[36m把要解压的APK拖进来:[0m 

rem 检测输入非空
if defined apk (
	call :Print %apk%

	:Print
	rem 获取文件名,作为输出文件夹
	set name=%~n1

	rem 调用Jar包
	echo 开始解包：[32m %name% [0m
	java -jar apktool_2.7.0.jar d -f %apk% -o %name%

	echo 解包完成!
) else goto Input
