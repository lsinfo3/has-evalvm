#!/bin/sh

## Paths and definitions
tc=/sbin/tc
ext=lo		# Change for your device!
ext_ingress=ifb0	# Use a unique ifb per rate limiter!
			# Set these as per your provider's settings, at 90% to start with
ext_up=1000Mbit		# Max theoretical: for this example, up is 1024kbit
ext_down=1000Mbit	# Max theoretical: for this example, down is 8192kbit
q=1514                  # HTB Quantum = 1500bytes IP + 14 bytes ethernet.
			# Higher bandwidths may require a higher htb quantum. MEASURE.
			# Some ADSL devices might require a stab setting.

quantum=300		# fq_codel quantum 300 gives a boost to interactive flows
			# At higher bandwidths (50Mbit+) don't bother


modprobe ifb
#modprobe sch_fq_codel
modprobe act_mirred

#ethtool -K $ext tso off gso off gro off # Also turn of gro on ALL interfaces 
                                        # e.g ethtool -K eth1 gro off if you have eth1
					# some devices you may need to run these 
					# commands independently
#sleep 3

# Clear old queuing disciplines (qdisc) on the interfaces
#$tc qdisc del dev $ext root
$tc qdisc del dev $ext ingress
$tc qdisc del dev $ext_ingress root
#$tc qdisc del dev $ext_ingress ingress


#########
# INGRESS
#########

# Create ingress on external interface
$tc qdisc add dev $ext handle ffff: ingress

ifconfig $ext_ingress up # if the interace is not up bad things happen

# Forward all ingress traffic to the IFB device
$tc filter add dev $ext parent ffff: protocol all u32 match u32 0 0 action mirred egress redirect dev $ext_ingress

# Create an EGRESS filter on the IFB device
$tc qdisc add dev $ext_ingress root handle 1: htb default 1

# Add root class HTB with rate limiting

$tc class add dev $ext_ingress parent 1: classid 1:1 htb rate $ext_down
#$tc class add dev $ext_ingress parent 1:1 classid 1:11 htb rate $ext_down prio 0 quantum $q


# Add FQ_CODEL qdisc with ECN support (if you want ecn)
#$tc qdisc add dev $ext_ingress parent 1:11 fq_codel quantum $quantum ecn
#$tc qdisc add dev $ext_ingress parent 1:11 handle 2: pfifo limit 10
$tc qdisc add dev $ext_ingress parent 1:1 handle 2: pfifo limit 100


