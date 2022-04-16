#!/bin/bash
screen -dm -S "server" java -Xmx$1M -Xms$1M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dsun.jnu.encoding=UTF-8 -Dfile.encoding=UTF-8 -Dlog4j2.formatMsgNoLookups=true -Dfml.readTimeout=180 -jar paper-1.12.2-latest.jar nogui

while :
do
    if grep -q "Done (" /logs/latest.log; then
        break
    else
        sleep 1
    fi
done

screen -S server -p 0 -X stuff "wb world set $2 $2 0 0^M"
sleep 1
screen -S server -p 0 -X stuff "wb world fill^M"
sleep 1
screen -S server -p 0 -X stuff "wb fill confirm^M"

while :
do
    if grep -q "completed for world" /logs/latest.log; then
        break
    else
        sleep 1
    fi
done

screen -S server -p 0 -X stuff "stop^M"
sleep 5

mkdir /output/$3
cp -r /world/* /output/$3
