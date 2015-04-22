#!/bin/bash
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
rm -rf /tmp/jail
mkdir -p /tmp/jail/{bin,lib,usr}
mkdir -p /tmp/jail/usr/lib
cp /lib/x86_64-linux-gnu/ -r  /tmp/jail/lib
cp /lib64/ -r /tmp/jail/
cp /home/rails-deploy/Mechempire/battle/libBattleCore.so /tmp/jail/usr/lib
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /tmp/jail/lib
cp /bin/bash /tmp/jail/bin
cp /usr/bin/timeout /tmp/jail/bin
cp /home/rails-deploy/Mechempire/battle/MechBattleConsoleForLinuxServer /tmp/jail/MechBattleConsoleForLinuxServer
cp /home/rails-deploy/Mechempire/battle/BattleModeConfig.conf /tmp/jail/BattleModeConfig.conf
cp $1 /tmp/jail/1.so
cp $2 /tmp/jail/2.so
cp run.sh /tmp/jail/run.sh

sudo chroot /tmp/jail /run.sh $1 $2 $3


