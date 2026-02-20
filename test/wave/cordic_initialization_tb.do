onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /cordic_initialization_tb/clk
add wave -noupdate -group TB /cordic_initialization_tb/i_x_in
add wave -noupdate -group TB /cordic_initialization_tb/i_x_prev
add wave -noupdate -group TB /cordic_initialization_tb/i_x_type
add wave -noupdate -group TB /cordic_initialization_tb/i_y_in
add wave -noupdate -group TB /cordic_initialization_tb/i_y_prev
add wave -noupdate -group TB /cordic_initialization_tb/i_y_type
add wave -noupdate -group TB /cordic_initialization_tb/i_z_in
add wave -noupdate -group TB /cordic_initialization_tb/i_z_prev
add wave -noupdate -group TB /cordic_initialization_tb/i_z_type
add wave -noupdate -group TB /cordic_initialization_tb/i_valid
add wave -noupdate -group TB /cordic_initialization_tb/o_ready
add wave -noupdate -group TB /cordic_initialization_tb/o_x_data
add wave -noupdate -group TB /cordic_initialization_tb/o_y_data
add wave -noupdate -group TB /cordic_initialization_tb/o_z_data
add wave -noupdate -group TB /cordic_initialization_tb/o_valid
add wave -noupdate -group TB /cordic_initialization_tb/i_ready
add wave -noupdate -group TB /cordic_initialization_tb/tb_input_data_x_float
add wave -noupdate -group TB /cordic_initialization_tb/tb_input_data_y_float
add wave -noupdate -group TB /cordic_initialization_tb/tb_input_data_z_float
add wave -noupdate -group TB /cordic_initialization_tb/tb_output_data_x_float
add wave -noupdate -group TB /cordic_initialization_tb/tb_output_data_y_float
add wave -noupdate -group TB /cordic_initialization_tb/tb_output_data_z_float
add wave -noupdate -group TB /cordic_initialization_tb/tb_output_data_n_int
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/clk
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_x_in
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_x_prev
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_x_type
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_y_in
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_y_prev
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_y_type
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_z_in
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_z_prev
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_z_type
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_valid
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/o_ready
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/o_x_data
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/o_y_data
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/o_z_data
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/o_valid
add wave -noupdate -expand -group {Cordic Init} -radix decimal /cordic_initialization_tb/cordic_initialization_inst/i_ready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
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
WaveRestoreZoom {0 ps} {15748 ps}
