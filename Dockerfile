

# 选择基础镜像，运行成容器
FROM ubuntu:18.04

# 指定维护者信息
MAINTAINER weiwei 2335490692@qq.com

# 复制宿主机安装源文件到容器
COPY sources.list /etc/apt

# 执行更新源指令
# RUN apt-get update
# RUN ["apt-get", "update"]

# 安装nginx
# RUN apt-get install nginx -y --allow-unauthenticated
# 安装python
# RUN apt-get install python3-pip -y

# front_end_pc静态文件
ADD front_end_pc.tar.gz /data/
# meiduo_mall_admin静态文件
ADD meiduo_mall_admin.tar.gz /data/
# meiduo_mall工程文件
ADD meiduo_mall.tar.gz /data/

# 安装工程依赖
WORKDIR /data/meiduo_mall/
RUN pip3 install -r requirements.txt

# 拷贝nginx配置文件
COPY 8080.conf /etc/nginx/conf.d/
COPY 8081.conf /etc/nginx/conf.d/
COPY 8000.conf /etc/nginx/conf.d/


EXPOSE 8080 8081 8000


# ENTRYPOINT关键字指定启动服务
# 问题是：我们有2个服务需要启动，一个是nginx，另一个是django工程
# 解决方法：把运行程序的命令写入一个shell脚本中
COPY command.sh /data/
WORKDIR /data/
ENTRYPOINT ["/bin/bash", "command.sh"]















