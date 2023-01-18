# mlnx_ofed_driver
# to build docker image

docker build -t ofed-driver \
--build-arg D_BASE_IMAGE=centos:centos7.9.2009 \
--build-arg D_OFED_VERSION=5.8-1.1.2.1 \
--build-arg D_OS=rhel7.9 \
--build-arg D_ARCH=x86_64 \
.


# to create container


docker run -it \
--name ofed-driver \
-v /run/mellanox/drivers:/run/mellanox/drivers:shared \
-v /etc/network:/etc/network \
-v /etc:/host/etc \
-v /lib/udev:/host/lib/udev \
--net=host --privileged ofed-driver
