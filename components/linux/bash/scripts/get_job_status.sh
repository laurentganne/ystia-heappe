#!/usr/bin/env bash

# 
# Yorc expected Job statuses to be returned in env. variable TOSCA_JOB_STATUS are:
# - QUEUED: meaning that the job is submitted but didn't started yet.
# - RUNNING: meaning that the job is still running.
# - COMPLETED: meaning that the job is done successfully.
# - FAILED: meaning that the job is done but in error.

echo "Getting job $TOSCA_JOB_ID status..."

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

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/JobManagement/GetCurrentInfoForJob \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"submittedJobInfoId\": \"$TOSCA_JOB_ID\", \"sessionCode\": \"$SESSION_ID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res getting current job info from HEAppE Middleware"
    echo $response
    exit 1
fi

heappeJobState=`getJsonval state $response`

# The orchestrator expects the job state to be available in TOSCA_JOB_STATUS env variable
TOSCA_JOB_STATUS="FAILED"
if [ -z "$heappeJobState" ]; then
   echo "Error: could not get job state for job $TOSCA_JOB_ID session $ $SESSION_ID response $response "
elif [ "$heappeJobState" -lt "3" ]; then
    TOSCA_JOB_STATUS="QUEUED"
elif  [ "$heappeJobState" -eq "3" ]; then
    TOSCA_JOB_STATUS="RUNNING"
elif  [ "$heappeJobState" -eq "4" ]; then
    TOSCA_JOB_STATUS="COMPLETED"
else
    echo "Will return job $TOSCA_JOB_ID failed from info: $response"
fi
export TOSCA_JOB_STATUS

echo "Got job $TOSCA_JOB_ID HEAppE state $heappeJobState => Yorc state $TOSCA_JOB_STATUS"
