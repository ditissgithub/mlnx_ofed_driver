#ARG D_BASE_IMAGE=registry.access.redhat.com/ubi7:latest
FROM centos:centos7.9.2009

ARG D_OFED_VERSION="5.8-1.1.2.1"
ARG D_OS_VERSION="7.9"
ARG D_OS="rhel${D_OS_VERSION}"
ENV D_OS=${D_OS}
ARG D_ARCH="x86_64"
ARG D_OFED_PATH="MLNX_OFED_LINUX-${D_OFED_VERSION}-${D_OS}-${D_ARCH}"
ENV D_OFED_PATH=${D_OFED_PATH}

ARG D_OFED_TARBALL_NAME="${D_OFED_PATH}.tgz"
#ARG D_OFED_BASE_URL="https://www.mellanox.com/downloads/ofed/MLNX_OFED-${D_OFED_VERSION}"
ARG D_OFED_BASE_URL="https://content.mellanox.com/ofed/MLNX_OFED-${D_OFED_VERSION}"
ARG D_OFED_URL_PATH="${D_OFED_BASE_URL}/${D_OFED_TARBALL_NAME}"

ARG D_WITHOUT_FLAGS="--without-rshim-dkms --without-iser-dkms --without-isert-dkms --without-srp-dkms --without-kernel-mft-dkms --without-mlnx-rdma-rxe-dkms"
ENV D_WITHOUT_FLAGS=${D_WITHOUT_FLAGS}


RUN yum install dnf -y
# Download and extract tarball
WORKDIR /root

RUN yum install -y kernel-devel-3.10.0-1160.el7.x86_64 \
kernel-tools-libs-3.10.0-1160.el7.x86_64 \
abrt-addon-kerneloops-2.1.11-60.el7.centos.x86_64 \
kernel-headers-3.10.0-1160.el7.x86_64 \
kernel-3.10.0-1160.el7.x86_64 \
kernel-tools-3.10.0-1160.el7.x86_64 \
libusbx numactl-libs libnl3 gcc-gfortran fuse-libs tcsh createrepo wget python-devel

RUN yum -y install curl && (curl ${D_OFED_URL_PATH} | tar -xzf -)
RUN yum -y install autoconf automake binutils ethtool gcc git hostname kmod libmnl libtool lsof make pciutils perl procps python36 python36-devel rpm-build tcl tk wget

WORKDIR /
ADD ./entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
