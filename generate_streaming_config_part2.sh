>streaming_part2_fixbw
>streaming_part2_traces


reps=10;

#adaptation heuristics
declare -a heuristics=("conventional" \
"festive" \
"panda" \
"elastic" \
)

#fix bandwidht limits
declare -a bw_lims=(7000 \
3500 \
2000 \
1000 \
500 \
)

#bandwidth_traces 
declare -a trace_list=("bicycle_0001" \
"bus_0001" \
"car_0001" \
"foot_0001" \
"train_0001" \
"tram_0001" \
)

#var ranges 
declare -a var_ranges=( "0_15" \
"1_5" \
"0_100" \
"3_10" \
"4_10" 
)

#videos
declare -a videos=( "9o9" \
"AeL")
#"9o9")

#fix_length vids;
#declare -a fix_vids=("tos;7_5" \
#)


for h in "${heuristics[@]}"
do
	#variable
	for v in "${var_ranges[@]}"
	do
		#static bandwidth
		for b in "${bw_lims[@]}"
		do
			for video in "${videos[@]}"
			do
				echo "$b;0;0;40;$reps;var;$video;$v;$h" >> streaming_part2_fixbw
			done	
		done
	
	done
	for f in ${fix_vids[@]}
	do
		for b in "${bw_lims[@]}"
		do
			echo "$b;0;0;40;$reps;fix;$f;$h" >> streaming_part2_fixbw
		done
	done
	
done


for h in "${heuristics[@]}"
do
	
		#variable
	for v in "${var_ranges[@]}"
	do
		#static bandwidth
		for t in "${trace_list[@]}"
		do
			for video in "${videos[@]}"
			do
				echo "$t;0;0;40;$reps;var;$video;$v;$h" >> streaming_part2_traces
			done	
		done
	
	done
	for f in ${fix_vids[@]}
	do
		for t in "${trace_list[@]}"
		do
			echo "$t;0;0;40;$reps;fix;$f;$h" >> streaming_part2_traces
		done
	done
	
	
done	
	
