---
abbrlink: 5
---
```
uname -r #显示系统相关内核版本号
cat /etc/os-release #命令用于显示操作系统的信息

curl localhost:3344

docker status 容器id


yum remove xxx yyy zzz
yum install -y xxx yyy zzz
yum-config-manager -add-repo xxx


systemctl start docker

docker run hello-world
docker images
docker ps
docker version
docker info
docker 命令 --help 


docker images查看所有本地的主机上的镜像

docker search 搜索镜像
docker search 搜索镜像
docker pull下载镜像


#卸载docker
yum remove docker-ce docker-ce-cli containerd.io
rm -rf /var/lib/docker #/var/lib/docker是docker的默认工作路径
```



# Docker概述

Docker是一种容器化技术，通过将应用程序及其所有依赖项打包到一个独立的容器中，实现了轻量、快速、一致的应用部署，提高了开发、测试和部署的效率。

Docker像是轻量的虚拟机，为安装在其内的应用程序提供互相隔离的环境，避免了配置环境的麻烦。

# Docker安装

```
#1、卸载旧的版本
yum remove docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-engine

#2、下载需要的安装包
yum install -y yum-utils


#3、设置镜像的仓库
yum-config-manager \
	--add-repo \
	https://down1oad.docker.com/linux/centos/docker-ce.repo #默认是从国外的!

yum-config-manager \
	--add-repo \
	http://mirrors.aliyun.com/docker-ce/1inux/centos/docker-ce.repo #推荐使用阿里云的，十分的快

#更新yum软件包索引
yum makecache fast

#4、安装dokcer docker-ce社区ee企业版
yum insta1l docker-ce docker-ce-cli containerd.io

#5、启动docker
systemctl start docker

#7、he11o-wor1d 测试docker是否安装成功，安装成功会重新Hello from Docker!字样
docker run he11o-wor1d

#8、查看一下下载的这个hello-wor1d镜像
docker images

# 9、了解:卸载docker
##9.1、卸载依赖
yum remove docker-ce docker-ce-cli containerd.io
##9.2、册除资源
rm -rf /var/1ib/docker
#/var/1ib/docker docker的默认工作路径!


#需要加速的话，配置镜像加速器。
```



# Docker命令

## 帮助命令

```
docker version # 显示docker的版本信息
docker info #显示docker的系统信息，包括镜像和容器的数量
docker 命令 --help  #帮助命令
```

帮助文档的地址:https:/ldocs.docker.com/engine/referencelcommandline/

## 镜像命令

### docker images查看镜像

```
docker images #查看所有本地的主机上的镜像
#可选项
-a, --a11			#列出所有镜像
-q,--quiet			#只显示镜像的id

```
### docker search搜索镜像

```
docker search mysql #搜索mysql镜像

#可选项,通过搜藏来过滤
docker search mysql --filter=STARS=3000	#搜索出来的镜像就是STARS大于3000的
```

### docker pull下载镜像

```
docker pu1l 镜像名[:tag]  #下载镜像,tag是可选版本名，默认是下载最新版本，docker pu1l 镜像名:latest
docker pu11 mysql
docker pull mysql:5.7 #下载mysql5.7版本

```

### docker rmi删除镜像

```
docker rmi -f 镜像id	#删除指定的镜像
docker rmi -f 镜像1id 镜像2id 镜像3 id 镜像4id #删除多个镜像
docker rmi -f $(docker images -aq)		#删除全部的镜像
```

## 容器命令

### 新建容器并启动docker run

```
docker run [可选参数] image

#举例，启动并进入容器。以启动centos容器为例，以bat命令行发生打开
docker run -it centos /bin/bash
#注意，如果以后台方式运行容器，容器启动后又没有提供服务，自行终止
docker run -d centos

#参数说明
--name="Name" 	容器名字 tomcat01 tomcat02，用来区分容器
-d 				后台方式运行
-it 			使用交互方式运行,进入容器查看内容
-p				指定容器的端口-p 8080:8080
	-p ip:主机端口:容器端口
	-p主机端口:容器端口（常用）-p容器端口
	容器端口
-P				随机指定端口

```

### 列出所有的运行的容器docker ps

```
docker ps		#列出当前正在运行的容器
docker ps -a	#列出当前正在运行的容器+带出历史运行过的容器
docker ps -n=?	#显示最近创建的容器
docker ps -q	#只显示容器的编号
```

### 退出容器

