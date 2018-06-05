FROM ubuntu
MAINTAINER pandazwb

RUN set -ex \
    && apt-get update \
    && apt-get install -y -qq --no-install-recommends ca-certificates git wget apt-utils \
    && apt-get update \
    && apt-get install -y -qq --no-install-recommends gcc automake autoconf libtool yasm \
    && apt-get install -y -qq --no-install-recommends make g++ texinfo bison flex cmake \
    && apt-get install -y -qq --no-install-recommends bison libgmp3-dev libmpfr-dev libmpc-dev \
    && apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*

ENV PREFIX $HOME/opt/cross
ENV PATH $PREFIX/bin:$PATH

COPY prepare.sh $HOME/
COPY test.c $HOME/

# install qtum from github
#RUN cd $HOME && git clone https://github.com/qtumproject/x86-toolchain.git x86-compiler \
#	&& cd x86-compiler 
RUN ./prepare.sh

RUN set -ex \
    && cd $HOME/x86-compiler && rm -rf build-binutils build-gcc binutils-2.29 crtfiles gcc-7.2.0 includes \
    && rm -rf $HOME/FsLibc \
    && rm -rf $HOME/libqtum


CMD ["i386-qtum-gcc -v"]
