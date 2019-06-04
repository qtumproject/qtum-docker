docker build -f Dockerfile.dev -t alpine-dev .
docker build -f Dockerfile.build -t qtum-alpine-build .
docker build -f Dockerfile.install -t qtum-alpine-bin .
docker build -f Dockerfile -t qtum-alpine .