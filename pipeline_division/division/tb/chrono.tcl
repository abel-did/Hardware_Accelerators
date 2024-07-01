onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_restoring_division/clk
add wave -noupdate /tb_restoring_division/resetn
add wave -noupdate -radix decimal -radixshowbase 0 /tb_restoring_division/dut/dividend
add wave -noupdate -radix decimal -radixshowbase 0 /tb_restoring_division/dut/divisor
add wave -noupdate -radix decimal -radixshowbase 0 /tb_restoring_division/dut/quotient
add wave -noupdate -radix decimal -radixshowbase 0 /tb_restoring_division/dut/remainder
add wave -noupdate -divider pipeline
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {181 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {315 ns}
