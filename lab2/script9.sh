#!/bin/bash
OUTPUT_FILE="cpu_burst_stats.txt"
TEMP_FILE=$(mktemp)

for pid_dir in /proc/[0-9]*/; do
    pid=$(basename "$pid_dir")

    if [ -f "${pid_dir}status" ] && [ -f "${pid_dir}sched" ]; then
        
        ppid=$(grep -si '^PPid:' "${pid_dir}status" | awk '{print $2}')
        
        sum_exec=$(grep -si 'se\.sum_exec_runtime' "${pid_dir}sched" | awk '{print $3}')
        nr_switches=$(grep -si 'nr_switches' "${pid_dir}sched" | awk '{print $3}')
        
        if [ -n "$ppid" ] && [ -n "$sum_exec" ] && [ -n "$nr_switches" ] && [ "$nr_switches" -ne 0 ]; then
            
            art=$(echo "scale=6; $sum_exec / $nr_switches" | bc 2>/dev/null)
            
            if [ -n "$art" ]; then
               echo "$ppid : ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art" >> "$TEMP_FILE"
            fi
        fi
    fi
done

sort -n -k 1 "$TEMP_FILE" | cut -d ':' -f 2- > "$OUTPUT_FILE"

rm "$TEMP_FILE"

