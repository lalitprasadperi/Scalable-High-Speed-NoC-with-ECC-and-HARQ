# Define clocks with their frequencies for Clock Plan #1 for Base Logic Design
create_clock -name master_clk_0 -period 5 [get_ports {mst0_aclk}]  ;# 200 MHz
create_clock -name master_clk_1 -period 10 [get_ports {mst1_aclk}] ;# 100 MHz
create_clock -name master_clk_2 -period 20 [get_ports {mst2_aclk}] ;# 50 MHz 
create_clock -name master_clk_3 -period 40 [get_ports {mst3_aclk}] ;# 25 MHz

create_clock -name slave_clk_0 -period 5 [get_ports {slv0_aclk}]    ;# 200 MHz
create_clock -name slave_clk_1 -period 10 [get_ports {slv1_aclk}]   ;# 100 MHz
create_clock -name slave_clk_2 -period 20 [get_ports {slv2_aclk}]   ;# 50 MHz
create_clock -name slave_clk_3 -period 40 [get_ports {slv3_aclk}]   ;# 25 MHz

# Define/ Assume setup time constraints for slave write ports (input)
for {set i 0} {$i < 32} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_wdata[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_wdata[$i]] # Resolution is in NS. So all PS values should be adjusted by 1000
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_wdata[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_wdata[$i]]
}

# Define/ Assume hold time constraints for slave read ports (output)
for {set i 0} {$i < 32} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_rdata[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_rdata[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_rdata[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_rdata[$i]]
}

# Define/Assume setup time constraints for master read ports (input)
for {set i 0} {$i < 32} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_rdata[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_rdata[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_rdata[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_rdata[$i]]
}

# Define/Assume hold time constraints for master write ports (output)
for {set i 0} {$i < 32} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_wdata[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_wdata[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_wdata[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_wdata[$i]]
}
