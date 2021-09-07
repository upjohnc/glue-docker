# problem is that pyspark is not in the spark distribution for 3.1.1
# todo make this the right `glue-setup.sh` file (probably copy from repo into dockerfile)
#!/usr/bin/env bash

ROOT_DIR=/app/aws-glue-libs
cd $ROOT_DIR

SPARK_CONF_DIR=$ROOT_DIR/conf
GLUE_JARS_DIR=$ROOT_DIR/jarsv1

PYTHONPATH="$SPARK_HOME/python/:$PYTHONPATH"
PYTHONPATH=`ls $SPARK_HOME/python/lib/py4j-*-src.zip`:"$PYTHONPATH"

# Generate the zip archive for glue python modules
rm PyGlue.zip
zip -r PyGlue.zip /app/aws-glue-libs/awsglue
GLUE_PY_FILES="$ROOT_DIR/PyGlue.zip"
export PYTHONPATH="$GLUE_PY_FILES:$PYTHONPATH"

# Run mvn copy-dependencies target to get the Glue dependencies locally
mvn -f $ROOT_DIR/pom.xml -DoutputDirectory=$ROOT_DIR/jarsv1 dependency:copy-dependencies

export SPARK_CONF_DIR=${ROOT_DIR}/conf
mkdir $SPARK_CONF_DIR
# rm $SPARK_CONF_DIR/spark-defaults.conf
# Generate spark-defaults.conf
echo "spark.driver.extraClassPath $GLUE_JARS_DIR/*" >> $SPARK_CONF_DIR/spark-defaults.conf
echo "spark.executor.extraClassPath $GLUE_JARS_DIR/*" >> $SPARK_CONF_DIR/spark-defaults.conf

# Restore present working directory
cd -