```
exit		#直接让容器停止并退出
Ctrl +P+Q	#容器不停止退出
```



### 删除容器docker rm

```
docker rm 容器id					   #删除指定的容器，不能删除正在运行的容器，如果要强制删除 rm -f
docker rm -f $(docker ps -aq)		#删除所有的容器
docker ps -a -q|xargs docker rm		#册除所有的容器
```

### 启动和停止容器的操作

```
docker start 容器id		#启动容器
docker restart 容器id		#重启容器
docker stop 容器id		#停止当前正在运行的容器
docker ki1l 容器id		#强制停止当前容器
```

### 查看日志docker logsdocker logs

```
#参数说明
-tf				#显示日志
--tail number	#显示日志条数
#举例
docker logs -tf --tail 10 容器id #显示容器id对应的最近10条记录
```

### 查看容器中进程信息docker top

```
docker top 容器id
```



### 查看镜像的元数据docker inspec

```
docker inspect 容器id
```

### 进入当前正在运行的容器

```
#我们通常容器都是使用后台方式运行的，需要进入容器，修改一些配置
docker exec -it 容器id /bin/bash  
docker attach 容器id 

#两者区别
# docker exec 进入容器后开启一个新的终端，可以在里面操作（常用)
#docker attach 进入容器正在执行的终端,不会启动新的进程!
```

### 从容器内拷贝文件到主机上

```
docker cp 容器id:容器内路径目的的 主机路径
```



## 命令汇总

```
attach	Attach to a running container												#当前she1l 下attach连接指定运行镜像
bui1d	Bui1d an image from a Dockerfile											#通过Dockerfile定制镜像
commit 	Create a new image from a container changes									#提交当前容器为新的镜像
cp		copy files/folders from the containers filesystem to the host path			#从容器中拷贝指定文件或者目
录到宿主机中
create	Create a new container														#创建一个新的容器,同run，但不启动容器
diff	Inspect changes on a container 's filesystem								#查看docker容器变化
events 	Get real time events from the server										#从docker服务获取容器实时事件
exec 	Run a command in an existing container										#在已存在的容器上运行命令
export	Stream the contents of a container as a tar archive							#导出容器的内容流作为一个 tar 归档文件[对应import]
history show the history of an image												#展示一个镜像形成历史
images	List images																	#列出系统当前镜像
import 	Create a new filesystem image from the contents of a tarball 				# 从tar包中的内容创建一个新的文件系统映像[对应export]
info	Display system-wide information												#显示系统相关信息
inspect Return low-1eve1 information on a container									#查看容器详细信息
kill	Kill a running container													#kill指定docker容器
1oad	Load an image from a tar archive											#从一个tar包中加载一个镜像[对应save]
login 	Register or Login to the docker registry server								#注册或者登陆一个docker 源服务器
1ogout 	Log out from a Docker registry server										#从当前Docker registry 退出
1ogs	Fetch the logs of a container												#输出当前容器日志信息
port 	Lookup the public-facing port which is NAT-ed to PRIVATE_PORT				#查看映射端口对应的容器内部源端口
pause	Pause all processes within a container										#暂停容器
ps		List containers																#列出容器列表
pu11	Pull an image or a repository from the docker registry server				# 从docker镜像源服务器拉取指定镜
像或者库镜像
push	Push an image or a repository to the docker registry server					#推送指定镜像或者库镜像至docker源
服务器
restart	Restart a running container													#重启运行的容器
rm		Remove one or more containers												#移除一个或者多个容器
rmi		Remove one or more images													#移除一个或多个镜像[无容器使用该镜像才可删除，否则需删除相关容
器才可继续或-f强制册除]
run		Run a command in a new container											#创建一个新的容器并运行一个命令
save	Save an image to a tar archive												#保存一个镜像为一个 tar包[对应load]
search	Search for an image on the Docker Hub										#在docker hub中搜索镜像
start	Start a stopped containers													#启动容器
stop	Stop a running containers													#停止容器
tag		Tag an image into a repository												#给源中镜像打标签
top		Lookup the running processes of a container									#查看容器中运行的进程信息
unpause Unpause a paused container													#取消暂停容器
version show the docker version information											#查看docker版本号
wait	Block until a container stops，then print its exit code 						# 截取容器停止时的退出状态值
```

# Docker图形化界面管理工具portainer 
```
docker run -d -p 8088:9000 \
--restart=always -v/var/run/docker.sock: /var/run/docker.sock --privileged=true portainer/portainer
```



# 