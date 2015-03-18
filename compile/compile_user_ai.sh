#!/bin/bash

while getopts "p:" arg
  do
    case $arg in
         p)
            # echo "$OPTARG/libmyAI.so $OPTARG/myAI/*.cpp $OPTARG/RobotAIFactoryLinux.cpp"
            g++ -O2 -fPIC -shared -o $OPTARG/libmyAI.so $OPTARG/myAI/*.cpp $OPTARG/RobotAIFactoryLinux.cpp
            # g++ -O2 -fPIC -shared -o /vagrant/mech-website/public/uploads/mech/code/55097be4766167095f000000/myAI/libmyAI.so ./robot_ai_factory/sys /vagrant/mech-website/public/uploads/mech/code/55097be4766167095f000000/myAI
            echo "Compile Success!" #参数存在$OPTARG中
            ;;
         ?)
        echo "unkonw argument"
    exit 1
    ;;
  esac
done

# g++ -O2 -fPIC -shared -o /vagrant/mech-website/public/uploads/mech/code/55097be4766167095f000000/myAI/libmyAI.so /vagrant/mech-website/compile/robot_ai_factory/RobotAIFactoryLinux.cpp

# g++ -O2 -fPIC -shared -o /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/libmyAI.so /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/myAI/*.cpp /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/sys/*.cpp /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/RobotAIFactoryLinux.cpp

# g++ -O2 -fPIC -shared -o /vagrant/libmyAI.so /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/myAI/*.cpp /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/sys/*.cpp /vagrant/mech-website/public/uploads/mech/code/55098434766167095f010000/RobotAIFactory/RobotAIFactoryLinux.cpp
