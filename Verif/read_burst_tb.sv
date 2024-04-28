`include "uvm_macros.svh"
import uvm_pkg::*;



interface axi4_if(
    input logic clk,
    input logic reset_n
);

    // Read Address Channel
    logic [31:0] araddr;
    logic [3:0] arid;
    logic [7:0] arlen;
    logic [2:0] arsize;
    logic [1:0] arburst;
    logic arvalid;
    logic arready;

    // Read Data Channel
    logic [31:0] rdata;
    logic [3:0] rid;
    logic rlast;
    logic rvalid;
    logic rready;

endinterface

class axi4_driver extends uvm_driver #(axi4_transaction);
    virtual axi4_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(req);
            vif.araddr <= req.araddr;
            vif.arid <= req.arid;
            vif.arlen <= req.arlen;
            vif.arsize <= req.arsize;
            vif.arburst <= req.arburst;
            vif.arvalid <= 1;
            @(posedge vif.clk);
            vif.arvalid <= 0;
            seq_item_port.item_done();
        end
    endtask
endclass

class read_burst_seq extends uvm_sequence #(axi4_transaction);
    `uvm_object_utils(read_burst_seq)

    task body();
        axi4_transaction txn;
        txn = axi4_transaction::type_id::create("txn");
        txn.araddr = 'h1000;  // Start address
        txn.arid = 0;
        txn.arlen = 8;  // 8 transfers in the burst
        txn.arsize = 2; // Each transfer of 4 bytes
        txn.arburst = 2'b01; // INCR type burst
        start_item(txn);
        finish_item(txn);
    endtask
endclass

class axi4_env extends uvm_env;
    axi4_agent m_agent;

    function void build_phase(uvm_phase phase);
        m_agent = axi4_agent::type_id::create("m_agent", this);
    endfunction
endclass

class axi4_test extends uvm_test;
    axi4_env env;

    function void build_phase(uvm_phase phase);
        env = axi4_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        read_burst_seq seq = read_burst_seq::type_id::create("seq");
        seq.start(env.m_agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass

class axi4_monitor extends uvm_monitor;
    `uvm_component_utils(axi4_monitor)
    virtual axi4_if vif;
    uvm_analysis_port #(axi4_transaction) analysis_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        axi4_transaction txn;
        forever begin
            wait(vif.arvalid && vif.arready); // Wait for a valid read address
            txn = axi4_transaction::type_id::create("txn");
            txn.araddr = vif.araddr;
            txn.arid = vif.arid;
            txn.arlen = vif.arlen;
            txn.arsize = vif.arsize;
            txn.arburst = vif.arburst;
            // Capture the whole transaction
            analysis_port.write(txn); // Send it to the scoreboard
        end
    endtask
endclass

class axi4_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(axi4_scoreboard)
    uvm_tlm_analysis_fifo #(axi4_transaction) txn_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        txn_fifo = new("txn_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        axi4_transaction txn;
        forever begin
            txn = txn_fifo.get(); // Get transaction from monitor
            // Perform checks and compare against expected values
            `uvm_info(get_full_name(), $sformatf("Received transaction with address: %0h", txn.araddr), UVM_LOW)
        end
    endtask
endclass

initial begin
    uvm_config_db #(virtual axi4_if)::set(uvm_root::get(), "uvm_test_top.env.m_agent", "vif", intf);
    run_test("axi4_test");
end



module tb_AXI4_ReadBurst;
    axi4_if intf(.clk(clk), .reset_n(reset_n));
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset_n = 0;
        #100 reset_n = 1;
    end

   
