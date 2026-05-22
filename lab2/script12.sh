#!/bin/bash
if [ -z "$1" ]; then
    echo "Использование: $0 <количество_секунд_N>"
    exit 1
fi

N=$1
NEW_NICE=10

if [ "$EUID" -ne 0 ]; then
    echo "Пожалуйста, запустите скрипт от имени root."
    exit 1
fi

uptime_sec=$(awk '{print $1}' /proc/uptime)

CLK_TCK=$(getconf CLK_TCK)


for pid_dir in /proc/[0-9]*/; do
    pid=$(basename "$pid_dir")
    
    if [ -f "${pid_dir}stat" ]; then
        starttime_ticks=$(awk '{print $22}' "${pid_dir}stat" 2>/dev/null)
        
        if [ -n "$starttime_ticks" ]; then
            starttime_sec=$(echo "$starttime_ticks / $CLK_TCK" | bc)
            
            process_age=$(echo "$uptime_sec - $starttime_sec" | bc | cut -d'.' -f1)
            
            if [ "$process_age" -gt "$N" ] && [ "$pid" -ne 1 ] && [ "$pid" -ne $$ ]; then
                pname=$(ps -p $pid -o comm= 2>/dev/null)
                
                current_nice=$(ps -p $pid -o nice= 2>/dev/null | tr -d ' ')
                
                if [ -n "$current_nice" ] && [ "$current_nice" -ne "$NEW_NICE" ]; then
                    echo "Процесс: $pname (PID: $pid), работает: $process_age сек. Текущий nice: $current_nice"
                    renice -n "$NEW_NICE" -p "$pid" > /dev/null
                fi
            fi
        fi
    fi
done

