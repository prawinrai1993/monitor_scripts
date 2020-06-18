#!/bin/bash
# Usage: nohup ./monitor-usage.sh <PID of the process>  <time(in minutes)>
# Output: top.dat with lines such as `1539689171 305m 2.0`, i.e. unix time - memory with m/g suffix - CPU load in %
# To plot the output, see https://gist.github.com/jakubholynet/931a3441982c833f5f8fcdcf54d05c91
export PID=$1
export time_period=$2
rm top.dat

counter=0
runtime="$time_period minute"
endtime=$(date -ud "$runtime" +%s)

while [[ $(date -u +%s) -le $endtime ]]
do
	counter=$((counter+1))
	top -p $PID -bn  1 | grep $PID | awk -v var="$counter" '{print var,$6 / 1024,$9}' >> top.dat
	sleep 1
done
