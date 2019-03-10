#!/bin/bash -e

BASE_PATH=$(pwd)
APP_NAME=$(basename $(pwd))
LOG_FILE="${BASE_PATH}/${APP_NAME}.log"
PID_FILE="${BASE_PATH}/${APP_NAME}.pid"
JAR_FILE="${BASE_PATH}/${APP_NAME}*.jar"

export APP_NAME
export LOG_FILE


# JAVA_OPTS="${JAVA_OPTS} -Djava.io.tmpdir=${WORK_PATH}"

if [ -z "${JAVA_HOME}" ]; then
    JAVACMD="java"
else
    JAVACMD="${JAVA_HOME}/bin/java"
fi

JVM_ARGS=""  

if [ -f ${PID_FILE} ]; then
    result=0
    old_pid=`cat ${PID_FILE}`
    echo "PID file ${PID_FILE} exists..."
    set +e
    kill -0 ${old_pid} &> /dev/null
    result=$?
    set -e

    if [ ${result} -eq 0 ]; then
        echo "${APP_NAME} is still running as process ${old_pid}. Exiting..."
        exit 1
    fi

    echo "Process ${old_pid} is no longer active. Deleting PID file and starting..."
fi

COMMAND="${JAVACMD} ${JVM_ARGS} -jar ${JAR_FILE} "

echo "Starting ${APP_NAME} with: '${COMMAND}'"

nohup ${COMMAND} > "${LOG_PATH}/${APP_NAME}.out" 2>&1 &
PID=$!

echo ${PID} > ${PID_FILE}
