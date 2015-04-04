#!/bin/bash

# battle/MechBattleConsoleForLinuxServer battle/BattleModeConfig.conf 2 $1 $2 battle/result/$3.txt battle/result/$3.xml
./MechBattleConsoleForLinuxServer ./BattleModeConfig.conf 2 $1 $2 ./result/$3.txt ./result/$3.xml
