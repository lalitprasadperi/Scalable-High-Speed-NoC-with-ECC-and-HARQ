#//-----------------------------------------------------------------------------------
#// # Author: Alberta Ogbo Dadeboe (albertaod@vt.edu)
#// # Group5 Project: Advance VLSI Design, ECE5545 Spring2024 
#//-----------------------------------------------------------------------------------
#// # distributed under the mit license
#// # https://opensource.org/licenses/mit-license.php
#//-----------------------------------------------------------------------------------

#//-----------------------------------------------------------------------------------
#// # Defining timing constraints for Clock Plan #3 for basic logic design : 
#// # Clock Frequencies in MHz (Global/M/S 0 - M/S 1 - M/S#2 - M/S 3): 600-300-150-60
#// # Setup time for input ports - 30ps
#// # Hold time for output ports - 10ps
#//-----------------------------------------------------------------------------------

create_clock -name global_clk -period 1.67 [get_ports {aclk}]  ;# Global 600 MHz

create_clock -name master_clk_0 -period 1.67 [get_ports {mst0_aclk}]  ;# 600 MHz
create_clock -name master_clk_1 -period 3.33 [get_ports {mst1_aclk}] ;# 300 MHz
create_clock -name master_clk_2 -period 6.67 [get_ports {mst2_aclk}] ;# 150 MHz 
create_clock -name master_clk_3 -period 16.67 [get_ports {mst3_aclk}] ;# 60 MHz

create_clock -name slave_clk_0 -period 1.67 [get_ports {slv0_aclk}]    ;# 600 MHz
create_clock -name slave_clk_1 -period 3.33 [get_ports {slv1_aclk}]   ;# 300 MHz
create_clock -name slave_clk_2 -period 6.67 [get_ports {slv2_aclk}]   ;# 150 MHz
create_clock -name slave_clk_3 -period 16.67 [get_ports {slv3_aclk}]   ;# 60 MHz

################################################################################# DATA PORTS TIMING CONSTRAINTS ###################################################################################################

######################################################### From Master - To Slave ##########################################################################################

# Define/Assume hold time constraints for master write data ports (output)
for {set i 0} {$i < 32} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_wdata[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_wdata[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_wdata[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_wdata[$i]]
}
# Define/ Assume setup time constraints for slave write data ports (input)
for {set i 0} {$i < 32} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_wdata[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_wdata[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_wdata[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_wdata[$i]]
}


######################################################### From Slave - To Master ##########################################################################################

# Define/ Assume hold time constraints for slave read data ports (output)
for {set i 0} {$i < 32} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_rdata[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_rdata[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_rdata[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_rdata[$i]]
}
# Define/Assume setup time constraints for master read data ports (input)
for {set i 0} {$i < 32} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_rdata[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_rdata[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_rdata[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_rdata[$i]]
}




#################################################################################### VALID PORTS TIMING CONSTRAINTS ###############################################################################################

######################################################### From Master - To Slave ##########################################################################################

# Define/ Assume hold time constraints for master address write valid (aw_valid) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_awvalid]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_awvalid]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_awvalid]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_awvalid]
}
# Define/ Assume setup time constraints for slave address write valid (aw_valid) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_awvalid]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_awvalid]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_awvalid]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_awvalid]
}


# Define/ Assume hold time constraints for master data write valid (w_valid) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_wvalid]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_wvalid]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_wvalid]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_wvalid]
}
# Define/ Assume setup time constraints for slave data write valid (w_valid) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_wvalid]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_wvalid]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_wvalid]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_wvalid]
}


# Define/ Assume hold time constraints for master address read valid (ar_valid) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_arvalid]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_arvalid]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_arvalid]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_arvalid]
}
# Define/ Assume setup time constraints for slave address read valid (ar_valid) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_arvalid]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_arvalid]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_arvalid]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_arvalid]
}


######################################################### From Slave - To Master ##########################################################################################

# Define/ Assume hold time constraints for slave read data valid (r_valid) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_rvalid]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_rvalid]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_rvalid]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_rvalid]
}
# Define/ Assume setup time constraints for master read data valid (r_valid) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_rvalid]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_rvalid]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_rvalid]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_rvalid]
}


# Define/ Assume setup time constraints for master burst response valid (b_valid) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_bvalid]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_bvalid]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_bvalid]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_bvalid]
}
# Define/ Assume hold time constraints for slave burst response valid (b_valid) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_bvalid]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_bvalid]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_bvalid]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_bvalid]
}




#################################################################################### ADDRESS PORTS TIMING CONSTRAINTS #############################################################################################

######################################################### From Master - To Slave ##########################################################################################

