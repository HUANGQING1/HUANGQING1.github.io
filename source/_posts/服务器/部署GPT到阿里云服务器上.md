---
title: 部署GPT到阿里云服务器上
abbrlink: 27078
toc: true
date: 2024-01-20 22:23:25
tags:
---
# 参考资料
```
https://blog.csdn.net/crazestone0614/article/details/126923555
https://www.bilibili.com/read/cv25000376/
https://blog.csdn.net/crazestone0614/article/details/126923555
```

# 准备工作
需要以下东西：
- GPT的密钥
- 域名（可选）
- 国外服务器
# 下载安装docker(转自B站UP主(白小纯学AI)
```
详细讲解参考：https://www.bilibili.com/read/cv25000376/
此处只为了方便复制代码，没有复制讲解
```

```
# 安装gcc 
sudo yum -y update
sudo yum -y install gcc
sudo yum -y install gcc-c++

#安装yum-utils工具并配置仓库

sudo yum install -y yum-utils
sudo yum-config-manager \
--add-repo https://download.docker.com/linux/centos/docker-ce.repo

//阿里云镜像站
sudo yum-config-manager \
  --add-repo \
  http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

#更新软件包索引
sudo yum makecache fast

#开始安装docker软件包
sudo yum -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#启动docker服务
sudo systemctl start docker

#测试docker服务
sudo docker run hello-world

```


# 配置防火墙规则
参考教程：https://blog.csdn.net/crazestone0614/article/details/126923555

假定你计划使用80端口访问
- 打开阿里云官网，点击ECS云服务器，进入服务器对应安全组，配置规则进行配置，添加规则,协议是自定义TCP、目的端口80，源：0.0.0.0/0，其余随意。
- 打开并远程连接上服务器，输入以下命令
```
#开放80端口
firewall-cmd --zone=public --add-port=80/tcp --permanent  
#重启防火墙
systemctl restart firewalld.service
```
- 查看已开启的端口信息：
```
 firewall-cmd --list-ports
```
没有出现80端口信息，说明80端口空闲，可以继续下一步，否则，换端口或关闭80端口。
```
#关闭端口参考该教程
https://blog.csdn.net/Yasser_lin/article/details/122923592
```
# 安装运行ChatGPT-Next-Web
```
#安装ChatGPT-Next-Web
#拉取镜像
docker pull yidadaa/chatgpt-next-web

#运行容器
docker run -it -p 80:3000 \
   -e OPENAI_API_KEY="sk-xxxx" \
   -e CODE="your-password" \
   yidadaa/chatgpt-next-web


#请确认防火墙规则
#Ctrl + p + q 退出 docker,(Ctrl+C应该也能退出吧)
#访问http://your-ip:80 
#使用80端口时，可省略 :80
```

测试是否能够成功访问(80可修改，可以改为别的端口号)，如果成功访问web，那么恭喜已经成功了



3.访问WEB输入密码开始使用
访问http://your-ip:80

点击设置按钮，输入密码点击确定，不用再输入key,输入密码可绕过输入key的限制。

发送问题，测试。若正确回答问题那么恭喜，安装成功了。
# 域名解析(可选)
- 如果有域名，可以进行域名解析，使用域名登录，
- 我是阿里云的域名，假设你的域名是baidu.com
- 进入云解析DNS，选择域名解析-->点击右侧域名解析中的baidu.com记录-->进入解析设置解析设置baidu.com
- 添加记录。主机记录：@、记录类型A、记录值：服务器的IP地址，其余随便。就可以用域名baidu.com访问了。
