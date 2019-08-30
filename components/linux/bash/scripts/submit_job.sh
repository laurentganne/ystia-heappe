#!/usr/bin/env bash


# Get the value of a given key in a JSON string
# Expects 2 parameters:
# - key
# - JSON string
getJsonval() {
	jsonKey=$1
	jsonContent=$2
    temp=`echo "$jsonContent" | awk -F"[{,:}]" '{for(i=1;i<=NF;i++){if($i~/\042'$jsonKey'\042/){print $(i+1)}}}' | tr -d '"' | sed -n 1p`
    echo $temp
}

echo "Authenticating to HEAppE Middleware"

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/UserAndLimitationManagement/AuthenticateUserPassword \
               --header 'Content-Type: application/json' \
               --cookie cookies.a4c \
               --silent \
               --data "{\"credentials\": {\"username\": \"$USER\", \"password\": \"$PASSWORD\"}}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error authenticating to HEAppE Middleware"
    exit 1
fi

# Exporting the response as SESSION_ID so that it can be re-used by other
# operations checking the job state or canceling the job
export SESSION_ID=$response

echo "Submitting job $JOB_ID..."

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/JobManagement/SubmitJob \
               --header 'Content-Type: application/json' \
               --cookie cookies.a4c \
               --silent \
               --data "{\"createdJobInfoId\": \"$JOB_ID\", \"sessionCode\": \"$SESSION_ID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error authenticating to HEAppE Middleware"
    exit 1
fi


# The orchestrator expects the job ID to be available in TOSCA_JOB_ID env variable
# operations checking the job state or canceling the job
export TOSCA_JOB_ID="${JOB_ID}"

echo "Job $TOSCA_JOB_ID submitted"
