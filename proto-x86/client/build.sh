docker build -f Dockerfile.dev -t alpine-dev .
docker build -f Dockerfile.build -t qtum-alpine-build .
docker build --no-cache -f Dockerfile.install -t qtum-alpine-bin .
docker build -f Dockerfile -t qtum-alpine .