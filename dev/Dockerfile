FROM ubuntu:22.04 as build

ENV DEBIAN_FRONTEND=non-interactive

# Set the branch name to build
ARG BRANCH_NAME=master

# Install common dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common \
    autoconf automake autotools-dev \
    bsdmainutils  build-essential \
    ca-certificates cmake curl  g++-9 gcc-9 git \
    libcurl4-openssl-dev libevent-dev libtool libtool-bin libgmp-dev libgmp3-dev \
    libboost-all-dev libssl-dev pkg-config binutils bison  libminiupnpc-dev

# Set gcc-9 as the default compiler
RUN update-alternatives \
--install /usr/bin/gcc gcc /usr/bin/gcc-9 90 \
--slave /usr/bin/g++ g++ /usr/bin/g++-9 \
--slave /usr/bin/gcov gcov /usr/bin/gcov-9

# Clone the qtum repo and checkout the specified branch
RUN git clone https://github.com/qtumproject/qtum && \
    cd qtum && \
    git checkout ${BRANCH_NAME} && \
    git submodule update --init --recursive

# Install Berkeley DB
WORKDIR /qtum
RUN ./contrib/install_db4.sh `pwd`

# Build qtum dependencies
ENV BDB_PREFIX=/qtum/db4
WORKDIR /qtum/depends
RUN make

# Build qtum binaries
WORKDIR /qtum

RUN TARGET_TRIPLET=$(ls /qtum/depends | grep  -E '.*-.*-.*') && \
    echo "TARGET_TRIPLET value: $TARGET_TRIPLET" && \
    libtool --finish /qtum/depends/"$TARGET_TRIPLET"/lib && \
    export LD_LIBRARY_PATH=/qtum/depends/"$TARGET_TRIPLET"/lib && \
    ./autogen.sh && \
    ./configure --prefix=$PWD/depends/"$TARGET_TRIPLET" && \
    make -j$(nproc)


# Second stage for the production image
FROM ubuntu:22.04

# Setting environment to non-interactive mode to avoid prompts
ENV DEBIAN_FRONTEND=non-interactive

# Copy the binaries from the build stage to the final image
COPY --from=build /qtum/src/qtumd /usr/local/bin/
COPY --from=build /qtum/src/qtum-cli /usr/local/bin/
COPY --from=build /qtum/src/qtum-tx /usr/local/bin/
COPY --from=build /qtum/src/qtum-util /usr/local/bin/
COPY --from=build /qtum/src/qtum-wallet /usr/local/bin/

EXPOSE 3888 3889 13888 13889 13777 13778
CMD ["qtumd"]