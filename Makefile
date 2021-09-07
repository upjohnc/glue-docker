build-3-0:
	docker build -t glue-spark:v3-0 -f docker/Dockerfile-glue-3-0 .

build-2-0:
	docker build -t glue-spark:v2-0 -f docker/Dockerfile-glue-2-0 .