# Define/ Assume hold time constraints for master address write addr (awaddr) ports (output)
for {set i 0} {$i < 16} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_awaddr[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_awaddr[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_awaddr[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_awaddr[$i]]
}
# Define/ Assume setup time constraints for slave address write address (awaddr) ports (input)
for {set i 0} {$i < 16} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_awaddr[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_awaddr[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_awaddr[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_awaddr[$i]]
}


# Define/ Assume hold time constraints for master address read address (araddr) ports (output)
for {set i 0} {$i < 16} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_araddr[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_araddr[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_araddr[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_araddr[$i]]
}
# Define/ Assume setup time constraints for slave address read address (araddr) ports (input)
for {set i 0} {$i < 16} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_araddr[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_araddr[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_araddr[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_araddr[$i]]
}




#################################################################################### WRITE AND READ PROTECTION PORTS TIMING CONSTRAINTS ###########################################################################

######################################################### From Master - To Slave #########################################################################################

# Define/ Assume hold time constraints for master address write protection (awprot) ports (output)
for {set i 0} {$i < 3} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_awprot[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_awprot[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_awprot[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_awprot[$i]]
}
# Define/ Assume setup time constraints for slave address write protection (awprot) ports (input)
for {set i 0} {$i < 3} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_awprot[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_awprot[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_awprot[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_awprot[$i]]
}


# Define/ Assume hold time constraints for master address read protection (arprot) ports (output)
for {set i 0} {$i < 3} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_arprot[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_arprot[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_arprot[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_arprot[$i]]
}
# Define/ Assume setup time constraints for slave address read protection (arprot) ports (input)
for {set i 0} {$i < 3} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_arprot[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_arprot[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_arprot[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_arprot[$i]]
}




#################################################################################### WRITE STROBE PORTS TIMING CONSTRAINTS ###########################################################################

######################################################### From Master - To Slave #########################################################################################

# Define/ Assume hold time constraints for master write strobe (wstrb) ports (output)
for {set i 0} {$i < 4} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_wstrb[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_wstrb[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_wstrb[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_wstrb[$i]]
}
# Define/ Assume setup time constraints for slave write strobe (wstrb) ports (input)
for {set i 0} {$i < 4} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_wstrb[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_wstrb[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_wstrb[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_wstrb[$i]]
}






#################################################################################### RESPONSE PORTS TIMING CONSTRAINTS ######################################################################

######################################################### From Slave - To Master ##########################################################################################

# Define/ Assume hold time constraints for slave burst response (bresp) ports (output)
for {set i 0} {$i < 2} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_bresp[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_bresp[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_bresp[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_bresp[$i]]
}
# Define/ Assume setup time constraints for master burst response (bresp) ports (input)
for {set i 0} {$i < 2} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_bresp[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_bresp[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_bresp[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_bresp[$i]]
}


# Define/ Assume hold time constraints for slave read response (rresp) ports (output)
for {set i 0} {$i < 2} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_rresp[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_rresp[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_rresp[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_rresp[$i]]
}
# Define/ Assume setup time constraints for master read response (rresp) ports (input)
for {set i 0} {$i < 2} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_rresp[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_rresp[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_rresp[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_rresp[$i]]
}





#################################################################################### ID PORTS TIMING CONSTRAINTS ###########################################################################

######################################################### From Master - To Slave #########################################################################################

# Define/ Assume hold time constraints for master address read ID (arid) ports (output)
for {set i 0} {$i < 8} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_arid[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_arid[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_arid[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_arid[$i]]
}
# Define/ Assume setup time constraints for slave address read ID (arid) ports (input)
for {set i 0} {$i < 8} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_arid[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_arid[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_arid[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_arid[$i]]
}


# Define/ Assume hold time constraints for master address write ID (awid) ports (output)
for {set i 0} {$i < 8} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_awid[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_awid[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_awid[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_awid[$i]]
}
# Define/ Assume setup time constraints for slave address write ID (awid) ports (input)
for {set i 0} {$i < 8} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_awid[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_awid[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_awid[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_awid[$i]]
}


######################################################### From Slave - To Master ##########################################################################################

# Define/ Assume hold time constraints for slave burst ID (bid) ports (output)
for {set i 0} {$i < 8} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_bid[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_bid[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_bid[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_bid[$i]]
}
# Define/ Assume setup time constraints for master burst ID response (bid) ports (input)
for {set i 0} {$i < 8} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_bid[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_bid[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_bid[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_bid[$i]]
}



# Define/ Assume hold time constraints for slave read ID (rid) ports (output)
for {set i 0} {$i < 8} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_rid[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_rid[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_rid[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_rid[$i]]
}
# Define/ Assume setup time constraints for master read ID response (rid) ports (input)
for {set i 0} {$i < 8} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_rid[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_rid[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_rid[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_rid[$i]]
}




#################################################################################### READY PORTS TIMING CONSTRAINTS ###########################################################################

######################################################### From Master - To Slave #########################################################################################

# Define/ Assume hold time constraints for master burst ready (bready) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_bready]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_bready]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_bready]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_bready]
}
# Define/ Assume setup time constraints for slave burst read (bready) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_bready]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_bready]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_bready]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_bready]
}


# Define/ Assume hold time constraints for master read ready (rready) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_rready]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_rready]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_rready]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_rready]
}
# Define/ Assume setup time constraints for slave read read (rready) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_rready]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_rready]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_rready]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_rready]
}




######################################################### From Slave - To Master ##########################################################################################

# Define/ Assume hold time constraints for slave address write ready (awready) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_awready]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_awready]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_awready]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_awready]
}
# Define/ Assume setup time constraints for master address write ready (awready) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_awready]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_awready]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_awready]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_awready]
}


# Define/ Assume hold time constraints for slave write ready (wready) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_wready]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_wready]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_wready]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_wready]
}
# Define/ Assume setup time constraints for master write ready (wready) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_wready]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_wready]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_wready]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_wready]
}


# Define/ Assume hold time constraints for slave address read ready (arready) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_arready]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_arready]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_arready]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_arready]
}
# Define/ Assume setup time constraints for master address read ready (arready) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_arready]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_arready]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_arready]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_arready]
}



#################################################################################### USER PORTS TIMING CONSTRAINTS ###########################################################################

######################################################### From Master - To Slave #########################################################################################

# Define/ Assume hold time constraints for master address write user (awuser) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_awuser[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_awuser[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_awuser[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_awuser[$i]]
}
# Define/ Assume setup time constraints for slave address write user (awuser) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_awuser[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_awuser[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_awuser[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_awuser[$i]]
}


# Define/ Assume hold time constraints for master write user (wuser) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_wuser[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_wuser[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_wuser[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_wuser[$i]]
}
# Define/ Assume setup time constraints for slave write user (wuser) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_wuser[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_wuser[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_wuser[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_wuser[$i]]
}


# Define/ Assume hold time constraints for master address read user (aruser) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock master_clk_0 -min 0.010 [get_ports mst0_aruser[$i]]
    set_output_delay -clock master_clk_1 -min 0.010 [get_ports mst1_aruser[$i]]
    set_output_delay -clock master_clk_2 -min 0.010 [get_ports mst2_aruser[$i]]
    set_output_delay -clock master_clk_3 -min 0.010 [get_ports mst3_aruser[$i]]
}
# Define/ Assume setup time constraints for slave address read user (aruser) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock slave_clk_0 -min 0.030 [get_ports slv0_aruser[$i]]
    set_input_delay -clock slave_clk_1 -min 0.030 [get_ports slv1_aruser[$i]]
    set_input_delay -clock slave_clk_2 -min 0.030 [get_ports slv2_aruser[$i]]
    set_input_delay -clock slave_clk_3 -min 0.030 [get_ports slv3_aruser[$i]]
}




######################################################### From Slave - To Master ##########################################################################################

# Define/ Assume hold time constraints for slave burst user (buser) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_buser[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_buser[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_buser[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_buser[$i]]
}
# Define/ Assume setup time constraints for master burst user (buser) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_buser[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_buser[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_buser[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_buser[$i]]
}


# Define/ Assume hold time constraints for slave read user (ruser) ports (output)
for {set i 0} {$i < 1} {incr i} {
    set_output_delay -clock slave_clk_0 -min 0.010 [get_ports slv0_ruser[$i]]
    set_output_delay -clock slave_clk_1 -min 0.010 [get_ports slv1_ruser[$i]]
    set_output_delay -clock slave_clk_2 -min 0.010 [get_ports slv2_ruser[$i]]
    set_output_delay -clock slave_clk_3 -min 0.010 [get_ports slv3_ruser[$i]]
}
# Define/ Assume setup time constraints for master read user (ruser) ports (input)
for {set i 0} {$i < 1} {incr i} {
    set_input_delay -clock master_clk_0 -min 0.030 [get_ports mst0_ruser[$i]]
    set_input_delay -clock master_clk_1 -min 0.030 [get_ports mst1_ruser[$i]]
    set_input_delay -clock master_clk_2 -min 0.030 [get_ports mst2_ruser[$i]]
    set_input_delay -clock master_clk_3 -min 0.030 [get_ports mst3_ruser[$i]]
}
