#
# Building and Deployment Container for Firestorm
# Based on Ubuntu
#

# Pull base image.
FROM ubuntu:16.04

# Install.
RUN apt-get update && apt-get install -y --install-recommends\
    sudo \
    bison \
    bzip2 \
    curl \
    flex \
    gcc-4.7 \
    g++-4.7 \
    m4 \
    mercurial \
    libxrandr2 \
    libpng16-16 \
    python \
    python-dev \
    python-pip \
    libcairo2 \
    libpixman-1-0 \
    libxcursor1 \
    libxcomposite1 \
    gdb \
    libpixman-1-dev \
    libc6-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libstdc++6 \
    libx11-dev \
    libxinerama-dev \
    libxml2-dev \
    libxrender-dev \
    doxygen \
    cmake \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && pip install llbase

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 100 \
 && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.7 100 \
 && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-4.7 100

RUN hg clone https://bitbucket.org/NickyD/autobuild-1.0 /opt/autobuild \
 && ln -s /opt/autobuild/bin/autobuild /usr/bin/autobuild \
 && hg clone https://bitbucket.org/NickyD/3p-fmodex /opt/fmodex

# Add and compile fmodex
COPY fmodapi44461linux.tar.gz /opt/fmodex
RUN cd /opt/fmodex \
 && sed -i 's#URL_BASE=.*#URL_BASE=file://./#' build-cmd.sh \
 && autobuild build --all \
 && autobuild package

# Add scripts
COPY default-build.sh /usr/bin/
COPY setup-fmodex.sh /usr/bin/

RUN cd /opt/fmodex && sed -i 's/URL_BASE=.*/URL_BASE=\"file:\/\/.\/\"/' build-cmd.sh \
 && autobuild build --all \
 && autobuild package

#Set Volume for Firestorm Source
VOLUME ["/opt/firestorm"]

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /opt/firestorm

# Define default command.
CMD default-build.sh
