FROM ubuntu
MAINTAINER earlz

WORKDIR /root
RUN set -emx \
    && apt-get update \
    && apt-get install -y -qq --no-install-recommends ca-certificates curl wget apt-utils build-essential git libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils git cmake libboost-all-dev software-properties-common texinfo bison flex libmpc-dev libmpfr-dev libgmp3-dev yasm \
    && add-apt-repository ppa:bitcoin/bitcoin -y \
    && apt-get update \
    && apt-get install libdb4.8-dev libdb4.8++-dev -y -qq --no-install-recommends

ENV REPO_PREFIX=https://github.com/qtumproject
ENV BRANCH=proto-x86

ENV MAKE_SUFFIX=-j2

# get x86-toolchain source
RUN set -ex \
    && git clone $REPO_PREFIX/x86-toolchain \
    && cd x86-toolchain \
    && git checkout $BRANCH \
    && cd .. \
    && git clone $REPO_PREFIX/libqtum \
    && cd libqtum \
    && git checkout $BRANCH \
    && cd .. \
    && git clone $REPO_PREFIX/FsLibc \
    && cd FsLibc \
    && git checkout $BRANCH \
    && cd ..

# get qtum source
RUN set -ex \
    && git clone $REPO_PREFIX/qtum --recursive \
    && cd qtum \
    && git checkout $BRANCH

# get docker helpers
RUN set -ex \
    && git clone $REPO_PREFIX/qtum-docker \
    && cd qtum-docker \
    && git checkout $BRANCH

# build qtum etc first, as the toolchain takes much longer

# build qtum
RUN set -ex \
    && cd qtum \
    && ./autogen.sh \
    && ./configure \
    && make $MAKE_SUFFIX

# build x86lib utility
RUN set -ex \
    && cd qtum/src/x86lib \ 
    && make $MAKE_SUFFIX

ENV PREFIX=/opt/cross
ENV TARGET=i686-elf
ENV SYSROOT=/opt/x86-compiler/sysroot
ENV PATH=${PATH}:${SYSROOT}/bin:$PREFIX/bin:/root/qtum/src:/root/qtum/src/x86lib:/root/qtum-docker/proto-x86/utils

# build the freestanding compiler
RUN set -ex \
    && cd x86-toolchain \
    && mkdir build-binutils \
    && cd build-binutils \
    && ../binutils-2.29/configure --target="$TARGET" --prefix="$PREFIX" --disable-werror \
    && make \
    && make install \
    && cd .. \
    && mkdir build-gcc \
    && cd build-gcc \
    && ../gcc-7.2.0/configure --target="$TARGET" --prefix="$PREFIX" --enable-languages=c,c++ \
    && make all-gcc \
    && make all-target-libgcc \
    && make install-gcc \
    && make install-target-libgcc


ENV TARGET=i686-qtum

#compile QtumOS compiler and supports
RUN set -ex \
    && ls $PREFIX/bin \
    && i686-elf-gcc -v \
    && cd FsLibc \
    && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=cross-toolchain.cmake -DCMAKE_INSTALL_PREFIX=$SYSROOT/usr . \
    && make -C libc \
    && make -C libc install \
    && cd ~/x86-toolchain/crtfiles \
    && make \
    && cd .. \
    && mkdir -p $SYSROOT/usr/lib \
    && mkdir -p $SYSROOT/usr/include \
    && cp crtfiles/*.o $SYSROOT/usr/lib/ \
    && cp -r includes/* $SYSROOT/usr/include/ \
    && rm -rf build-binutils \
    && mkdir build-binutils \
    && cd build-binutils \
    && ../binutils-2.29/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot="$SYSROOT" --disable-werror \
    && make \
    && make install \
    && cd .. \
    && rm -rf build-gcc \
    && mkdir build-gcc \
    && cd build-gcc \
    && ../gcc-7.2.0/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot="$SYSROOT" --enable-languages=c \
    && make all-gcc \
    && make all-target-libgcc \
    && make install-gcc \
    && make install-target-libgcc

# build libqtum
RUN set -ex \
    && cd libqtum \
    && make \
    && make deploy


# create data directory
ENV QTUM_DATA /data
RUN mkdir $QTUM_DATA \
    && ln -sfn $QTUM_DATA /root/.qtum \
VOLUME /data

EXPOSE 3888 3889 13888 13889
CMD ["qtumd", "-regtest", "-logevents"]
