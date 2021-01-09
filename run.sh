#!/bin/bash

if [ $# != 4 ]; then
  echo "too few args"
  exit 1
fi

declare -A MAP
MAP[0]=A
MAP[1]=B
MAP[2]=C
MAP[3]=D
MAP[4]=E
MAP[5]=F
MAP[6]=G
MAP[7]=H
MAP[8]=I
MAP[9]=J
MAP[10]=K

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NS3DIR=$DIR/ns-3
cd $DIR

cp -n ./scenario/get-route.cc $NS3DIR/scratch/getroute.cc
cp -n ./scenario/provisioning.cc $NS3DIR/scratch/provisioning.cc

for i in $(seq $1 $2); do
  for j in $(seq $3 $4); do
        if [ $i -ne $j ]; then
            mkdir -p "./results/${i}-${j}-b"
            mkdir -p "./results/${i}-${j}-od"
            mkdir -p "./results/${i}-${j}-sep"

            cd $NS3DIR > /dev/null
            ./waf --cwd="../results/${i}-${j}-b" --run "provisioning --OrigNode=${i} --DestNode=${j} --FileName='../../settings/capas_default'"

            cd $DIR  > /dev/null
            python3 ./python/matrix.py "./results/${i}-${j}-b"

            cd $NS3DIR > /dev/null
            ./waf --cwd="../results/${i}-${j}-od" --run "provisioning --OrigNode=${i} --DestNode=${j} --FileName=../../settings/capas_od"
            ./waf --cwd="../results/${i}-${j}-sep" --run "provisioning --OrigNode=${i} --DestNode=${j} --FileName=../../settings/capas_sep"
        fi
    done
done
