transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1 {C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1/one_bit_adder.sv}
vlog -sv -work work +incdir+C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1 {C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1/eight_bit_adder.sv}
vlog -sv -work work +incdir+C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1 {C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1/four_bit_signed_multiplier.sv}
vlog -sv -work work +incdir+C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1 {C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1/four_bit_signed_multiplier_tb.sv}

vlog -sv -work work +incdir+C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1 {C:/Users/Nilakna/Projects_local/SVADS/SVADS_A1/four_bit_signed_multiplier_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  four_bit_signed_multiplier_tb

add wave *
view structure
view signals
run -all
