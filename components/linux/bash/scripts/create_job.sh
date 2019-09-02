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

sessionID=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/UserAndLimitationManagement/AuthenticateUserPassword \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"credentials\": {\"username\": \"$HEAPPE_USER\", \"password\": \"$HEAPPE_PASSWORD\"}}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res authenticating to HEAppE Middleware"
    echo $sessionID
    exit 1
fi

echo "Creating job..."

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/JobManagement/CreateJob \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"jobSpecification\": $JOB_SPECIFICATION, \"sessionCode\": \"$sessionID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res creating job $JOB_ID on HEAppE Middleware, session $sessionID"
    echo $response
    exit 1
fi

echo "Create response: $response"

JOB_ID=`getJsonval id $response`
export JOB_ID

echo "Job $JOB_ID created"
