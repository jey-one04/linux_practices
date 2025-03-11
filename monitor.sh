#!bin/bash

#Linux system monitor using Bash
CPU_THRESHOLD=50
MEMORY_THESHOLD=40
DISK_THRESHOLD=60
	
while true; do
	
	#get CPU usage
	cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

	#get memory usage
	
	total_memory=$(free -m | awk 'NR==2{print $2}')
	used_memory=$(free -m | awk 'NR==2{print $3}')
	memory_usage=$((used_memory / total_memory * 100))

	#get disk_usage
	disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//g')


	cpu_usage_int=$(echo "$cpu_usage" | awk '{print int($1)}')


	if ((cpu_usage_int > CPU_THRESHOLD)); then
	echo "High percentage of CPU utilization: ${cpu_usage_int}"
	fi

	if (( memory_usage > MEM_THRESHOLD )); then
	echo "High memory usage detected: ${memory_usage}"
	fi

	if ((disk_usage > DISK_THRESHOLD )); then
	echo -e "High disk usage detected: ${disk_usage}\n"
	fi

	sleep 10
done

