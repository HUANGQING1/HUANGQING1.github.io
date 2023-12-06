---
title: Python脚本
abbrlink: 27456
toc: true
date: 2023-12-06 09:04:43
tags:
---

# 图片批量处理
需求描述
```
现有大量格式相同图片，需要做以下处理
1、图片处理和排序
	首先，需要对一系列图片按照时间顺序重命名。
	对每张图片命名规则为：以图片的具体时间作为文件名，格式为“年月日_时分秒”，例如“20231203_074627.jpg”。
2、文本提取与文件命名：   
    从每张图片中提取文本。
    将提取出的文本保存为文本文件，文件名与图片文件相对应，格式变为“.txt”，例如“20231203_074627.txt”。
3、文本内容处理：  
    提取的文本格式可能包含前置文本、多个标号和文本段落，以及后置文本。
    需要处理文本，以便仅保留标号和相应的文本段落，移除前置和后置的无关文本。
```

代码
```
//图片处理
import os  
import shutil  
from datetime import datetime, timedelta  
  
pic_dir = 'C:/users/28577/Pictures/Screenshots/'  
output_dir = 'output/'  
  
if not os.path.exists(output_dir):  
    os.mkdir(output_dir)  
  
pic_file_lists = os.listdir(pic_dir)  
for pic_file in pic_file_lists:  
    if "renamed" in pic_file:  
        continue  
    # 获取文件的创建时间  
    file_creation_time = os.path.getctime(pic_dir + pic_file)  
    # 将时间戳转换为日期格式  
    date_str = datetime.fromtimestamp(file_creation_time).strftime('%Y%m%d_%H%M%S')  
    # 构建新文件名  
    new_file_name = date_str + ".jpg"  
    # 检查是否存在重名文件，如果有，则逐秒增加时间  
    while os.path.exists(output_dir + new_file_name):  
        file_creation_time += 1  # 增加一秒  
        date_str = datetime.fromtimestamp(file_creation_time).strftime('%Y%m%d_%H%M%S')  
        new_file_name = date_str + ".jpg"  
    # 复制文件到新位置并重命名  
    shutil.copy(pic_dir + pic_file, output_dir + new_file_name)
```