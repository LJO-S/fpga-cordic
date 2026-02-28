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
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_ready
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_config
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_x
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_y
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_z
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_preproc_valid
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_x
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_y
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_z
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_bitshift_x
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_bitshift_y
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_bitshift_z
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_quadrant
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_range_n
add wave -noupdate -expand -group {Cordic Core} -expand -group PreProc -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_preproc_valid
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_x
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_y
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_z
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_valid
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_x
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_y
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_z
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/i_iterator_ready
add wave -noupdate -expand -group {Cordic Core} -expand -group Iterator -radix decimal /cordic_tb/cordic_inst/cordic_core_inst/o_iterator_valid
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
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/clk
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_double
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_common
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_inputs
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_x
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_y
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_z
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_valid
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal -childformat {{/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(26) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(25) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(24) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(23) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(22) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(21) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(20) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(19) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(18) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(17) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(16) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(15) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(14) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(13) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(12) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(11) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(10) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(9) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(8) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(7) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(6) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(5) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(4) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(3) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(2) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(1) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(0) -radix decimal}} -subitemconfig {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(26) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(25) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(24) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(23) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(22) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(21) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(20) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(19) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(18) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(17) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(16) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(15) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(14) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(13) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(12) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(11) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(10) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(9) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(8) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(7) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(6) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(5) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(4) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(3) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(2) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(1) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x(0) {-height 17 -radix decimal}} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_y
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_z
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x_shift
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_y_shift
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_z_shift
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_valid
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_common
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_double
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_double_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal -childformat {{/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(55) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(54) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(53) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(52) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(51) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(50) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(49) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(48) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(47) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(46) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(45) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(44) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(43) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(42) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(41) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(40) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(39) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(38) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(37) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(36) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(35) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(34) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(33) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(32) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(31) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(30) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(29) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(28) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(27) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(26) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(25) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(24) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(23) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(22) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(21) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(20) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(19) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(18) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(17) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(16) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(15) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(14) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(13) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(12) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(11) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(10) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(9) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(8) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(7) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(6) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(5) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(4) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(3) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(2) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(1) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(0) -radix decimal}} -subitemconfig {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(55) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(54) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(53) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(52) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(51) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(50) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(49) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(48) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(47) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(46) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(45) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(44) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(43) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(42) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(41) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(40) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(39) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(38) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(37) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(36) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(35) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(34) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(33) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(32) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(31) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(30) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(29) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(28) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(27) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(26) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(25) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(24) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(23) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(22) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(21) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(20) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(19) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(18) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(17) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(16) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(15) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(14) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(13) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(12) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(11) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(10) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(9) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(8) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(7) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(6) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(5) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(4) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(3) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(2) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(1) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int(0) {-height 17 -radix decimal}} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_abs_int
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_abs_int
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d2
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_d0
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/line__103/v_shift_x
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/line__103/v_shift_y
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/line__103/v_shift_z
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/line__103/v_iflog_x
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/line__103/v_iflog_y
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/line__103/v_iflog_z
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z_d1
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -color Yellow -radix decimal -childformat {{/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(30) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(29) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(28) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(27) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(26) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(25) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(24) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(23) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(22) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(21) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(20) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(19) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(18) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(17) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(16) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(15) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(14) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(13) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(12) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(11) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(10) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(9) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(8) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(7) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(6) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(5) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(4) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(3) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(2) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(1) -radix decimal} {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(0) -radix decimal}} -subitemconfig {/cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(30) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(29) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(28) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(27) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(26) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(25) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(24) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(23) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(22) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(21) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(20) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(19) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(18) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(17) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(16) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(15) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(14) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(13) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(12) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(11) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(10) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(9) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(8) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(7) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(6) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(5) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(4) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(3) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(2) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(1) {-color Yellow -height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift(0) {-color Yellow -height 17 -radix decimal}} /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_yval_shift
add wave -noupdate -group Preproc -expand -group {Preproc Bitshift} -color Yellow -radix decimal /cordic_tb/cordic_inst/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_zval_shift
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
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/clk
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_config
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_mode
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_submode
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_bitshift_x
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_bitshift_y
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_bitshift_z
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_quadrant
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_range_n
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_x
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_y
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_z
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_valid
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/o_ready
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/o_x
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/o_y
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/o_z
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/i_ready
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/o_valid
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/s_postproc_state
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_x
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_y
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_z
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_config
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_mode
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_submode
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_valid_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_x_bitshift_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_y_bitshift_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_z_bitshift_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_bitshift_valid_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_x_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_y_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_z_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_bitshift_valid_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_range_reduce_range_n_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_range_reduce_valid_in
add wave -noupdate -expand -group PostProc -radix decimal -childformat {{/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(30) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(29) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(28) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(27) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(26) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(25) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(24) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(23) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(22) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(21) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(20) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(19) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(18) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(17) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(16) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(15) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(14) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(13) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(12) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(11) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(10) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(9) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(8) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(7) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(6) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(5) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(4) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(3) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(2) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(1) -radix decimal} {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(0) -radix decimal}} -subitemconfig {/cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(30) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(29) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(28) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(27) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(26) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(25) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(24) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(23) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(22) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(21) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(20) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(19) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(18) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(17) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(16) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(15) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(14) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(13) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(12) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(11) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(10) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(9) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(8) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(7) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(6) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(5) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(4) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(3) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(2) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(1) {-height 17 -radix decimal} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out(0) {-height 17 -radix decimal}} /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_x_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_y_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_z_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_range_reduce_valid_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_quad_map_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/r_quad_map_valid_in
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_x_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_y_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_z_out
add wave -noupdate -expand -group PostProc -radix decimal /cordic_tb/cordic_inst/cordic_postprocess_inst/w_quad_map_valid_out
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/clk
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/i_re
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/i_raddr
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/o_data
add wave -noupdate -group Rom /cordic_tb/cordic_inst/microcode_rom_wrapper_inst/o_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2478282 ps} 0}
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
WaveRestoreZoom {2407266 ps} {2603997 ps}
