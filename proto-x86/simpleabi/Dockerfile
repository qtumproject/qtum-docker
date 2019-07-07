FROM golang:1.7.3

RUN go get -u -v -d github.com/qtumproject/simple-abi && \
	cd /go/src/github.com/qtumproject/simple-abi && \
	CGO_ENABLED=0 GOOS=linux go build -o simple-abi .

FROM alpine:3.9.4
LABEL maintainers "earlz, VoR0220"

COPY --from=0 /go/src/github.com/qtumproject/simple-abi/simple-abi /usr/local/bin
ENTRYPOINT [ "simple-abi" ]