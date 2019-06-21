FROM qtum-alpine-bin as build
LABEL maintainers "earlz, VoR0220"

FROM alpine

#
# Copy the binaries from the build to our new container
#
COPY --from=build /usr/local/bin/qtumd /usr/local/bin
COPY --from=build /usr/local/bin/qtum-cli /usr/local/bin
#
# Install all dependencies
#
RUN apk update && apk add boost boost-filesystem \
    boost-program_options \
    boost-system boost-thread \
    boost-random busybox db-c++ \
    libevent libgcc libressl2.7-libcrypto \ 
    libstdc++ musl \
    gdb

#
# Copy the qtum.conf file from
# the build context into the container
#
COPY qtum.conf /qtum.conf

# create data directory
ENV QTUM_DATA /data
RUN mkdir $QTUM_DATA \
    && ln -sfn $QTUM_DATA /.qtum
VOLUME /data

EXPOSE 3888 3889 13888 13889
ENV PATH=${PATH}:/usr/local/bin:
CMD ["qtumd", "-regtest", "-logevents", "-printtoconsole"]