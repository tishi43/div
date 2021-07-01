onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /div_by_shift_sum_tb/div_inst0/d1
add wave -noupdate /div_by_shift_sum_tb/div_inst0/div_result
add wave -noupdate /div_by_shift_sum_tb/div_inst0/div_sub_ge0
add wave -noupdate /div_by_shift_sum_tb/div_inst0/div_sub_val
add wave -noupdate /div_by_shift_sum_tb/div_inst0/i_d0
add wave -noupdate /div_by_shift_sum_tb/div_inst0/i_d1
add wave -noupdate /div_by_shift_sum_tb/div_inst0/i_valid
add wave -noupdate /div_by_shift_sum_tb/div_inst0/o_div_remain
add wave -noupdate /div_by_shift_sum_tb/div_inst0/o_div_result
add wave -noupdate /div_by_shift_sum_tb/div_inst0/o_valid
add wave -noupdate /div_by_shift_sum_tb/div_inst0/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {262 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 111
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
WaveRestoreZoom {251 ns} {268 ns}
