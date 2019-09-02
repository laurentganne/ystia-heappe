#!/usr/bin/env bash


# From https://code.it4i.cz/ADAS/HEAppE/Middleware/blob/new_master/DomainObjects/JobManagement/JobInformation/JobState.cs
# HEAppE Job statuses are:
# - Configuring = 1
# - Submitted = 2
# - Queued = 4
# - Running = 8
# - Finished = 16
# - Failed = 32
# - Canceled = 64
# 
# Yorc expected Job statuses to be returned in env. variable TOSCA_JOB_STATUS are:
# - QUEUED: meaning that the job is submitted but didn't started yet.
# - RUNNING: meaning that the job is still running.
# - COMPLETED: meaning that the job is done successfully.
# - FAILED: meaning that the job is done but in error.

echo "Getting job $JOB_ID status..."

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
               --url ${HEAPPE_URL}//heappe/JobManagement/GetCurrentInfoForJob \
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

heappeJobStatus=`getJsonval status $response`

# The orchestrator expects the job status to be available in TOSCA_JOB_STATUS env variable
TOSCA_JOB_STATUS="COMPLETED"
if [ "$heappeJobStatus" -lt "8" ]; then
    TOSCA_JOB_STATUS="QUEUED"
elif  [ "$heappeJobStatus" -eq "8" ]; then
    TOSCA_JOB_STATUS="RUNNING"
elif  [ "$heappeJobStatus" -eq "16" ]; then
    TOSCA_JOB_STATUS="RUNNING"
else
    TOSCA_JOB_STATUS="FAILED"
fi
export TOSCA_JOB_STATUS

echo "Got job $JOB_ID HEAppE status $heappeJobStatus => Yorc status $TOSCA_JOB_STATUS"
