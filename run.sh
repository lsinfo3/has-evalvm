#!/bin/bash

log_output_dir=$(pwd)"/logs/"

#start server
killall python
sleep 2s
> server.log
python -m SimpleHTTPServer &> server.log &
STATUS=0
while [ $STATUS -eq 0 ]; do
#    echo $STATUS
    STATUS=$(pgrep python | wc -l)
    sleep 1s
done

bw=$1;
cvar=$2;
init=$3;
p=$4;
reps=$5; 
enc_type=$6; #specify if variable or fixed
vid_id=$7; #name of video, eg bbb
duration=$8
heuristic=$9

cd has-evalvm/shaping
sudo ./setupShaper.sh	
echo $bw > value
sudo ./rate.sh
cd ../..

direct=$log_output_dir
mkdir $direct

std=$(echo $cvar*$bw | bc)
bwparam=$bw","${std%.*}
counter=1
while [ $counter -le $reps ]; do
    python tapas/play.py -u http://127.0.0.1:8000/has-evalvm/$vid_id_$enc_type_$duration.m3u8 -m nodec -i $init -b $bwparam -p 40 -c $heuristic > player.log
    cp player.log "$direct"/player_"$bw"kbit_cv"$cvar"_init"$init"_p40_"$counter"_"$vid_id"_"$enc_type"_"$duration".log
    
    sleep 1s
    echo "completed $cvar, $bw, $counter, $vid_id, $enc_type, $duration"
    counter=$((counter + 1))
done
