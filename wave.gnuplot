set terminal svg enhanced size 1000 600
set samples 1001  # high quality
set border 31 linewidth .3 # thin border
set output "wave.svg"

set xrange[-100:100]
set yrange[-100:100]
plot x * sin(x)
unset output
exit

