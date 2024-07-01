if [file exists work]  {
  vdel -lib work -all
}

vlib work
vmap work work 

set liste {
restoring_division
}

foreach el $liste {
vcom ../rtl/$el.vhd
}
vcom  tb_restoring_division.vhd

vsim -voptargs=+acc tb_restoring_division
source chrono.tcl

run 300 ns


