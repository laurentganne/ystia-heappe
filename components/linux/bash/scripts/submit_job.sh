#!/usr/bin/env bash

echo "Submitting job ${COMMAND_ID}..."
export TOSCA_JOB_ID="${COMMAND_ID}"

echo "Job $TOSCA_JOB_ID submitted"
