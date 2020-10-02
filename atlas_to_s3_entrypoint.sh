#!/bin/bash

set -e

CRON_ENV="CLUSTER='$CLUSTER'"
if [[ "$ATLAS_USER" ]]; then
    CRON_ENV="$CRON_ENV\nATLAS_USER='$ATLAS_USER'"
fi
if [[ "$ATLAS_PASSWORD" ]]; then
    CRON_ENV="$CRON_ENV\nATLAS_PASSWORD='$ATLAS_PASSWORD'"
fi
if [[ "$DB_NAME" ]]; then
    CRON_ENV="$CRON_ENV\nDB_NAME='$DB_NAME'"
fi
if [[ "$BUCKET" ]]; then
    CRON_ENV="$CRON_ENV\nBUCKET='$BUCKET'"
fi
if [[ "$AWS_ACCESS_KEY_ID" ]]; then
    CRON_ENV="$CRON_ENV\nAWS_ACCESS_KEY_ID='$AWS_ACCESS_KEY_ID'"
fi
if [[ "$AWS_SECRET_ACCESS_KEY" ]]; then
    CRON_ENV="$CRON_ENV\nAWS_SECRET_ACCESS_KEY='$AWS_SECRET_ACCESS_KEY'"
fi

if [[ "$CRON_SCHEDULE" ]]; then
    LOGFIFO='/var/log/cron.fifo'
    if [[ ! -e "$LOGFIFO" ]]; then
        mkfifo "$LOGFIFO"
    fi

    echo -e "$CRON_ENV\n$CRON_SCHEDULE /atlas_to_s3.sh > $LOGFIFO 2>&1" | crontab -
    crontab -l
    cron
    tail -f "$LOGFIFO"
else
    exec /atlas_to_s3.sh
fi
