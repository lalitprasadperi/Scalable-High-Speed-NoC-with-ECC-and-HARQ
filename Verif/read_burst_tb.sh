#VLSI5545

# Clear previous simulation data
echo "Removing old simulation files..."
rm -rf ncverilog*
rm -rf INCA_libs

# Define the path to the RTL and verification files
RTL_PATH="../../Logic/rtl"
VERIF_PATH="../../Verif"

# List of RTL source files
rtl_files=(
    "$RTL_PATH/axicb_scfifo_ram.sv"
    "$RTL_PATH/axicb_scfifo.sv"
    "$RTL_PATH/axicb_pipeline.sv"
    "$RTL_PATH/axicb_round_robin_core.sv"
    "$RTL_PATH/axicb_round_robin.sv"
    "$RTL_PATH/axicb_mst_if.sv"
    "$RTL_PATH/axicb_slv_if.sv"
    "$RTL_PATH/axicb_mst_switch.sv"
    "$RTL_PATH/axicb_slv_switch.sv"
    "$RTL_PATH/axicb_switch_top.sv"
    "$RTL_PATH/axicb_crossbar.sv"
    "$RTL_PATH/axicb_crossbar_top.sv"
)

# Testbench file
tb_file="$VERIF_PATH/read_burst_tb.sv"

# NCVerilog simulation command
echo "Starting simulation..."
ncverilog \
    -disable_sem2009 \
    "${rtl_files[@]}" \
    "$tb_file" \
    +nctimescale+1ns/1ns \
    +access+r \
    +gui

echo "Simulation completed."
