all: build start

build:
	docker build --tag widget-api .

start:
	docker run -p 4000:3000 -e HOSTNAME='localhost:4000' widget-api

bash:
	docker run -it widget-api /bin/bash

.PHONY: clean

clean:
	docker images widget-api -q | xargs -I{} docker rmi -f {}
	docker images -f dangling=true -q | xargs -I{} docker rmi -f {}