onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /postproc_quadrant_map_tb/clk
add wave -noupdate -group TB /postproc_quadrant_map_tb/i_x
add wave -noupdate -group TB /postproc_quadrant_map_tb/i_y
add wave -noupdate -group TB /postproc_quadrant_map_tb/i_z
add wave -noupdate -group TB /postproc_quadrant_map_tb/i_quadrant
add wave -noupdate -group TB /postproc_quadrant_map_tb/i_valid
add wave -noupdate -group TB /postproc_quadrant_map_tb/o_x
add wave -noupdate -group TB /postproc_quadrant_map_tb/o_y
add wave -noupdate -group TB /postproc_quadrant_map_tb/o_z
add wave -noupdate -group TB /postproc_quadrant_map_tb/o_valid
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_input_data_x_float
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_input_data_y_float
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_input_data_z_float
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_output_data_x_float
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_output_data_y_float
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_output_data_r_float
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_output_data_n_int
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_auto_set
add wave -noupdate -group TB /postproc_quadrant_map_tb/tb_auto_done
add wave -noupdate -group TB /postproc_quadrant_map_tb/auto_data_x
add wave -noupdate -group TB /postproc_quadrant_map_tb/auto_data_y
add wave -noupdate -group TB /postproc_quadrant_map_tb/auto_data_z
add wave -noupdate -group TB /postproc_quadrant_map_tb/auto_quadrant
add wave -noupdate -group TB /postproc_quadrant_map_tb/auto_data_tvalid
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/clk
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/i_x
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/i_y
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/i_z
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix unsigned /postproc_quadrant_map_tb/postproc_quadrant_map_inst/i_quadrant
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/i_valid
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/o_x
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/o_y
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/o_z
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/o_valid
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/r_x
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/r_y
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/r_z
add wave -noupdate -expand -group {Postproc Quadrant Map} -radix decimal /postproc_quadrant_map_tb/postproc_quadrant_map_inst/r_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2734 ps} 0}
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
WaveRestoreZoom {0 ps} {18375 ps}
