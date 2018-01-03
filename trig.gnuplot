set terminal svg enhanced size 1000 600
set samples 1001  # high quality
set border 31 linewidth .3 # thin border
set output "trig.svg"

set xrange[-7:7]
set yrange[-3:3]
plot sin(x), cos(x), tan(x), sinh(x), cosh(x), tanh(x)
unset output
exit

