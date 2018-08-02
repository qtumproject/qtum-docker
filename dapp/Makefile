.PHONY: image

img_tag = "hayeah/qtumportal"
container_name = "qtumportal"

image:
	docker build . -t $(img_tag)

run:
	cp -n env.list-example env.list || true
	docker run --rm -d \
	  --name $(container_name) \
	  --env-file env.list \
	  -v `pwd`:/dapp \
	  -p 9899:9899 \
	  -p 9888:9888 \
	  -p 3889:3889 \
	  -p 23889:23889 \
	  $(img_tag)

stop:
	docker stop $(container_name)

exec:
	docker exec -it $(container_name) sh
