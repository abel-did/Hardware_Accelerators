if [file exists work]		{ 
	vdel -lib work -all
}
vlib work 
vmap -c work work 

set liste {
fir
}

foreach el $liste {
vcom  ../rtl/$el.vhd
}

vcom -2008 tb_fir.vhd
vsim -voptargs=+acc tb_fir

source chrono.tcl

run 40000 ns
