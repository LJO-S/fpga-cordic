onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /postproc_range_reduce_tb/clk
add wave -noupdate -group TB /postproc_range_reduce_tb/i_config
add wave -noupdate -group TB /postproc_range_reduce_tb/i_mode
add wave -noupdate -group TB /postproc_range_reduce_tb/i_submode
add wave -noupdate -group TB /postproc_range_reduce_tb/i_x
add wave -noupdate -group TB /postproc_range_reduce_tb/i_y
add wave -noupdate -group TB /postproc_range_reduce_tb/i_z
add wave -noupdate -group TB /postproc_range_reduce_tb/i_bitshift_x
add wave -noupdate -group TB /postproc_range_reduce_tb/i_range_n
add wave -noupdate -group TB /postproc_range_reduce_tb/i_valid
add wave -noupdate -group TB /postproc_range_reduce_tb/o_x
add wave -noupdate -group TB /postproc_range_reduce_tb/o_y
add wave -noupdate -group TB /postproc_range_reduce_tb/o_z
add wave -noupdate -group TB /postproc_range_reduce_tb/o_valid
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_input_data_x_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_input_data_y_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_input_data_z_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_x_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_y_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_r_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_n_int
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_auto_set
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_auto_done
add wave -noupdate -group TB /postproc_range_reduce_tb/auto_data_x
add wave -noupdate -group TB /postproc_range_reduce_tb/auto_data_y
add wave -noupdate -group TB /postproc_range_reduce_tb/auto_data_z
add wave -noupdate -group TB /postproc_range_reduce_tb/auto_shift_x
add wave -noupdate -group TB /postproc_range_reduce_tb/auto_range_n
add wave -noupdate -group TB /postproc_range_reduce_tb/auto_data_tvalid
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_input_data_x_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_input_data_y_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_input_data_z_float 
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_x_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_y_float
add wave -noupdate -group TB /postproc_range_reduce_tb/tb_output_data_z_float
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/clk
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_config
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_mode
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_submode
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_x
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_y
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_z
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_bitshift_x
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_range_n
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/i_valid
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/o_x
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/o_y
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/o_z
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/o_valid
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/s_reduce_state
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_mode
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_submode
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_config
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_x
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_y
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_z
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_valid
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_bitshift_x
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_range_n
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_vec_hyp_ln2
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned -childformat {{/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(41) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(40) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(39) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(38) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(37) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(36) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(35) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(34) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(33) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(32) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(31) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(30) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(29) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(28) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(27) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(26) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(25) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(24) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(23) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(22) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(21) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(20) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(19) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(18) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(17) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(16) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(15) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(14) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(13) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(12) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(11) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(10) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(9) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(8) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(7) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(6) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(5) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(4) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(3) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(2) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(1) -radix unsigned} {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(0) -radix unsigned}} -subitemconfig {/postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(41) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(40) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(39) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(38) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(37) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(36) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(35) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(34) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(33) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(32) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(31) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(30) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(29) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(28) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(27) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(26) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(25) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(24) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(23) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(22) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(21) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(20) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(19) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(18) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(17) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(16) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(15) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(14) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(13) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(12) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(11) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(10) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(9) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(8) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(7) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(6) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(5) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(4) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(3) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(2) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(1) {-radix unsigned} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2(0) {-radix unsigned}} /postproc_range_reduce_tb/postproc_range_reduce_inst/r_reduction_ln2
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_exp_pos_n
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_exp_neg_n
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_exp_pos_z
add wave -noupdate -expand -group {Postproc Range Reduce} -radix unsigned /postproc_range_reduce_tb/postproc_range_reduce_inst/r_exp_neg_z
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8169 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {36171 ps}
