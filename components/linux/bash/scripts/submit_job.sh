#!/usr/bin/env bash

echo "Authenticating to HEAppE Middleware"

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/UserAndLimitationManagement/AuthenticateUserPassword \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"credentials\": {\"username\": \"$HEAPPE_USER\", \"password\": \"$HEAPPE_PASSWORD\"}}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res authenticating to HEAppE Middleware"
    echo $response
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
               --silent \
               --data "{\"createdJobInfoId\": \"$JOB_ID\", \"sessionCode\": \"$SESSION_ID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res submitting job $JOB_ID to HEAppE Middleware, session $SESSION_ID"
    echo $response
    exit 1
fi

echo "Submit response: $response"


# The orchestrator expects the job ID to be available in TOSCA_JOB_ID env variable
# operations checking the job state or canceling the job
export TOSCA_JOB_ID="${JOB_ID}"

echo "Job $TOSCA_JOB_ID submitted"
