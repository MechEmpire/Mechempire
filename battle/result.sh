#!/bin/bash
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
JAIL_PATH="/tmp/jail_$3"
cp $JAIL_PATH/$3.txt /home/rails-deploy/Mechempire/battle/result/$3.txt
cp $JAIL_PATH/$3.xml /home/rails-deploy/Mechempire/battle/result/$3.xml
rm -rf $JAIL_PATH