onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /postproc_bitshift_tb/clk
add wave -noupdate -group TB /postproc_bitshift_tb/i_config
add wave -noupdate -group TB /postproc_bitshift_tb/i_mode
add wave -noupdate -group TB /postproc_bitshift_tb/i_submode
add wave -noupdate -group TB /postproc_bitshift_tb/i_x
add wave -noupdate -group TB /postproc_bitshift_tb/i_y
add wave -noupdate -group TB /postproc_bitshift_tb/i_z
add wave -noupdate -group TB /postproc_bitshift_tb/i_bitshift_x
add wave -noupdate -group TB /postproc_bitshift_tb/i_bitshift_y
add wave -noupdate -group TB /postproc_bitshift_tb/i_bitshift_z
add wave -noupdate -group TB /postproc_bitshift_tb/i_valid
add wave -noupdate -group TB /postproc_bitshift_tb/o_x
add wave -noupdate -group TB /postproc_bitshift_tb/o_y
add wave -noupdate -group TB /postproc_bitshift_tb/o_z
add wave -noupdate -group TB /postproc_bitshift_tb/o_valid
add wave -noupdate -group TB /postproc_bitshift_tb/tb_input_data_x_float
add wave -noupdate -group TB /postproc_bitshift_tb/tb_input_data_y_float
add wave -noupdate -group TB /postproc_bitshift_tb/tb_input_data_z_float
add wave -noupdate -group TB /postproc_bitshift_tb/tb_output_data_x_float
add wave -noupdate -group TB /postproc_bitshift_tb/tb_output_data_y_float
add wave -noupdate -group TB /postproc_bitshift_tb/tb_output_data_r_float
add wave -noupdate -group TB /postproc_bitshift_tb/tb_output_data_n_int
add wave -noupdate -group TB /postproc_bitshift_tb/tb_auto_set
add wave -noupdate -group TB /postproc_bitshift_tb/tb_auto_done
add wave -noupdate -group TB /postproc_bitshift_tb/auto_data_x
add wave -noupdate -group TB /postproc_bitshift_tb/auto_data_y
add wave -noupdate -group TB /postproc_bitshift_tb/auto_data_z
add wave -noupdate -group TB /postproc_bitshift_tb/auto_bitshift_x
add wave -noupdate -group TB /postproc_bitshift_tb/auto_bitshift_y
add wave -noupdate -group TB /postproc_bitshift_tb/auto_bitshift_z
add wave -noupdate -group TB /postproc_bitshift_tb/auto_data_tvalid
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/clk
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_config
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_mode
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_submode
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix decimal -childformat {{/postproc_bitshift_tb/postproc_bitshift_inst/i_x(31) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(30) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(29) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(28) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(27) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(26) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(25) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(24) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(23) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(22) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(21) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(20) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(19) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(18) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(17) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(16) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(15) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(14) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(13) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(12) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(11) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(10) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(9) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(8) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(7) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(6) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(5) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(4) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(3) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(2) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(1) -radix decimal} {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(0) -radix decimal}} -subitemconfig {/postproc_bitshift_tb/postproc_bitshift_inst/i_x(31) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(30) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(29) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(28) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(27) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(26) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(25) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(24) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(23) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(22) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(21) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(20) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(19) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(18) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(17) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(16) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(15) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(14) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(13) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(12) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(11) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(10) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(9) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(8) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(7) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(6) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(5) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(4) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(3) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(2) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(1) {-color Aquamarine -radix decimal} /postproc_bitshift_tb/postproc_bitshift_inst/i_x(0) {-color Aquamarine -radix decimal}} /postproc_bitshift_tb/postproc_bitshift_inst/i_x
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix decimal /postproc_bitshift_tb/postproc_bitshift_inst/i_y
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix decimal /postproc_bitshift_tb/postproc_bitshift_inst/i_z
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_bitshift_x
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_bitshift_y
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_bitshift_z
add wave -noupdate -expand -group {Postproc Bitshift} -color Aquamarine -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/i_valid
add wave -noupdate -expand -group {Postproc Bitshift} -color Gold -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/o_x
add wave -noupdate -expand -group {Postproc Bitshift} -color Gold -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/o_y
add wave -noupdate -expand -group {Postproc Bitshift} -color Gold -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/o_z
add wave -noupdate -expand -group {Postproc Bitshift} -color Gold -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/o_valid
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/s_bitshift_state
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_mode
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_submode
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_config
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_x
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_y
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_z
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_bitshift_x
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_bitshift_y
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_bitshift_z
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_total_shift_xz
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_total_shift_yx
add wave -noupdate -expand -group {Postproc Bitshift} -radix unsigned /postproc_bitshift_tb/postproc_bitshift_inst/r_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1356343 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 200
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
WaveRestoreZoom {1283698 ps} {1479282 ps}
