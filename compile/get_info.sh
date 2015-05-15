#!/bin/bash
#/usr/bin/env > /tmp/who
#ulimit -m 131072 -t 60
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
while getopts "p:" arg
  do
    case $arg in
         p)
          ./RobotAppearanceReader $OPTARG/libmyAI.so stdout
            ;;
         ?)
        echo "unkonw argument"
    exit 1
    ;;  
  esac
done