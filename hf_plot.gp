set terminal png enhanced
set output "hf_plot.png"

set xlabel "r"
set ylabel "{/Symbol f}(r)"

set size square

plot "plot_data.dat" using 1:2 notitle with lines