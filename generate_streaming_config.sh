>bbb_fix_len_fix_bw

reps=10;

#adaptation heuristics
declare -a heuristics=("conventional" \
"festive" \
"panda" \
"elastic" \
)

#fix bandwidht limits
declare -a bw_lims=(480 \
600 \
720 \
900 \
1200 \
1800 \
2400 \
3000
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
declare -a videos=( "bbb" \
"sintel" )
#"9o9")

#fix_lengtt vids;
declare -a fix_vids=("bbb;3" \
"bbb;3_5" \
"bbb_4" \
"bbb_4_5" \
"bbb_6" \
"bbb_8" \
"bbb_10"
#"bbb;5" \
#"bbb;6_5" \
#"bbb;7" \
#"sintel;5" \
#"sintel;8" \
#"sintel;9_5" \
#"sintel;15"  \
#"9o9;4_5" \
#"9o9;8" \
#"9o9;8_5" \
#"9o9;9" \
#"AeL;10" \
#"AeL;15" \
#"AeL;4_5" \
#"AeL;8_5" \
)


for h in "${heuristics[@]}"
do
	#variable
	
	#for v in "${var_ranges[@]}"
	#do
		#static bandwidth
	#	for b in "${bw_lims[@]}"
	#	do
	#		for video in "${videos[@]}"
	#		do
	#			echo "$b;0;0;40;$reps;var;$video;$v;$h" >> streaming_part1_fixbw
	#		done	
	#	done
	
	#done
	for f in ${fix_vids[@]}
	do
		for b in "${bw_lims[@]}"
		do
			echo "$b;0;0;40;$reps;fix;$f;$h" >> bbb_fix_len_fix_bw
		done
	done
	
done


#for h in "${heuristics[@]}"
#do
	
		#variable
#	for v in "${var_ranges[@]}"
#	do
#		#static bandwidth
#		for t in "${trace_list[@]}"
#		do
#			for video in "${videos[@]}"
#			do
#				echo "$t;0;0;40;$reps;var;$video;$v;$h" >> streaming_part1_traces
#			done	
#		done
#	
#	done
#	for f in ${fix_vids[@]}
#	do
#		for t in "${trace_list[@]}"
#		do
#			echo "$t;0;0;40;$reps;fix;$f;$h" >> streaming_part1_traces
#		done
#	done
	
	
#done	
	
