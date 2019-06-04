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
    libstdc++ musl

#
# Copy the qtum.conf file from
# the build context into the container
#
COPY qtum.conf /qtum.conf

EXPOSE  3888/tcp
ENTRYPOINT ["/usr/local/bin/qtumd"]
CMD ["-conf=/qtum.conf", "-regtest", "-rest=1", "-server=1", "-printtoconsole", "-txindex=1"]