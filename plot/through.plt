set xrange [0:40]
#set yrange [1000000:2000000]
#set yrange [50000:8000000]
set key right
set grid
set terminal png
set output './thr.png'

set xlabel 'time'
set ylabel 'data tx sum'

plot"../results/n0-n1.thr" using 1:2 with linespoints pt 1 ps 0.9 t "n0-n1",\
    "../results/n9-n2.thr" using 1:2 with linespoints pt 1 ps 0.9 t "n9-n2",\
    "../results/n8-n2.thr" using 1:2 with linespoints pt 1 ps 0.9 t "n8-n2",\
    "../results/n5-n2.thr" using 1:2 with linespoints pt 1 ps 0.9 t "n5-n2"
pause -1