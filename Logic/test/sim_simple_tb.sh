#VLSI5545

rm -rf ncverilog*
rm -rf INCA_libs

ncverilog \
-disable_sem2009 \
../../Logic/rtl/axicb_scfifo_ram.sv \
../../Logic/rtl/axicb_scfifo.sv \
../../Logic/rtl/axicb_pipeline.sv \
../../Logic/rtl/axicb_round_robin_core.sv \
../../Logic/rtl/axicb_round_robin.sv \
../../Logic/rtl/axicb_mst_if.sv \
../../Logic/rtl/axicb_slv_if.sv \
../../Logic/rtl/axicb_mst_switch.sv \
../../Logic/rtl/axicb_slv_switch.sv \
../../Logic/rtl/axicb_switch_top.sv \
../../Logic/rtl/axicb_crossbar.sv \
../../Logic/rtl/axicb_crossbar_top.sv \
simple_tb.v \
+nctimescale+1ns/1ns \
+access+r \
+gui

