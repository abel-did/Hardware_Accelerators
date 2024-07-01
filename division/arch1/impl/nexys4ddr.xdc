## Clock signal

create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

set_multicycle_path -setup -through [get_cells {div1 div2 div3}] 3
set_multicycle_path -hold -through [get_cells {div1 div2 div3}] 2

