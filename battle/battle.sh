#!/bin/bash
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
rm -rf /tmp/jail
mkdir -p /tmp/jail/{bin,lib}
cp /lib/x86_64-linux-gnu/ -r  /tmp/jail/lib
cp /home/rails-deploy/Mechempire/battle/libBattleCore.so /tmp/jail/lib
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /tmp/jail/lib
cp /bin/bash /tmp/jail/bin
cp cp /usr/bin/timeout /tmp/jail/bin
cp battle/MechBattleConsoleForLinuxServer /tmp/jail/MechBattleConsoleForLinuxServer
cp battle/BattleModeConfig.conf /tmp/jail/BattleModeConfig.conf
cp $1 /tmp/jail/1.so
cp $2 /tmp/jail/2.so
(
sudo chroot /tmp/jail
ulimit -t 60 -m 131072;
timeout 60 /MechBattleConsoleForLinuxServer /BattleModeConfig.conf 2 /1.so /2.so /$3.txt /$3.xml
)
cp /tmp/jail/$3.txt battle/result/$3.txt
cp /tmp/jail/$3.xml battle/result/$3.xml
