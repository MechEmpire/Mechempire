#!/bin/bash
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
JAIL_PATH="/tmp/jail_$3"
rm -rf $JAIL_PATH
mkdir -p $JAIL_PATH/{bin,lib,usr,battle}
mkdir -p $JAIL_PATH/usr/lib
cp /lib/x86_64-linux-gnu/ -r  $JAIL_PATH/lib
cp /lib64/ -r $JAIL_PATH/
cp /home/rails-deploy/Mechempire/battle/libBattleCore.so $JAIL_PATH/usr/lib
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 $JAIL_PATH/lib
cp /bin/bash $JAIL_PATH/bin
cp /usr/bin/setuid $JAIL_PATH/bin
cp /usr/bin/timeout $JAIL_PATH/bin
cp /usr/bin/rm $JAIL_PATH/bin
cp /home/rails-deploy/Mechempire/battle/MechBattleConsoleForLinuxServer $JAIL_PATH/MechBattleConsoleForLinuxServer
cp /home/rails-deploy/Mechempire/battle/BattleModeConfig.conf $JAIL_PATH/BattleModeConfig.conf
cp $1 $JAIL_PATH/1.so
cp $2 $JAIL_PATH/2.so

cp /home/rails-deploy/Mechempire/battle/run.sh $JAIL_PATH/run.sh
cp /home/rails-deploy/Mechempire/battle/real_run.sh $JAIL_PATH/real_run.sh
cp /home/rails-deploy/Mechempire/battle/ -r $JAIL_PATH/
chmod 777 -R $JAIL_PATH

sudo chroot $JAIL_PATH /run.sh $1 $2 $3
