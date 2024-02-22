---
abbrlink: 0
---

# 步骤
- 由于用的是腾讯云centos服务器，docker，mysql已经安装好了。

- 云服务器需要防火墙开放3072端口(假定使用3072端口)

  ````
  #教程参考：https://blog.csdn.net/crazestone0614/article/details/126923555
  #开放3072端口
  firewall-cmd --zone=public --add-port=3072/tcp --permanent  
  #重启防火墙
  systemctl restart firewalld.service
  ```
  - 查看已开启的端口信息：
  ````

- 安装nextcloud

  ```
  #拉取镜像,需要安装mysql也可用该命令 docker pull mysql拉取mysql镜像
  docker pull nextcloud
  ```

- 启动mysql容器

  ```cmd
  #启动mysql容器
  ## docker run -d:启动一个容器并后台运行
  ##--name nextcloud，容器命名为mysql
  ##-p 3306:80,将容器的3306端口映射到服务器的3306端口,第一个3306可自定义
  ##--restart=always ，重启docker时也重启容器
  ## -v ... ，挂载目录设置为/home/workSpace/mysql
  ## -e ...,设置数据库密码
  ##mysql,要启动的镜像名称
  
  #启动mysql容器
  docker run -d \
  --name mysql \
  -p 3306:3306 \
  --restart=always \
  -v /home/workSpace/mysql:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  mysql
  ```
   docker运行成功会显示这样的一串数字：d080a182d0fe46ce234a7db4731050c246f9810d912c52654fc0f9e06c978490
  
- 然后进入docker容器，并登录配置mysql

  ```
  #进入docker容器。
  docker exec -it mysql /bin/bash
  ```

  ```
  #登录
  mysql -uroot -p123456
  
  #配置权限，远程登陆
  CREATE database nextcloud_db;                        #创建一个nextcloud_db的数据库
  GRANT ALL ON *.* TO 'root'@'%';                   #设置root账号任意ip登录
  ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;
  ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
  flush privileges;
  exit;#退出mysql
  exit;#退出
  ```

- 启动nextcloud容器

  ```
  #启动nextcloud容器
  
  ## docker run -d:启动一个容器并后台运行
  
  ##--name nextcloud，容器命名为nextcloud
  ##-p 3072:80,将容器的80端口映射到服务器的3072端口
  ##--restart=always ，重启docker时也重启容器
  ## -v ... ,挂载目录设置为设置为/home/workSpace/nextcloud
  ##--link mysql:db 将nextcloud链接接到mysql容器数据库，映射到nextcloud中的数据库名字是db,之后登录nextcloud需要用到
  ##nextcloud,要启动的镜像名称
  
  docker run -d \
  --name nextcloud \
  -p 3072:80 \
  -v /home/workSpace/nextcloud:/var/www/html \
  --restart=always \
  --link mysql:db \
  nextcloud
  
  ```

  

- 然后打开浏览器，访问[http://your_ip:3072] 就可以进入了。

  ```
  管理员账户名密码，自行设置
  数据库选mysql数据库
  数据库用户名，密码是先前在mysql中设置的，root,123456
  数据库名字是在mysql中创建的数据库名字nextcloud_db
  localhost是在运行nextcloud，link时映射的名字db
  ```

  

- 一些docker命令
  
  ```
  #查看容器是否正常运行：
  docker ps
  #启动docker
  systemctl start docker
  #停止docker
  systemctl stop docker
  #重启docker
  systemctl restart docker
  ```
  
  

