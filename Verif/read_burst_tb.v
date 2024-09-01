`timescale 1ns/1ns

module testbench();

reg clk;
reg aresetn;
reg [31:0] address[3:0]; // Array to hold addresses for each master
reg [1:0] burst_length[3:0]; // Array to hold burst lengths for each master
reg read_enable[3:0]; // Array to control read enable for each master

// Instantiate the DUT
axicb_crossbar_top axicb_crossbar_top_inst (
    .aclk(clk),
    .aresetn(aresetn),
    //.srst(1'b0),

    // Master Agent 0 interface
        .slv0_aclk    (clk_div2),
        .slv0_aresetn (1'b1),
        .slv0_srst    ('h0),
        .slv0_awvalid ('h0),
        .slv0_awaddr  ('h0),
        .slv0_awprot  ('h0),
        .slv0_awid    ('h0),
        .slv0_awuser  ('h0),
        .slv0_wvalid  ('h0),
        .slv0_wdata   ('h0),
        .slv0_wstrb   ('h0),
        .slv0_wuser   ('h0),
        .slv0_bready  ('h0),
        .slv0_arvalid ('h0),
        .slv0_araddr  ('h0),
        .slv0_arprot  ('h0),
        .slv0_arid    ('h0),
        .slv0_aruser  ('h0),
        .slv0_rready  ('h0),
        .slv0_awready (),
        .slv0_wready  (),
        .slv0_bvalid  (),
        .slv0_bid     (), 
        .slv0_bresp   (),
        .slv0_buser   (),
        .slv0_arready (),
        .slv0_rvalid  (),
        .slv0_rid     (),
        .slv0_rresp   (),
        .slv0_rdata   (),
        .slv0_ruser   (),
        // Master Agent 1 interface
        .slv1_aclk    (clk_div2),
        .slv1_aresetn (1'b1),
        .slv1_srst    ('h0),
        .slv1_awvalid ('h0),
        .slv1_awaddr  ('h0),
        .slv1_awprot  ('h0),
        .slv1_awid    ('h0),
        .slv1_awuser  ('h0),
        .slv1_wvalid  ('h0),
        .slv1_wdata   ('h0),
        .slv1_wstrb   ('h0),
        .slv1_wuser   ('h0),
        .slv1_bready  ('h0),
        .slv1_arvalid ('h0),
        .slv1_araddr  ('h0),
        .slv1_arprot  ('h0),
        .slv1_arid    ('h0),
        .slv1_aruser  ('h0),
        .slv1_rready  ('h0),
        .slv1_awready (),
        .slv1_wready  (),
        .slv1_bvalid  (),
        .slv1_bid     (), 
        .slv1_bresp   (),
        .slv1_buser   (),
        .slv1_arready (),
        .slv1_rvalid  (),
        .slv1_rid     (),
        .slv1_rresp   (),
        .slv1_rdata   (),
        .slv1_ruser   (),
        // Master Agent 2 interface
        .slv2_aclk    (clk_div2),
        .slv2_aresetn (1'b1),
        .slv2_srst    ('h0),
        .slv2_awvalid ('h0),
        .slv2_awaddr  ('h0),
        .slv2_awprot  ('h0),
        .slv2_awid    ('h0),
        .slv2_awuser  ('h0),
        .slv2_wvalid  ('h0),
        .slv2_wdata   ('h0),
        .slv2_wstrb   ('h0),
        .slv2_wuser   ('h0),
        .slv2_bready  ('h0),
        .slv2_arvalid ('h0),
        .slv2_araddr  ('h0),
        .slv2_arprot  ('h0),
        .slv2_arid    ('h0),
        .slv2_aruser  ('h0),
        .slv2_rready  ('h0),
        .slv2_awready (),
        .slv2_wready  (),
        .slv2_bvalid  (),
        .slv2_bid     (), 
        .slv2_bresp   (),
        .slv2_buser   (),
        .slv2_arready (),
        .slv2_rvalid  (),
        .slv2_rid     (),
        .slv2_rresp   (),
        .slv2_rdata   (),
        .slv2_ruser   (),
        // Master Agent 3 interface
        .slv3_aclk    (clk_div2),
        .slv3_aresetn (1'b1),
        .slv3_srst    ('h0),
        .slv3_awvalid ('h0),
        .slv3_awaddr  ('h0),
        .slv3_awprot  ('h0),
        .slv3_awid    ('h0),
        .slv3_awuser  ('h0),
        .slv3_wvalid  ('h0),
        .slv3_wdata   ('h0),
        .slv3_wstrb   ('h0),
        .slv3_wuser   ('h0),
        .slv3_bready  ('h0),
        .slv3_arvalid ('h0),
        .slv3_araddr  ('h0),
        .slv3_arprot  ('h0),
        .slv3_arid    ('h0),
        .slv3_aruser  ('h0),
        .slv3_rready  ('h0),
        .slv3_awready (),
        .slv3_wready  (),
        .slv3_bvalid  (),
        .slv3_bid     (), 
        .slv3_bresp   (),
        .slv3_buser   (),
        .slv3_arready (),
        .slv3_rvalid  (),
        .slv3_rid     (),
        .slv3_rresp   (),
        .slv3_rdata   (),
        .slv3_ruser   (),

        // Slave Agent 0 interface
        .mst0_aclk    (clk_div4),
        .mst0_aresetn (1'b1),
        .mst0_srst    ('h0),
        .mst0_awready ('h0),
        .mst0_wready  ('h0),
        .mst0_bvalid  ('h0),
        .mst0_bid     ('h0),
        .mst0_bresp   ('h0),
        .mst0_buser   ('h0),
        .mst0_arready ('h0),
        .mst0_rvalid  ('h0),
        .mst0_rid     ('h0),
        .mst0_rresp   ('h0),
        .mst0_rdata   ('h0),
        .mst0_ruser   ('h0),
        .mst0_awvalid (),
        .mst0_awaddr  (),
        .mst0_awprot  (),
        .mst0_awid    (),
        .mst0_awuser  (),
        .mst0_wvalid  (),
        .mst0_wdata   (),
        .mst0_wstrb   (),
        .mst0_wuser   (),
        .mst0_bready  (),
        .mst0_arvalid (),
        .mst0_araddr  (),
        .mst0_arprot  (),
        .mst0_arid    (),
        .mst0_aruser  (),
        .mst0_rready  (),
        // Slave Agent 1 interface
        .mst1_aclk    (clk_div4),
        .mst1_aresetn (1'b1),
        .mst1_srst    ('h0),
        .mst1_awready ('h0),
        .mst1_wready  ('h0),
        .mst1_bvalid  ('h0),
        .mst1_bid     ('h0),
        .mst1_bresp   ('h0),
        .mst1_buser   ('h0),
        .mst1_arready ('h0),
        .mst1_rvalid  ('h0),
        .mst1_rid     ('h0),
        .mst1_rresp   ('h0),
        .mst1_rdata   ('h0),
        .mst1_ruser   ('h0),
        .mst1_awvalid (),
        .mst1_awaddr  (),
        .mst1_awprot  (),
        .mst1_awid    (),
        .mst1_awuser  (),
        .mst1_wvalid  (),
        .mst1_wdata   (),
        .mst1_wstrb   (),
        .mst1_wuser   (),
        .mst1_bready  (),
        .mst1_arvalid (),
        .mst1_araddr  (),
        .mst1_arprot  (),
        .mst1_arid    (),
        .mst1_aruser  (),
        .mst1_rready  (),
        // Slave Agent 2 interface
        .mst2_aclk    (clk_div4),
        .mst2_aresetn (1'b1),
        .mst2_srst    ('h0),
        .mst2_awready ('h0),
        .mst2_wready  ('h0),
        .mst2_bvalid  ('h0),
        .mst2_bid     ('h0),
        .mst2_bresp   ('h0),
        .mst2_buser   ('h0),
        .mst2_arready ('h0),
        .mst2_rvalid  ('h0),
        .mst2_rid     ('h0),
        .mst2_rresp   ('h0),
        .mst2_rdata   ('h0),
        .mst2_ruser   ('h0),
        .mst2_awvalid (),
        .mst2_awaddr  (),
        .mst2_awprot  (),
        .mst2_awid    (),
        .mst2_awuser  (),
        .mst2_wvalid  (),
        .mst2_wdata   (),
        .mst2_wstrb   (),
        .mst2_wuser   (),
        .mst2_bready  (),
        .mst2_arvalid (),
        .mst2_araddr  (),
        .mst2_arprot  (),
        .mst2_arid    (),
        .mst2_aruser  (),
        .mst2_rready  (),
        // Slave Agent 3 interface
        .mst3_aclk    (clk_div4),
        .mst3_aresetn (1'b1),
        .mst3_srst    ('h0),
        .mst3_awready ('h0),
        .mst3_wready  ('h0),
        .mst3_bvalid  ('h0),
        .mst3_bid     ('h0),
        .mst3_bresp   ('h0),
        .mst3_buser   ('h0),
        .mst3_arready ('h0),
        .mst3_rvalid  ('h0),
        .mst3_rid     ('h0),
        .mst3_rresp   ('h0),
        .mst3_rdata   ('h0),
        .mst3_ruser   ('h0),
        .mst3_awvalid (),
        .mst3_awaddr  (),
        .mst3_awprot  (),
        .mst3_awid    (),
        .mst3_awuser  (),
        .mst3_wvalid  (),
        .mst3_wdata   (),
        .mst3_wstrb   (),
        .mst3_wuser   (),
        .mst3_bready  (),
        .mst3_arvalid (),
        .mst3_araddr  (),
        .mst3_arprot  (),
        .mst3_arid    (),
        .mst3_aruser  (),
        .mst3_rready  ()
);

// Clock generation
always #5 clk = ~clk;

// Test stimulus
initial begin
    clk = 0;
    aresetn = 1;
    // Initialize address, burst length, and read enable for each master
    foreach (address[i]) address[i] = 32'h0000_0000;
    foreach (burst_length[i]) burst_length[i] = 3; // Set burst length to desired value
    foreach (read_enable[i]) read_enable[i] = 1; // Enable read

    // Reset and wait for a few cycles
    #10 aresetn = 0;
    #10 aresetn = 1;

    // Generate multiple cycles of read bursts for each master
    repeat(10) begin
        foreach (address[i]) address[i] = 32'h0000_0000; // Reset address for each master
        foreach (read_enable[i]) read_enable[i] = 1; // Enable read for each master
        #10;

        // Start of burst for each master
        repeat(4) begin
            foreach (i) begin
                address[i] = address[i] + 4; // Increment address for each master
                #10;
            end
        end

        // End of burst for each master
        foreach (read_enable[i]) read_enable[i] = 0; // Disable read for each master
        #10;
    end

    // Finish simulation
    $finish;
end

endmodule