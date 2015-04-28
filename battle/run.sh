#!/bin/bash
ulimit -t 60 -m 131072 -n 100;
setuid 2333 /real_run.sh $1 $2 $3
