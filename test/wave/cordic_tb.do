onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /cordic_tb/clk
add wave -noupdate -group TB /cordic_tb/i_config_data
add wave -noupdate -group TB /cordic_tb/i_config_valid
add wave -noupdate -group TB /cordic_tb/o_config_ready
add wave -noupdate -group TB /cordic_tb/i_data_x
add wave -noupdate -group TB /cordic_tb/i_data_y
add wave -noupdate -group TB /cordic_tb/i_data_z
add wave -noupdate -group TB /cordic_tb/i_data_valid
add wave -noupdate -group TB /cordic_tb/o_data_ready
add wave -noupdate -group TB /cordic_tb/o_data_x
add wave -noupdate -group TB /cordic_tb/o_data_y
add wave -noupdate -group TB /cordic_tb/o_data_z
add wave -noupdate -group TB /cordic_tb/o_data_valid
add wave -noupdate -group TB /cordic_tb/tb_input_data_x_float
add wave -noupdate -group TB /cordic_tb/tb_input_data_y_float
add wave -noupdate -group TB /cordic_tb/tb_input_data_z_float
add wave -noupdate -group TB /cordic_tb/tb_output_data_x_float
add wave -noupdate -group TB /cordic_tb/tb_output_data_y_float
add wave -noupdate -group TB /cordic_tb/tb_output_data_z_float
add wave -noupdate -group TB /cordic_tb/tb_auto_set
add wave -noupdate -group TB /cordic_tb/tb_auto_done
add wave -noupdate -group TB /cordic_tb/auto_data_x
add wave -noupdate -group TB /cordic_tb/auto_data_y
add wave -noupdate -group TB /cordic_tb/auto_data_z
add wave -noupdate -group TB /cordic_tb/auto_data_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/clk
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/i_config_data
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/i_config_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/o_config_ready
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/i_data_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/i_data_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/i_data_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/i_data_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/o_data_ready
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/o_data_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/o_data_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/o_data_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/o_data_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_config_ready_out
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_rom_to_cordic_step_data
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_rom_to_cordic_step_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_rom_step_re
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_rom_step_raddr
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_mode
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_submode
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_norm
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_data_ready_out
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_x_input
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_x_prev
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_x_type
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_y_input
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_y_prev
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_y_type
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_z_input
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_z_prev
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_z_type
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_init_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_init_to_cordic_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_init_to_cordic_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_init_to_cordic_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_init_to_cordic_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_ready
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_preproc_config
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_preproc_config_ovr
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_preproc_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_preproc_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_preproc_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_preproc_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_bitshift_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_bitshift_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_bitshift_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_quadrant
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_range_n
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_preproc_to_cordic_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_iterator_to_cordic_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_iterator_to_cordic_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_iterator_to_cordic_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_iterator_to_cordic_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_iterator_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_iterator_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_iterator_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_iterator_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_postproc_to_cordic_ready
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_bitshift_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_bitshift_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_bitshift_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_range_n
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_quadrant
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_to_postproc_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_postproc_to_cordic_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_postproc_to_cordic_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_postproc_to_cordic_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_postproc_to_cordic_valid
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_out_data_x
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_out_data_y
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_out_data_z
add wave -noupdate -group CORDIC /cordic_tb/cordic_inst/w_cordic_out_data_valid
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/clk
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_config_data
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_config_valid
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_config_ready
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_step_data
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_step_valid
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_step_re
add wave -noupdate -expand -group {Cordic Core} -expand -group Cfg -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_step_raddr
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_mode
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_submode
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_norm_cfg
add wave -noupdate -expand -group {Cordic Core} -color Aquamarine -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_data_x
add wave -noupdate -expand -group {Cordic Core} -color Aquamarine -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_data_y
add wave -noupdate -expand -group {Cordic Core} -color Aquamarine -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_data_z
add wave -noupdate -expand -group {Cordic Core} -color Aquamarine -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_data_valid
add wave -noupdate -expand -group {Cordic Core} -color Aquamarine -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_data_ready
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_x_input
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_x_prev
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_x_type
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_y_input
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_y_prev
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_y_type
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_z_input
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_z_prev
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_z_type
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_init_valid
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_init_x
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_init_y
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_init_z
add wave -noupdate -expand -group {Cordic Core} -group Init -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_init_valid
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_ready
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_config
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_x
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_y
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_z
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_valid
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_x
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_y
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_z
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_bitshift_x
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_bitshift_y
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_bitshift_z
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_quadrant
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_range_n
add wave -noupdate -expand -group {Cordic Core} -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_valid
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_x
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_y
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_z
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_valid
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_x
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_y
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_z
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_ready
add wave -noupdate -expand -group {Cordic Core} -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_valid
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_postproc_ready
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_x
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_y
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_z
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_bitshift_x
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_bitshift_y
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_bitshift_z
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_range_n
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_quadrant
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_postproc_valid
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_postproc_x
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_postproc_y
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_postproc_z
add wave -noupdate -expand -group {Cordic Core} -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_postproc_valid
add wave -noupdate -expand -group {Cordic Core} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_data_x
add wave -noupdate -expand -group {Cordic Core} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_data_y
add wave -noupdate -expand -group {Cordic Core} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_data_z
add wave -noupdate -expand -group {Cordic Core} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_data_valid
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_function_registry
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_offset_pool
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/s_config_state
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/s_cordic_state
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/w_config_ready_out
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/w_cordic_ready_out
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_config_data
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_input_x
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_input_y
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_input_z
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_step
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_step_re
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_step_raddr
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_microcode_start_addr
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_valid_out
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_x
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_y
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_z
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_x_offset
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_y_offset
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_init_z_offset
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_valid_out
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_x_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_y_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_z_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_bitshift_x
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_bitshift_y
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_bitshift_z
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_quadrant
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_preproc_range_n
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_iterator_x_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_iterator_y_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_iterator_z_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_iterator_valid_out
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_postproc_valid_out
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_postproc_x_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_postproc_y_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_postproc_z_in
add wave -noupdate -expand -group {Cordic Core} -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/r_valid_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/clk
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/i_config
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/i_x
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/i_y
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/i_z
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/i_valid
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_ready
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_x
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_y
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_z
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_bitshift_x
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_bitshift_y
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_bitshift_z
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_quadrant
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_range_n
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/i_ready
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/o_valid
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/s_preproc_state
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_x
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_y
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_z
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_config
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_valid_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_norm_input
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_norm_common
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_norm_double
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_bitshift_valid_in
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_valid_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_x_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_y_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_z_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_x_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_y_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_bitshift_z_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_bitshift_x_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_bitshift_y_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_bitshift_z_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_reduce_valid_in
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_reduce_valid_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_reduce_x_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_reduce_y_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_reduce_z_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_reduce_n_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_reduce_n_shift_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_quadrant_valid_in
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_quadrant_valid_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_quadrant_x_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_quadrant_y_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_quadrant_z_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/w_quadrant_out
add wave -noupdate -group Preproc -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/r_quadrant_out
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/clk
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_double
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_common
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_inputs
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_x
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_y
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_z
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_valid
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_y
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_z
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x_shift
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_y_shift
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_z_shift
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_valid
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_common
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_double
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_double_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_abs_int
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_abs_int
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d2
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_d0
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_d1
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_yval_shift
add wave -noupdate -group Preproc -group {Preproc Bitshift} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_zval_shift
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/clk
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/i_x
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/i_y
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/i_z
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/i_valid
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/o_x
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/o_y
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/o_r
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/o_n
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/o_valid
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_x
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_y
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_z
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_x_d0
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_y_d0
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_z_d0
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_x_d1
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_y_d1
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_z_d1
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_x_d2
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_y_d2
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid_d0
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid_d1
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid_d2
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n_mult
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n_d0
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n_d1
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_subtract
add wave -noupdate -group Preproc -group {Preproc range reduce} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_r
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/clk
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_x_in
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_x_prev
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_x_type
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_y_in
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_y_prev
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_y_type
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_z_in
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_z_prev
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_z_type
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_valid
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/o_ready
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/o_x_data
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/o_y_data
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/o_z_data
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/o_valid
add wave -noupdate -group Init /cordic_tb/cordic_inst/cordic_initialization_inst/i_ready
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/clk
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/i_mode
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/i_submode
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/i_data_x
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/i_data_y
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/i_data_z
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/i_data_tvalid
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/o_data_x
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/o_data_y
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/o_data_z
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/o_data_tvalid
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/s_operation
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_iter
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_iter_stutter
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_shift_x
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_shift_y
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_shift_z
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_iter_x
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_iter_y
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_iter_z
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/r_sign
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/w_circ_angle
add wave -noupdate -group Iterator /cordic_tb/cordic_inst/iterator_inst/w_hyper_angle
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/clk
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_config
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_mode
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_submode
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_bitshift_x
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_bitshift_y
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_bitshift_z
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_quadrant
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_range_n
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_x
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_y
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_z
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_valid
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/o_ready
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/o_x
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/o_y
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/o_z
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/i_ready
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/o_valid
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/s_postproc_state
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_x
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_y
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_z
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_config
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_mode
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_submode
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_valid_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_x_bitshift_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_y_bitshift_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_z_bitshift_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_valid_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_x_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_y_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_z_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_valid_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_range_reduce_range_n_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_range_reduce_valid_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_y_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_z_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_valid_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_quad_map_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/r_quad_map_valid_in
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_x_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_y_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_z_out
add wave -noupdate -group PostProc /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_valid_out
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/clk
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/i_re
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/i_raddr
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/o_data
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/o_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1452500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
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
WaveRestoreZoom {1312541 ps} {1767697 ps}
