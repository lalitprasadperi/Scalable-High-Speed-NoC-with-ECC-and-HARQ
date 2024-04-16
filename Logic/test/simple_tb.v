//--------------------------------------------------------------------
// Author: Lalit Prasad Peri (lalitprasad@vt.edu)
// Group5 Project: Advance VLSI Design, ECE5545 Spring2024 
//--------------------------------------------------------------------
// Simple Verilog TB
//--------------------------------------------------------------------

module testbench(
);

initial 
begin
  $dumpfile("NOC_simple_tb.vcd");
  $dumpvars(0,testbench);
  $display("--------------Start of Simulation-------------\n");
  #1000;
  $display(" NOC: Compile /Elaboration: PASS\n");
  $display("--------------End of Simulation-------------\n");
  $finish;
end

    //--#(
    //--    //--------------------------------------------------------------------
    //--    // Global configuration
    //--    //--------------------------------------------------------------------
    //--    // Address width in bits
    //--    parameter AXI_ADDR_W = 16,
    //--    // ID width in bits
    //--    parameter AXI_ID_W = 8,
    //--    // Data width in bits
    //--    parameter AXI_DATA_W = 40,
    //--    // Number of master(s)
    //--    parameter MST_NB = 4,
    //--    // Number of slave(s)
    //--    parameter SLV_NB = 4,
    //--    // Switching logic pipelining (0 deactivate, 1 enable)
    //--    parameter MST_PIPELINE = 0,
    //--    parameter SLV_PIPELINE = 0,
    //--    // STRB support:
    //--    //   - 0: contiguous wstrb (store only 1st/last dataphase)
    //--    //   - 1: full wstrb transport
    //--    parameter STRB_MODE = 1,
    //--    // AXI Signals Supported:
    //--    //   - 0: AXI4-lite
    //--    //   - 1: AXI
    //--    parameter AXI_SIGNALING = 0,
    //--    // USER fields transport enabling (0 deactivate, 1 activate)
    //--    parameter USER_SUPPORT = 0,
    //--    // USER fields width in bits
    //--    parameter AXI_AUSER_W = 1,
    //--    parameter AXI_WUSER_W = 1,
    //--    parameter AXI_BUSER_W = 1,
    //--    parameter AXI_RUSER_W = 1,
    //--    // Timeout configuration in clock cycles, applied to all channels
    //--    parameter TIMEOUT_VALUE = 10000,
    //--    // Activate the timer to avoid deadlock
    //--    parameter TIMEOUT_ENABLE = 1,
    //--    //--------------------------------------------------------------------
    //--    // Master agent configurations:
    //--    //   - MSTx_CDC: implement input CDC stage, 0 or 1
    //--    //   - MSTx_OSTDREQ_NUM: maximum number of requests a master can store internally
    //--    //   - MSTx_OSTDREQ_SIZE: size of an outstanding request in dataphase
    //--    //   - MSTx_PRIORITY: priority applied to this master in the arbitrers,
    //--    //                    from 0 to 3 included
    //--    //   - MSTx_ROUTES: routing from the master to the slaves allowed in
    //--    //                  the switching logic. Bit 0 for slave 0, bit 1 for
    //--    //                  slave 1, ...
    //--    //   - MSTx_ID_MASK : A mask applied in slave completion channel to
    //--    //                    determine which master to route back the
    //--    //                    BRESP/RRESP completions.
    //--    //   - MSTx_RW: Slect if the interface is 
    //--    //         - Read/Write (=0)
    //--    //         - Read-only (=1) 
    //--    //         - Write-only (=2)
    //--    // The size of a master's internal buffer is equal to:
    //--    // SIZE = AXI_DATA_W * MSTx_OSTDREQ_NUM * MSTx_OSTDREQ_SIZE (in bits)
    //--    //--------------------------------------------------------------------
    //--    //--------------------------------------------------------------------
    //--    // Master 0 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter MST0_CDC = 0,
    //--    parameter MST0_OSTDREQ_NUM = 4,
    //--    parameter MST0_OSTDREQ_SIZE = 1,
    //--    parameter MST0_PRIORITY = 0,
    //--    parameter [SLV_NB-1:0] MST0_ROUTES = 4'b1_1_1_1,
    //--    parameter [AXI_ID_W-1:0] MST0_ID_MASK = 'h10,
    //--    parameter MST0_RW = 0,
    //--    //--------------------------------------------------------------------
    //--    // Master 1 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter MST1_CDC = 0,
    //--    parameter MST1_OSTDREQ_NUM = 4,
    //--    parameter MST1_OSTDREQ_SIZE = 1,
    //--    parameter MST1_PRIORITY = 0,
    //--    parameter [SLV_NB-1:0] MST1_ROUTES = 4'b1_1_1_1,
    //--    parameter [AXI_ID_W-1:0] MST1_ID_MASK = 'h20,
    //--    parameter MST1_RW = 0,
    //--    //--------------------------------------------------------------------
    //--    // Master 2 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter MST2_CDC = 0,
    //--    parameter MST2_OSTDREQ_NUM = 4,
    //--    parameter MST2_OSTDREQ_SIZE = 1,
    //--    parameter MST2_PRIORITY = 0,
    //--    parameter [SLV_NB-1:0] MST2_ROUTES = 4'b1_1_1_1,
    //--    parameter [AXI_ID_W-1:0] MST2_ID_MASK = 'h30,
    //--    parameter MST2_RW = 0,
    //--    //--------------------------------------------------------------------
    //--    // Master 3 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter MST3_CDC = 0,
    //--    parameter MST3_OSTDREQ_NUM = 4,
    //--    parameter MST3_OSTDREQ_SIZE = 1,
    //--    parameter MST3_PRIORITY = 0,
    //--    parameter [SLV_NB-1:0] MST3_ROUTES = 4'b1_1_1_1,
    //--    parameter [AXI_ID_W-1:0] MST3_ID_MASK = 'h40,
    //--    parameter MST3_RW = 0,
    //--    //--------------------------------------------------------------------
    //--    // Slave agent configurations:
    //--    //--------------------------------------------------------------------
    //--    //   - SLVx_CDC: implement input CDC stage, 0 or 1
    //--    //   - SLVx_OSTDREQ_NUM: maximum number of requests slave can store internally
    //--    //   - SLVx_OSTDREQ_SIZE: size of an outstanding request in dataphase
    //--    //   - SLVx_START_ADDR: Start address allocated to the slave, in byte
    //--    //   - SLVx_END_ADDR: End address allocated to the slave, in byte
    //--    //   - SLVx_KEEP_BASE_ADDR: Keep the absolute address of the slave in the memory map. Default to 0.
    //--    // The size of a slave's internal buffer is equal to:
    //--    //   AXI_DATA_W * SLVx_OSTDREQ_NUM * SLVx_OSTDREQ_SIZE (in bits)
    //--    // A request is routed to a slave if:
    //--    //   START_ADDR <= ADDR <= END_ADDR
    //--    //--------------------------------------------------------------------
    //--    //--------------------------------------------------------------------
    //--    // Slave 0 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter SLV0_CDC = 0,
    //--    parameter SLV0_START_ADDR = 0,
    //--    parameter SLV0_END_ADDR = 4095,
    //--    parameter SLV0_OSTDREQ_NUM = 4,
    //--    parameter SLV0_OSTDREQ_SIZE = 1,
    //--    parameter SLV0_KEEP_BASE_ADDR = 0,
    //--    //--------------------------------------------------------------------
    //--    // Slave 1 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter SLV1_CDC = 0,
    //--    parameter SLV1_START_ADDR = 4096,
    //--    parameter SLV1_END_ADDR = 8191,
    //--    parameter SLV1_OSTDREQ_NUM = 4,
    //--    parameter SLV1_OSTDREQ_SIZE = 1,
    //--    parameter SLV1_KEEP_BASE_ADDR = 0,
    //--    //--------------------------------------------------------------------
    //--    // Slave 2 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter SLV2_CDC = 0,
    //--    parameter SLV2_START_ADDR = 8192,
    //--    parameter SLV2_END_ADDR = 12287,
    //--    parameter SLV2_OSTDREQ_NUM = 4,
    //--    parameter SLV2_OSTDREQ_SIZE = 1,
    //--    parameter SLV2_KEEP_BASE_ADDR = 0,
    //--    //--------------------------------------------------------------------
    //--    // Slave 3 configuration
    //--    //--------------------------------------------------------------------
    //--    parameter SLV3_CDC = 0,
    //--    parameter SLV3_START_ADDR = 12288,
    //--    parameter SLV3_END_ADDR = 16383,
    //--    parameter SLV3_OSTDREQ_NUM = 4,
    //--    parameter SLV3_OSTDREQ_SIZE = 1,
    //--    parameter SLV3_KEEP_BASE_ADDR = 0
    //--)
    axicb_crossbar_top axicb_crossbar_top (
        //--------------------------------------------------------------------
        // Interconnect global interface
        //--------------------------------------------------------------------
        .aclk    (1'b1),
        .aresetn (1'b0),
        .srst    (1'b0),
        //--------------------------------------------------------------------
        // Master Agent 0 interface
        //--------------------------------------------------------------------
        .slv0_aclk    ('h0),
        .slv0_aresetn ('h1),
        .slv0_srst    ('h0),
        .slv0_awvalid ('h0),
        .slv0_awaddr  ('hA5A5),
        .slv0_awlen   ('h0),
        .slv0_awsize  ('h0),
        .slv0_awburst ('h0),
        .slv0_awlock  ('h0),
        .slv0_awcache ('h0),
        .slv0_awprot  ('h0),
        .slv0_awqos   ('h0),
        .slv0_awregion('h0),
        .slv0_awid    ('h0),
        .slv0_awuser  ('h0),
        .slv0_wvalid  ('h0),
        .slv0_wlast   ('h0),
        .slv0_wdata   ('h0),
        .slv0_wstrb   ('h0),
        .slv0_wuser   ('h0),
        .slv0_bready  ('h0),
        .slv0_arvalid ('h0),
        .slv0_araddr  ('hC3C3),
        .slv0_arlen   ('h0),
        .slv0_arsize  ('h0),
        .slv0_arburst ('h0),
        .slv0_arlock  ('h0),
        .slv0_arcache ('h0),
        .slv0_arprot  ('h0),
        .slv0_arqos   ('h0),
        .slv0_arregion('h0),
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
        .slv0_rlast   (),
        .slv0_ruser   (),
        //--------------------------------------------------------------------
        // Master Agent 1 interface
        //--------------------------------------------------------------------
        .slv1_aclk    ('h0),
        .slv1_aresetn ('h1),
        .slv1_srst    ('h0),
        .slv1_awvalid ('h0),
        .slv1_awaddr  ('hA5A5),
        .slv1_awlen   ('h0),
        .slv1_awsize  ('h0),
        .slv1_awburst ('h0),
        .slv1_awlock  ('h0),
        .slv1_awcache ('h0),
        .slv1_awprot  ('h0),
        .slv1_awqos   ('h0),
        .slv1_awregion('h0),
        .slv1_awid    ('h0),
        .slv1_awuser  ('h0),
        .slv1_wvalid  ('h0),
        .slv1_wlast   ('h0),
        .slv1_wdata   ('h0),
        .slv1_wstrb   ('h0),
        .slv1_wuser   ('h0),
        .slv1_bready  ('h0),
        .slv1_arvalid ('h0),
        .slv1_araddr  ('hC3C3),
        .slv1_arlen   ('h0),
        .slv1_arsize  ('h0),
        .slv1_arburst ('h0),
        .slv1_arlock  ('h0),
        .slv1_arcache ('h0),
        .slv1_arprot  ('h0),
        .slv1_arqos   ('h0),
        .slv1_arregion('h0),
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
        .slv1_rlast   (),
        .slv1_ruser   (),
        //--------------------------------------------------------------------
        // Master Agent 2 interface
        //--------------------------------------------------------------------
        .slv2_aclk    ('h0),
        .slv2_aresetn ('h1),
        .slv2_srst    ('h0),
        .slv2_awvalid ('h0),
        .slv2_awaddr  ('hA5A5),
        .slv2_awlen   ('h0),
        .slv2_awsize  ('h0),
        .slv2_awburst ('h0),
        .slv2_awlock  ('h0),
        .slv2_awcache ('h0),
        .slv2_awprot  ('h0),
        .slv2_awqos   ('h0),
        .slv2_awregion('h0),
        .slv2_awid    ('h0),
        .slv2_awuser  ('h0),
        .slv2_wvalid  ('h0),
        .slv2_wlast   ('h0),
        .slv2_wdata   ('h0),
        .slv2_wstrb   ('h0),
        .slv2_wuser   ('h0),
        .slv2_bready  ('h0),
        .slv2_arvalid ('h0),
        .slv2_araddr  ('hC3C3),
        .slv2_arlen   ('h0),
        .slv2_arsize  ('h0),
        .slv2_arburst ('h0),
        .slv2_arlock  ('h0),
        .slv2_arcache ('h0),
        .slv2_arprot  ('h0),
        .slv2_arqos   ('h0),
        .slv2_arregion('h0),
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
        .slv2_rlast   (),
        .slv2_ruser   (),
        //--------------------------------------------------------------------
        // Master Agent 3 interface
        //--------------------------------------------------------------------
        .slv3_aclk    ('h0),
        .slv3_aresetn ('h1),
        .slv3_srst    ('h0),
        .slv3_awvalid ('h0),
        .slv3_awaddr  ('hA5A5),
        .slv3_awlen   ('h0),
        .slv3_awsize  ('h0),
        .slv3_awburst ('h0),
        .slv3_awlock  ('h0),
        .slv3_awcache ('h0),
        .slv3_awprot  ('h0),
        .slv3_awqos   ('h0),
        .slv3_awregion('h0),
        .slv3_awid    ('h0),
        .slv3_awuser  ('h0),
        .slv3_wvalid  ('h0),
        .slv3_wlast   ('h0),
        .slv3_wdata   ('h0),
        .slv3_wstrb   ('h0),
        .slv3_wuser   ('h0),
        .slv3_bready  ('h0),
        .slv3_arvalid ('h0),
        .slv3_araddr  ('hC3C3),
        .slv3_arlen   ('h0),
        .slv3_arsize  ('h0),
        .slv3_arburst ('h0),
        .slv3_arlock  ('h0),
        .slv3_arcache ('h0),
        .slv3_arprot  ('h0),
        .slv3_arqos   ('h0),
        .slv3_arregion('h0),
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
        .slv3_rlast   (),
        .slv3_ruser   (),

        //--------------------------------------------------------------------
        // Slave Agent 0 interface
        //--------------------------------------------------------------------
        .mst0_aclk    ('h1),
        .mst0_aresetn ('h1),
        .mst0_srst    ('h0),
        .mst0_awready ('h1),
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
        .mst0_rlast   ('h0),
        .mst0_ruser   ('h0),
        .mst0_awvalid (),
        .mst0_awaddr  (),
        .mst0_awlen   (),
        .mst0_awsize  (),
        .mst0_awburst (),
        .mst0_awlock  (),
        .mst0_awcache (),
        .mst0_awprot  (),
        .mst0_awqos   (),
        .mst0_awregion(),
        .mst0_awid    (),
        .mst0_awuser  (),
        .mst0_wvalid  (),
        .mst0_wlast   (),
        .mst0_wdata   (),
        .mst0_wstrb   (),
        .mst0_wuser   (),
        .mst0_bready  (),
        .mst0_arvalid (),
        .mst0_araddr  (),
        .mst0_arlen   (),
        .mst0_arsize  (),
        .mst0_arburst (),
        .mst0_arlock  (),
        .mst0_arcache (),
        .mst0_arprot  (),
        .mst0_arqos   (),
        .mst0_arregion(),
        .mst0_arid    (),
        .mst0_aruser  (),
        .mst0_rready  (),
        //--------------------------------------------------------------------
        // Slave Agent 1 interface
        //--------------------------------------------------------------------
        .mst1_aclk    ('h1),
        .mst1_aresetn ('h1),
        .mst1_srst    ('h0),
        .mst1_awready ('h1),
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
        .mst1_rlast   ('h0),
        .mst1_ruser   ('h0),
        .mst1_awvalid (),
        .mst1_awaddr  (),
        .mst1_awlen   (),
        .mst1_awsize  (),
        .mst1_awburst (),
        .mst1_awlock  (),
        .mst1_awcache (),
        .mst1_awprot  (),
        .mst1_awqos   (),
        .mst1_awregion(),
        .mst1_awid    (),
        .mst1_awuser  (),
        .mst1_wvalid  (),
        .mst1_wlast   (),
        .mst1_wdata   (),
        .mst1_wstrb   (),
        .mst1_wuser   (),
        .mst1_bready  (),
        .mst1_arvalid (),
        .mst1_araddr  (),
        .mst1_arlen   (),
        .mst1_arsize  (),
        .mst1_arburst (),
        .mst1_arlock  (),
        .mst1_arcache (),
        .mst1_arprot  (),
        .mst1_arqos   (),
        .mst1_arregion(),
        .mst1_arid    (),
        .mst1_aruser  (),
        .mst1_rready  (),

        //--------------------------------------------------------------------
        // Slave Agent 2 interface
        //--------------------------------------------------------------------
        .mst2_aclk    ('h1),
        .mst2_aresetn ('h1),
        .mst2_srst    ('h0),
        .mst2_awready ('h1),
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
        .mst2_rlast   ('h0),
        .mst2_ruser   ('h0),
        .mst2_awvalid (),
        .mst2_awaddr  (),
        .mst2_awlen   (),
        .mst2_awsize  (),
        .mst2_awburst (),
        .mst2_awlock  (),
        .mst2_awcache (),
        .mst2_awprot  (),
        .mst2_awqos   (),
        .mst2_awregion(),
        .mst2_awid    (),
        .mst2_awuser  (),
        .mst2_wvalid  (),
        .mst2_wlast   (),
        .mst2_wdata   (),
        .mst2_wstrb   (),
        .mst2_wuser   (),
        .mst2_bready  (),
        .mst2_arvalid (),
        .mst2_araddr  (),
        .mst2_arlen   (),
        .mst2_arsize  (),
        .mst2_arburst (),
        .mst2_arlock  (),
        .mst2_arcache (),
        .mst2_arprot  (),
        .mst2_arqos   (),
        .mst2_arregion(),
        .mst2_arid    (),
        .mst2_aruser  (),
        .mst2_rready  (),
        //--------------------------------------------------------------------
        // Slave Agent 0 interface
        //--------------------------------------------------------------------
        .mst3_aclk    ('h1),
        .mst3_aresetn ('h1),
        .mst3_srst    ('h0),
        .mst3_awready ('h1),
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
        .mst3_rlast   ('h0),
        .mst3_ruser   ('h0),
        .mst3_awvalid (),
        .mst3_awaddr  (),
        .mst3_awlen   (),
        .mst3_awsize  (),
        .mst3_awburst (),
        .mst3_awlock  (),
        .mst3_awcache (),
        .mst3_awprot  (),
        .mst3_awqos   (),
        .mst3_awregion(),
        .mst3_awid    (),
        .mst3_awuser  (),
        .mst3_wvalid  (),
        .mst3_wlast   (),
        .mst3_wdata   (),
        .mst3_wstrb   (),
        .mst3_wuser   (),
        .mst3_bready  (),
        .mst3_arvalid (),
        .mst3_araddr  (),
        .mst3_arlen   (),
        .mst3_arsize  (),
        .mst3_arburst (),
        .mst3_arlock  (),
        .mst3_arcache (),
        .mst3_arprot  (),
        .mst3_arqos   (),
        .mst3_arregion(),
        .mst3_arid    (),
        .mst3_aruser  (),
        .mst3_rready  ()
        //--------------------------------------------------------------------
    );

endmodule

    //--------------------------------------------------------------------
 
