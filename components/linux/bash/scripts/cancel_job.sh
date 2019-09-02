#!/usr/bin/env bash

echo "Canceling Job ${TOSCA_JOB_ID}..."

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/JobManagement/CancelJob \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"submittedJobInfoId\": \"$JOB_ID\", \"sessionCode\": \"$SESSION_ID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res canceling job $JOB_ID"
    echo $response
    exit 1
fi
