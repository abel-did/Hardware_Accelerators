if [file exists work]		{ 
	vdel -lib work -all
}
vlib work 
vmap -c work work 

set liste {
bin2bcd
}

foreach el $liste {
vcom  ../rtl/$el.vhd
}

vcom -2008 tb_bin2bcd.vhd
vsim -voptargs=+acc tb_bin2bcd

source chrono.tcl

run 180 ns
