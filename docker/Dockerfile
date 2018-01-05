FROM ubuntu:16.04

LABEL maintainer="YiJun Chen <gzenux@gmail.com>"


# install basic required packages
RUN apt-get update && apt-get install -y locales sudo

# install mandatory packages
RUN apt-get update && apt-get install -y \
	bash bc binutils build-essential bzip2 \
	cpio \
	file \
	gcc g++ gzip \
	make \
	patch perl python \
	rsync \
	sed \
	tar \
	unzip \
	wget \
	libncurses5-dev

# install optional packages
RUN apt-get update && apt-get install -y \
	bzr \
	cvs \
	mercurial \
	git \
	subversion


# generate locale
RUN locale-gen en_US.UTF-8

# Add user and switch to the user
ARG UID=1000
ARG USER=user
ARG HOME=/home/${USER}
RUN useradd -m -u ${UID} -d ${HOME} ${USER} && passwd -d ${USER} && \
gpasswd -a ${USER} sudo && sed -i 's:%sudo\tALL=(ALL\:ALL) ALL:%sudo\tALL=NOPASSWD\: ALL:g' /etc/sudoers

USER ${USER}
WORKDIR ${HOME}

CMD ["/bin/bash"]
