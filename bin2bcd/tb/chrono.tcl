onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb_bin2bcd/dut/N
add wave -noupdate -radix unsigned -childformat {{/tb_bin2bcd/dut/data_in(15) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(14) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(13) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(12) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(11) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(10) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(9) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(8) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(7) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(6) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(5) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(4) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(3) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(2) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(1) -radix hexadecimal} {/tb_bin2bcd/dut/data_in(0) -radix hexadecimal}} -subitemconfig {/tb_bin2bcd/dut/data_in(15) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(14) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(13) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(12) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(11) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(10) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(9) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(8) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(7) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(6) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(5) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(4) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(3) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(2) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(1) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_in(0) {-height 17 -radix hexadecimal}} /tb_bin2bcd/dut/data_in
add wave -noupdate -radix hexadecimal -childformat {{/tb_bin2bcd/dut/data_out(19) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(18) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(17) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(16) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(15) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(14) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(13) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(12) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(11) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(10) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(9) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(8) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(7) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(6) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(5) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(4) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(3) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(2) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(1) -radix hexadecimal} {/tb_bin2bcd/dut/data_out(0) -radix hexadecimal}} -subitemconfig {/tb_bin2bcd/dut/data_out(19) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(18) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(17) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(16) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(15) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(14) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(13) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(12) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(11) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(10) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(9) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(8) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(7) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(6) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(5) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(4) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(3) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(2) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(1) {-height 17 -radix hexadecimal} /tb_bin2bcd/dut/data_out(0) {-height 17 -radix hexadecimal}} /tb_bin2bcd/dut/data_out
add wave -noupdate -radix unsigned /tb_bin2bcd/dut/bin_extended
add wave -noupdate -radix unsigned /tb_bin2bcd/dut/SIZE_BCD
add wave -noupdate -radix unsigned /tb_bin2bcd/dut/NUMBER_BLOCK
add wave -noupdate -radix unsigned /tb_bin2bcd/dut/SIZE_BIN_EXT
add wave -noupdate -radix unsigned /tb_bin2bcd/dut/DEPTH_C
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1661942 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 214
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
WaveRestoreZoom {0 ps} {439 ns}
