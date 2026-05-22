#!/bin/bash
awk -F ' : ' '
function print_average() {
    if (count > 0) {
        avg = sum / count
        print "Average_Running_Children_of_ParentID=" current_ppid " is " avg
    }
}

{
    split($1, a, "="); pid = a[2]
    split($2, b, "="); ppid = b[2]
    split($3, c, "="); art = c[2]

    if (ppid != current_ppid && NR > 1) {
        print_average()
        sum = 0
        count = 0
    }

    current_ppid = ppid
    sum += art
    count++

    print $0
}

END {
    print_average()
}
' cpu_burst_stats.txt > cpu_burst_with_averages.txt
