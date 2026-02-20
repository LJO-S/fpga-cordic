onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group TB /cordic_preprocess_tb/clk
add wave -noupdate -group TB -childformat {{/cordic_preprocess_tb/i_config.norm_input -radix binary}} -expand -subitemconfig {/cordic_preprocess_tb/i_config.norm_input {-height 19 -radix binary}} /cordic_preprocess_tb/i_config
add wave -noupdate -group TB /cordic_preprocess_tb/i_x
add wave -noupdate -group TB /cordic_preprocess_tb/i_y
add wave -noupdate -group TB /cordic_preprocess_tb/i_z
add wave -noupdate -group TB /cordic_preprocess_tb/i_valid
add wave -noupdate -group TB /cordic_preprocess_tb/o_ready
add wave -noupdate -group TB /cordic_preprocess_tb/o_x
add wave -noupdate -group TB /cordic_preprocess_tb/o_y
add wave -noupdate -group TB /cordic_preprocess_tb/o_z
add wave -noupdate -group TB /cordic_preprocess_tb/o_bitshift_x
add wave -noupdate -group TB /cordic_preprocess_tb/o_bitshift_y
add wave -noupdate -group TB /cordic_preprocess_tb/o_bitshift_z
add wave -noupdate -group TB /cordic_preprocess_tb/o_quadrant
add wave -noupdate -group TB /cordic_preprocess_tb/o_range_n
add wave -noupdate -group TB /cordic_preprocess_tb/i_ready
add wave -noupdate -group TB /cordic_preprocess_tb/o_valid
add wave -noupdate -group TB /cordic_preprocess_tb/tb_input_data_x_float
add wave -noupdate -group TB /cordic_preprocess_tb/tb_input_data_y_float
add wave -noupdate -group TB /cordic_preprocess_tb/tb_input_data_z_float
add wave -noupdate -group TB /cordic_preprocess_tb/tb_output_data_x_float
add wave -noupdate -group TB /cordic_preprocess_tb/tb_output_data_y_float
add wave -noupdate -group TB /cordic_preprocess_tb/tb_output_data_r_float
add wave -noupdate -group TB /cordic_preprocess_tb/tb_output_data_n_int
add wave -noupdate -group TB /cordic_preprocess_tb/tb_auto_set
add wave -noupdate -group TB /cordic_preprocess_tb/tb_auto_done
add wave -noupdate -group TB /cordic_preprocess_tb/auto_data_x
add wave -noupdate -group TB /cordic_preprocess_tb/auto_data_y
add wave -noupdate -group TB /cordic_preprocess_tb/auto_data_z
add wave -noupdate -group TB /cordic_preprocess_tb/auto_data_tvalid
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/clk
add wave -noupdate -expand -group Pre-Process -radix decimal -childformat {{/cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_en -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_input -radix binary} {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_common -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_shift_double -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.reduction_en -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.reduction_reconstruct -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.quadrant_en -radix decimal}} -expand -subitemconfig {/cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_en {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_input {-height 19 -radix binary} /cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_common {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/i_config.norm_shift_double {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/i_config.reduction_en {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/i_config.reduction_reconstruct {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/i_config.quadrant_en {-height 19 -radix decimal}} /cordic_preprocess_tb/cordic_preprocess_inst/i_config
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/i_x
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/i_y
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/i_z
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/i_valid
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_ready
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_x
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_y
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_z
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_bitshift_x
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_bitshift_y
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_bitshift_z
add wave -noupdate -expand -group Pre-Process -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/o_quadrant
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_range_n
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/i_ready
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/o_valid
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/s_preproc_state
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_x
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_y
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_z
add wave -noupdate -expand -group Pre-Process -radix decimal -childformat {{/cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_en -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_input -radix binary} {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_common -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_shift_double -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.reduction_en -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.reduction_reconstruct -radix decimal} {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.quadrant_en -radix decimal}} -expand -subitemconfig {/cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_en {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_input {-height 19 -radix binary} /cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_common {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/r_config.norm_shift_double {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/r_config.reduction_en {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/r_config.reduction_reconstruct {-height 19 -radix decimal} /cordic_preprocess_tb/cordic_preprocess_inst/r_config.quadrant_en {-height 19 -radix decimal}} /cordic_preprocess_tb/cordic_preprocess_inst/r_config
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_valid_out
add wave -noupdate -expand -group Pre-Process -radix binary /cordic_preprocess_tb/cordic_preprocess_inst/w_norm_input
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_norm_common
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_norm_double
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_bitshift_valid_in
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_valid_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_x_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_y_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_z_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_x_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_y_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_bitshift_z_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_bitshift_x_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_bitshift_y_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_bitshift_z_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_reduce_valid_in
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_reduce_valid_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_reduce_x_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_reduce_y_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_reduce_z_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_reduce_n_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_reduce_n_shift_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_quadrant_valid_in
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_quadrant_valid_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_quadrant_x_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_quadrant_y_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_quadrant_z_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/w_quadrant_out
add wave -noupdate -expand -group Pre-Process -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/r_quadrant_out
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/clk
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_double
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_common
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_shift_inputs
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_x
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_y
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_z
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/i_valid
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_y
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_z
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_x_shift
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_y_shift
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_z_shift
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/o_valid
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_common
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_double
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_double_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_abs_int
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_abs_int
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_abs_int
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_valid_d2
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_x_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_y_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_shift_z_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_d0
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_x_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_y_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_z_d1
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_xval_shift
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_yval_shift
add wave -noupdate -group {Bitshift Norm} -radix decimal /cordic_preprocess_tb/cordic_preprocess_inst/preproc_bitshift_norm_inst/r_zval_shift
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/clk
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/i_x
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/i_y
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/i_z
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/i_valid
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/o_x
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/o_y
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/o_r
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/o_n
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/o_valid
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_x
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_y
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_z
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_x_d0
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_y_d0
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_z_d0
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_x_d1
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_y_d1
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_z_d1
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_x_d2
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_y_d2
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid_d0
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid_d1
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_valid_d2
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n_mult
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n_d0
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_n_d1
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_subtract
add wave -noupdate -group {Range Reduce} /cordic_preprocess_tb/cordic_preprocess_inst/preproc_range_reduce_inst/r_range_r
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/clk
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/i_x
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/i_y
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/i_z
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/i_valid
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/o_x
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/o_y
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/o_z
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/o_quadrant
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/o_valid
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/r_x
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/r_y
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/r_z
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/r_quadrant
add wave -noupdate -group {Quadrant Map} -radix unsigned /cordic_preprocess_tb/cordic_preprocess_inst/preproc_quadrant_map_inst/r_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {154239 ps} 0}
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
WaveRestoreZoom {0 ps} {564375 ps}
