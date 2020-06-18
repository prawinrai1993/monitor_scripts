
#!/bin/bash    
time_period=$1
runtime="$time_period minute"
endtime=$(date -ud "$runtime" +%s)

while [[ $(date -u +%s) -le $endtime ]]
do
    echo "Time Now: `date +%H:%M:%S`"
    ab -n 50000 -c 100 http://localhost:8888/ > output.txt &
    P2=$!
    wait $P2
done

echo 'Done'
