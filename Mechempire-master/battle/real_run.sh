#!/bin/bash
rm -f /bin/setuid
rm -f /bin/rm
timeout 60 /MechBattleConsoleForLinuxServer /BattleModeConfig.conf 2 /1.so /2.so /$3.txt /$3.xml
