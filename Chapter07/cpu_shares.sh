#!/bin/bash -e

CPU_COUNT=$(nproc --all)
START_AT=$(date +%s)
STOP_AT=$(( $START_AT + 60 ))

echo "Detected $CPU_COUNT CPUs"
echo "Time range: $START_AT -> $STOP_AT"

declare -a CONTAINERS

echo "Allocating all cores but one with default shares"
for ((i = 0; i < $CPU_COUNT - 1; i++)); do
  echo "Starting container $i"
  CONTAINERS[i]=$(docker run \
                  -d \
                  ubuntu \
                  /bin/bash -c "c=0; while [ $STOP_AT -gt \$(date +%s) ]; do c=\$((c + 1)); done; echo \$c")
done

echo "Starting container with high shares"
  fast_task=$(docker run \
              -d \
              --cpu-shares 8192 \
              ubuntu \
              /bin/bash -c "c=0; while [ $STOP_AT -gt \$(date +%s) ]; do c=\$((c + 1)); done; echo \$c")

  CONTAINERS[$((CPU_COUNT - 1))]=$fast_task

echo "Waiting full minute for containers to finish..."
sleep 62

for ((i = 0; i < $CPU_COUNT; i++)); do
  container_id=${CONTAINERS[i]}
  echo "Container $i counted to $(docker logs $container_id)"
  docker rm $container_id >/dev/null
done
