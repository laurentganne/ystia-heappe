#!/usr/bin/env bash


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

echo "Deleting job ${JOB_ID}..."

response=`curl --request POST \
               --insecure \
               --url ${HEAPPE_URL}/heappe/JobManagement/DeleteJob \
               --header 'Content-Type: application/json' \
               --silent \
               --data "{\"submittedJobInfoId\": \"$JOB_ID\", \"sessionCode\": \"$sessionID\"}"`

res=$?
if [ $res -ne 0 ]
then
    echo "Exiting on error $res deleting job $JOB_ID on HEAppE Middleware, session $sessionID"
    echo $response
    exit 1
fi

echo "Delete response: $response"


echo "Job $JOB_ID deleted"
