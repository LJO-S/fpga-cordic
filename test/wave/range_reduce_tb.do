onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/clk
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/i_x
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/i_y
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/i_z
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/i_valid
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/o_x
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/o_y
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/o_r
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/o_n
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/o_valid
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_input_data_x_float
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_input_data_y_float
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_input_data_z_float
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_output_data_x_float
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_output_data_y_float
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_output_data_r_float
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_output_data_n_int
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_auto_set
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/tb_auto_done
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/auto_data_x
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/auto_data_y
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/auto_data_z
add wave -noupdate -expand -group TB -radix decimal /range_reduce_tb/auto_data_tvalid
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/clk
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/i_x
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/i_y
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/i_z
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/i_valid
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/o_x
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/o_y
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/o_r
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/o_n
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/o_valid
add wave -noupdate -expand -group {Range Reduce} -divider {PIPE 0}
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_x
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_y
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_z
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_range_n_mult
add wave -noupdate -expand -group {Range Reduce} -divider {PIPE 1}
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_x_d0
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_y_d0
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_z_d0
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_valid_d0
add wave -noupdate -expand -group {Range Reduce} /range_reduce_tb/range_reduce_inst/p_range_reduce/v_range_n_shift
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_range_n
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/p_range_reduce/v_n_float
add wave -noupdate -expand -group {Range Reduce} -divider {PIPE 2}
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_x_d1
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_y_d1
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_z_d1
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_valid_d1
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_range_n_d0
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_subtract
add wave -noupdate -expand -group {Range Reduce} -divider {PIPE 3}
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_x_d2
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_y_d2
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_valid
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_valid_d2
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_range_n_d1
add wave -noupdate -expand -group {Range Reduce} /range_reduce_tb/range_reduce_inst/p_range_reduce/v_subtract_shift
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/r_range_r
add wave -noupdate -expand -group {Range Reduce} -radix decimal /range_reduce_tb/range_reduce_inst/p_range_reduce/v_r_float
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8210 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 189
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {34125 ps}
