# -*- coding: utf-8 -*-

import os
import sys
import json
from PIL import Image
from colorama import init, Fore, Back, Style

# 解包atlas文件
# atlas_path: atlas文件路径
# version: 1.0.1
# author: 鹿力半仙

def unpack(atlas_path):
    # 初始化colorama模块
    init(autoreset=True)

    # 分析路径
    file_path   = os.path.dirname(atlas_path)
    file_name   = os.path.basename(atlas_path)
    file_suffix = os.path.splitext(file_name)[1]

    # 检查文件后缀名是否为.atlas
    if file_suffix != '.atlas':
        print(Fore.RED + '请拖入atlas文件!')
        exit()
    else:
        print(Fore.GREEN + '正在解包 {0}:'.format(file_name))
    
    # 创建导出文件夹
    export_path = os.path.splitext(atlas_path)[0]
    if not os.path.exists(export_path):
        os.makedirs(export_path)

    # 读取图集文件
    count = 0
    with open(atlas_path, 'r', encoding='utf-8') as f:
        atlas = json.load(f)
        # 图集路径
        texture_path = file_path + '\\' + atlas['meta']['image']
        # 读取图集中的图片
        texture = Image.open(texture_path)
        for key in atlas['frames'].keys():
            # 获取图集中的图片信息
            sprite_data = atlas['frames'][key]
            frame = sprite_data['frame']
            sourceSize = sprite_data['sourceSize']
            spriteSourceSize = sprite_data['spriteSourceSize']

            # 裁剪图片
            sprite = texture.crop((frame['x'], frame['y'], frame['x'] + frame['w'], frame['y'] + frame['h']))

            # 重设画布大小
            source = Image.new('RGBA', (sourceSize['w'], sourceSize['h']), (0, 0, 0, 0))
            source.paste(sprite, (spriteSourceSize['x'], spriteSourceSize['y']))
            
            # 保存图片
            source.save('{0}\\{1}'.format(export_path, key))
            count += 1
        f.close()
        texture.close()

    print('导出了 {0} 张图片, 解包完成!'.format(count))

# 获取拖入的文件路径
input = sys.argv[1]
unpack(input)

# unpack('.\\129.atlas')
