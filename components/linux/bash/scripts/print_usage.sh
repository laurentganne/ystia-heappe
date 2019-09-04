#!/usr/bin/env bash

echo "Getting report of resources used by job $JOB_ID..."

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/JobReporting/GetResourceUsageReportForJob \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"jobId\": \"$JOB_ID\", \"sessionCode\": \"$SESSION_ID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res getting current job info from HEAppE Middleware"
    echo $response
    exit 1
fi

echo "Usage report for job $JOB_ID:"
echo "$response"  | python -m json.tool

export TOSCA_JOB_ID=0
