set term postscript eps enhanced color
set output "monte_carlo.eps"
#set logscale y
set ylabel "MSE"
set xlabel "Link Success Probability"
set xrange [0.1:0.9]
set yrange [0:0.5]

plot	"mse_results.txt" using 1:2 title "Monte Carlo" with lines lw 2

set output "av.eps"
plot	"mse_results.txt" using 1:3 title "Antithetic Variables" with lines lw 2
