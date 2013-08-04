#!/bin/sh
#-------------------------------------------------------------------------------
# This script creates multiple temporary data
# The idea is to create as many files as possible every $PERIOD seconds every
# $LOOP times on $DIR
#-------------------------------------------------------------------------------
DIR="$PWD/tmp_data_dir"
PERIOD=3
LOOP=2
TMPFILE_SIZE=1 # 1 MB

while [ $LOOP -gt 0  ]
  do
    t1=`date +%s`
    t2=$((t1+PERIOD))
    while [ $t1 -lt $t2 ]
      do
        TMPFILE=`mktemp -q $DIR/testdata.XXXXXXX` || exit 1
        dd if=/dev/urandom of="$TMPFILE" bs=1048576 count=$TMPFILE_SIZE
        t1=`date +%s`
      done
    LOOP=$((LOOP-1))
    echo "sleeping $PERIOD seconds, loop: $LOOP"
    sleep $PERIOD
  done
