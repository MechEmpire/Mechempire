#!/bin/bash
#/usr/bin/env > /tmp/who
#ulimit -m 131072 -t 60
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
while getopts "p:" arg
  do
    case $arg in
         p)
          timeout 30  g++ -O2 -fno-asm -fPIC -shared -I/vagrant/Mechempire/compile/include/sys/ -I$OPTARG/ -o $OPTARG/libmyAI.so $OPTARG/*.cpp /vagrant/Mechempire/compile/include/sys/*.cpp /vagrant/Mechempire/compile/include/RobotAIFactoryLinux.cpp
            ;;
         ?)
        echo "unkonw argument"
    exit 1
    ;;  
  esac
done
