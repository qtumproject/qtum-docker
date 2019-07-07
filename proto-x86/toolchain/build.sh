docker build -f Dockerfile.dev -t alpine-dev .
docker build -f Dockerfile.build -t qtumtoolchain-alpine-build .
docker build -f Dockerfile -t qtumtoolchain-alpine .