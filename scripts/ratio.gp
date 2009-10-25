set term postscript eps enhanced color
set output "../img/ratio.eps"
#set logscale y
set ylabel "PAV/AV"
set xlabel "Link Success Probability"
set xrange [0.3:0.7]
set yrange [0:20]
unset key

plot	"../data/ratio.txt" using 1:2 title "PAV/AV" with lines lw 4
