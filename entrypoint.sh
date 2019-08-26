#!/bin/bash -e

INTERVAL=${MIRROR_INTERVAL:-3600}
DIRECTORY=${BASE_DIRECTORY:-/mirror}

mkdir -p ${DIRECTORY}/tmp ${DIRECTORY}/clamav ${DIRECTORY}/downloads

while true; do
    clamavmirror -w ${DIRECTORY}/tmp/ -d ${DIRECTORY}/clamav/ -l ${DIRECTORY}/downloads/ ${@}
    echo "Sleeping ${INTERVAL} seconds..."
    sleep ${INTERVAL}
done
