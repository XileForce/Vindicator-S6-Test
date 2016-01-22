#!/system/bin/sh

# Tweak VM and Swap
echo "128"	> /sys/block/sda/queue/read_ahead_kb
echo "128"	> /sys/block/sdb/queue/read_ahead_kb
echo "128"	> /sys/block/sdb/queue/read_ahead_kb
echo "128"	> /sys/block/vnswap0/queue/read_ahead_kb

#  Start SuperSU daemon
#  Wait for 5 seconds from boot before starting the SuperSU daemon
sleep 5
/system/xbin/daemonsu --auto-daemon &

#  Set interactive governor tuning
#  Wait for 10 seconds from boot so we can ovverride TouchWiz's overrides
sleep 5

#set apollo interactive governor
echo "1" 	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
echo "50000" 	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo "80" 	> /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads

#set atlas interactive governor
echo "1" 	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
echo "50000" 	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo "85" 	> /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads

#Default Task Packing Off
echo "0" > /sys/kernel/hmp/packing_enable

#Default Power Aware Migration Off
echo "0" > /sys/kernel/hmp/power_migration

#Default To ROW IO Scheduler
echo "row" > /sys/block/mmcblk0/queue/scheduler
echo "row" > /sys/block/sda/queue/scheduler
echo "row" > /sys/block/sdb/queue/scheduler
echo "row" > /sys/block/sdc/queue/scheduler
echo "row" > /sys/block/vnswap0/queue/scheduler

