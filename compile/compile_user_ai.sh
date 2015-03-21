#!/bin/bash

while getopts "p:" arg
  do
    case $arg in
         p)
            g++ -O2 -fPIC -shared -o $OPTARG/libmyAI.so $OPTARG/myAI/*.cpp $OPTARG/RobotAIFactoryLinux.cpp
            ;;
         ?)
        echo "unkonw argument"
    exit 1
    ;;
  esac
done