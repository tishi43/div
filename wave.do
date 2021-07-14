onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group nopipe -radix unsigned /div_by_shift_sum_tb/div_by_shift_sum_inst1/a
add wave -noupdate -group nopipe -radix unsigned /div_by_shift_sum_tb/div_by_shift_sum_inst1/b
add wave -noupdate -group nopipe /div_by_shift_sum_tb/div_by_shift_sum_inst1/counter
add wave -noupdate -group nopipe /div_by_shift_sum_tb/div_by_shift_sum_inst1/div_result
add wave -noupdate -group nopipe /div_by_shift_sum_tb/div_by_shift_sum_inst1/div_sub_val
add wave -noupdate -group nopipe -radix unsigned /div_by_shift_sum_tb/div_by_shift_sum_inst1/result
add wave -noupdate -group nopipe /div_by_shift_sum_tb/div_by_shift_sum_inst1/valid
add wave -noupdate -radix unsigned /div_by_shift_sum_tb/a
add wave -noupdate -radix unsigned /div_by_shift_sum_tb/b
add wave -noupdate -radix unsigned /div_by_shift_sum_tb/result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38 ns} 0}
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
WaveRestoreZoom {19963 ns} {20002 ns}
