#!/bin/bash

while getopts "p:" arg
  do
    case $arg in
         p)
            g++ -O2 -fPIC -shared -I/vagrant/Mechempire/compile/include/sys/ -I$OPTARG/ -o $OPTARG/libmyAI.so $OPTARG/*.cpp /vagrant/Mechempire/compile/include/sys/*.cpp /vagrant/Mechempire/compile/include/RobotAIFactoryLinux.cpp
            ;;
         ?)
        echo "unkonw argument"
    exit 1
    ;;
  esac
done