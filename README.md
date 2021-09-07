# Docker image for Glue Spark Jobs

As a first attempt to create a docker image that will allow for local runs of glue-pyspark jobs,
I built dockerfiles based on this [blog that had dockerfile](https://towardsdatascience.com/develop-glue-jobs-locally-using-docker-containers-bffc9d95bd1).
It uses the [aws libs github](https://github.com/awslabs/aws-glue-libs) and that repo points to this page for instructions on how to put the parts together


I changed the `glue-script.sh` shell script because it wasn't working correctly.
It may be that it is intended to run differently but the data science blog post (above) used it to build the glue environment.


There is a dockerfile for each of the glue versions.
- version 1.0 works when running `gluepyspark` (drops you into a repl).
- version 3.0 does not work because the pyspark binary is not in the spark distribution from aws
  - there is a spark distribution from aws that is supposed to be used for creating an aws environment.  For version 2 and 1, pyspark is in the distribution
- version 2.0 throws an error (not sure what the error is saying) when `gluepyspark` is called.  it seems to be when the repl tries to create the spark context
  - I tried the `gluesparksubmit` without any input and it brings up the help docs (that should be expected) so don't know if it works without actually submitting a job

## Running the containers

version 3
```bash
docker run -it --rm upjohnc/glue-spark:v3_0 bash
and inside the container:
gluepyspark
or
docker run -it --rm upjohnc/glue-spark:v3_0 gluepyspark
```

version 2
```bash
docker run -it --rm upjohnc/glue-spark:v2_0 bash
and inside the container:
gluepyspark
or
docker run -it --rm upjohnc/glue-spark:v2_0 gluepyspark
```
