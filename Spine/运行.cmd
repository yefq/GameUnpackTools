@echo off
chcp 65001>nul

:Input
rem 用户输入
set/p json=把要解压的Json拖进来:

rem 检测输入非空
if defined json (
	call :Print %json%

	:Print
	rem 获取文件名,作为输出文件夹
    set input_folder=%~dp1
	set input_name=%~n1
    set source_atlas_file=%input_folder%\%input_name%.atlas.txt

    set export_setting=.\export.json

    set output_folder=.\_export\%input_name%\

    set output_project_file=%output_folder%\%input_name%.spine
    set output_images_folder=%output_folder%\images\
    set output_export_folder=%output_folder%\_export\

    rem 删除导出文件夹
    rmdir /s /q %output_folder%

    echo.

    rem 解包工程文件
    Spine -i %input_folder% -o %output_project_file% -r

    echo.

    rem 解包图集文件
    Spine -i %input_folder% -o %output_images_folder% -c %source_atlas_file%

    echo.

    rem 用配置重新导出一次
    Spine -i %output_project_file% -m -o %output_export_folder% -e %export_setting%

    echo.
    echo 解包完成!
    echo.
)
goto Input


rem === Functions ===
:ResolvePath
    set %1=%~dpfn2
    exit /b