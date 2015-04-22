#!/bin/bash
ulimit -t 60 -m 131072;
timeout 60 /MechBattleConsoleForLinuxServer /BattleModeConfig.conf 2 /1.so /2.so /$3.txt /$3.xml