#!/usr/bin/gnuplot -c
# Plot memory and CPU usage over time. Usage:
# <input file> [<output .png file>] [time(in minutes)]
# Arguments:
infile=ARG1
outfile=ARG2

set term x11
set title 'Memory, CPU usage from ' . infile
set xdata time
set timefmt "%s"
set xlabel "Time (secs)"
set xrange[0:300]
set ylabel "Memory usage (mbytes)"
set yrange[0:20]
set format y '%.1s%cmB'

set y2label 'CPU usage (%)'
set format y2 '%.0s%%'
set y2range[0:150]
set y2tics nomirror
set tics out

if (exists("outfile") && strlen(outfile) > 0) {
    print "Outputting to the file ", outfile
    set term png # 1024,768
    set output outfile
}

# Styling
set style line 1 linewidth 3 linecolor 'blue'
set style line 2 linewidth 3 linecolor 'red'
set tics font ", 10"

plot infile u 1:3 with  lp axes x1y2 title "cpu" linestyle -1 linewidth 1 linecolor 'red', \
    infile using 1:2 with linespoints axes x1y1 title "memory" linestyle -1 linewidth 1 linecolor 'blue'
