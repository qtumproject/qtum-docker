docker build --no-cache -f Dockerfile.dev -t alpine-dev .
docker build --no-cache -f Dockerfile.build -t qtumtoolchain-alpine-build .
docker build --no-cache -f Dockerfile.install -t qtumtoolchain-alpine-bin .
#docker build -f Dockerfile -t qtum-toolchain-alpine .