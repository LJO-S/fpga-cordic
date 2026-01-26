onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /iterator_tb/main/v_rad_float
add wave -noupdate -radix binary /iterator_tb/main/v_rad_fixed
add wave -noupdate -expand -group TB /iterator_tb/runner_cfg
add wave -noupdate -expand -group TB /iterator_tb/G_TYPE
add wave -noupdate -expand -group TB /iterator_tb/G_NBR_OF_ITERATIONS
add wave -noupdate -expand -group TB /iterator_tb/G_FILEPATH_JSON
add wave -noupdate -expand -group TB /iterator_tb/G_INIT_FILEPATH_CIRC
add wave -noupdate -expand -group TB /iterator_tb/G_INIT_FILEPATH_HYPER
add wave -noupdate -expand -group TB /iterator_tb/o_data_x
add wave -noupdate -expand -group TB /iterator_tb/o_data_y
add wave -noupdate -expand -group TB /iterator_tb/o_data_z
add wave -noupdate -expand -group TB /iterator_tb/o_data_tvalid
add wave -noupdate -expand -group TB /iterator_tb/tb_input_data_x_float
add wave -noupdate -expand -group TB /iterator_tb/tb_input_data_y_float
add wave -noupdate -expand -group TB /iterator_tb/tb_input_data_z_float
add wave -noupdate -expand -group TB /iterator_tb/tb_output_data_x_float
add wave -noupdate -expand -group TB /iterator_tb/tb_output_data_y_float
add wave -noupdate -expand -group TB /iterator_tb/tb_output_data_z_float
add wave -noupdate -expand -group TB /iterator_tb/tb_auto_set
add wave -noupdate -expand -group TB /iterator_tb/tb_auto_done
add wave -noupdate -expand -group TB /iterator_tb/auto_data_x
add wave -noupdate -expand -group TB /iterator_tb/auto_data_y
add wave -noupdate -expand -group TB /iterator_tb/auto_data_z
add wave -noupdate -expand -group TB /iterator_tb/auto_data_tvalid
add wave -noupdate -expand -group TB /iterator_tb/manual_data_x
add wave -noupdate -expand -group TB /iterator_tb/manual_data_y
add wave -noupdate -expand -group TB /iterator_tb/manual_data_z
add wave -noupdate -expand -group TB /iterator_tb/manual_data_tvalid
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/clk
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/i_mode
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/i_submode
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/i_data_x
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/i_data_y
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/i_data_z
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/i_data_tvalid
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/o_data_x
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/o_data_y
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/o_data_z
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/o_data_tvalid
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/s_operation
add wave -noupdate -expand -group Iterator -divider Shift
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_shift_x
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_shift_y
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_shift_z
add wave -noupdate -expand -group Iterator /iterator_tb/iterator_inst/p_iterate/v_shift_x_float
add wave -noupdate -expand -group Iterator /iterator_tb/iterator_inst/p_iterate/v_shift_y_float
add wave -noupdate -expand -group Iterator /iterator_tb/iterator_inst/p_iterate/v_shift_z_float
add wave -noupdate -expand -group Iterator -divider Add
add wave -noupdate -expand -group Iterator /iterator_tb/iterator_inst/p_iterate/v_iter_x_float
add wave -noupdate -expand -group Iterator /iterator_tb/iterator_inst/p_iterate/v_iter_y_float
add wave -noupdate -expand -group Iterator /iterator_tb/iterator_inst/p_iterate/v_iter_z_float
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_iter_x
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_iter_y
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_iter_z
add wave -noupdate -expand -group Iterator -divider Incr
add wave -noupdate -expand -group Iterator -radix unsigned /iterator_tb/iterator_inst/r_iter
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_iter_stutter
add wave -noupdate -expand -group Iterator -divider Misc
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/r_sign
add wave -noupdate -expand -group Iterator -radix decimal -childformat {{/iterator_tb/iterator_inst/w_circ_angle(31) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(30) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(29) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(28) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(27) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(26) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(25) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(24) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(23) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(22) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(21) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(20) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(19) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(18) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(17) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(16) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(15) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(14) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(13) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(12) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(11) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(10) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(9) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(8) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(7) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(6) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(5) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(4) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(3) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(2) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(1) -radix decimal} {/iterator_tb/iterator_inst/w_circ_angle(0) -radix decimal}} -subitemconfig {/iterator_tb/iterator_inst/w_circ_angle(31) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(30) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(29) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(28) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(27) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(26) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(25) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(24) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(23) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(22) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(21) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(20) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(19) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(18) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(17) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(16) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(15) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(14) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(13) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(12) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(11) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(10) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(9) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(8) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(7) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(6) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(5) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(4) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(3) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(2) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(1) {-height 19 -radix decimal} /iterator_tb/iterator_inst/w_circ_angle(0) {-height 19 -radix decimal}} /iterator_tb/iterator_inst/w_circ_angle
add wave -noupdate -expand -group Iterator -radix decimal /iterator_tb/iterator_inst/w_hyper_angle
add wave -noupdate -group {Circ Rom} /iterator_tb/iterator_inst/circular_rom_inst/clk
add wave -noupdate -group {Circ Rom} /iterator_tb/iterator_inst/circular_rom_inst/i_raddr
add wave -noupdate -group {Circ Rom} /iterator_tb/iterator_inst/circular_rom_inst/o_rdata
add wave -noupdate -group {Circ Rom} /iterator_tb/iterator_inst/circular_rom_inst/mem_angle
add wave -noupdate -group {Hyper Rom} /iterator_tb/iterator_inst/hyperbolic_rom_inst/clk
add wave -noupdate -group {Hyper Rom} /iterator_tb/iterator_inst/hyperbolic_rom_inst/i_raddr
add wave -noupdate -group {Hyper Rom} /iterator_tb/iterator_inst/hyperbolic_rom_inst/o_rdata
add wave -noupdate -group {Hyper Rom} /iterator_tb/iterator_inst/hyperbolic_rom_inst/mem_angle
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {592424 ps} 0}
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
WaveRestoreZoom {554718 ps} {665246 ps}
