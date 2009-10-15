set term postscript eps enhanced color
set output "../img/pav_2.eps"
set ylabel "MSE"
set xlabel "{/Symbol b}"
set xrange [0:1.0]
set yrange [0:0.5]

plot	"../data/0.2.txt" using 1:2 title "Antithetic Variables" with lines lw 2, \
	"../data/0.2.txt" using 1:3 title "Parameterized Antithetic Variables" with lines lw 2

set output "../img/pav_4.eps"
plot    "../data/0.4.txt" using 1:2 title "Antithetic Variables" with lines lw 2, \
        "../data/0.4.txt" using 1:3 title "Parameterized Antithetic Variables" with lines lw 2

set output "../img/pav_6.eps"
plot    "../data/0.6.txt" using 1:2 title "Antithetic Variables" with lines lw 2, \
        "../data/0.6.txt" using 1:3 title "Parameterized Antithetic Variables" with lines lw 2

set output "../img/pav_8.eps"
plot    "../data/0.8.txt" using 1:2 title "Antithetic Variables" with lines lw 2, \
        "../data/0.8.txt" using 1:3 title "Parameterized Antithetic Variables" with lines lw 2
