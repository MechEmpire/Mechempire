#!/bin/bash
PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
(
ulimit -t 60 -m 131072;
timeout 60 battle/MechBattleConsoleForLinuxServer battle/BattleModeConfig.conf 2 $1 $2 battle/result/$3.txt battle/result/$3.xml
)
