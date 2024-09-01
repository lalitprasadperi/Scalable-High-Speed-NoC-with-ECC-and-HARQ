# Enhancing Reliability of On-Chip Networks with Scalable AXI NOC
Senior Project for [ECE5545]: AXI NOC with Embedded ECC and HARQ
## Abstract

This project presents a study focused on enhancing the reliability of on-chip Networks-on-Chip (NOCs) through the implementation of a scalable AXI NOC with embedded **Error Correction Code (ECC)** and **Hybrid Automatic Repeat reQuest (HARQ)** mechanisms. 

### Key Findings

- **Resource Utilization**: By introducing ECC and HARQ logic into a 4x4 NOC configuration, we observed:
  - A mere **4% increase** in FPGA Look-Up Table (LUT) utilization, indicating efficient resource use.
  - The integration of multi-stage clock-gating led to only **1.7% area overhead**.
  - A substantial **26% reduction** in dynamic power consumption at an 800MHz frequency corner.

These findings underscore the feasibility and effectiveness of our proposed enhancements in improving NOC reliability while maintaining resource efficiency and optimizing power usage.

### Future Work

- **Scalability Potential**: We propose extending this project to investigate scalability, particularly exploring configurations up to **256x256**, to further advance high-speed NOC architectures.

## Architecture and Design of AXI NOC

### Key Design Features of a 4x4 AXI NOC

1. **Multiple Masters**: 
   - The interconnect allows multiple master devices, such as CPUs, DMA controllers, or accelerators, to initiate data transactions independently.
   - Each master has its own dedicated clock inputs to dynamically scale frequencies based on workload requirements.

2. **Multiple Slaves**:
   - The interconnect supports communication with multiple slave devices, which could include memory controllers, peripheral interfaces, or other functional blocks within the SoC.
   - Each slave agent is physically addressed with 4KB of address space.

3. **Switching Arbitration**:
   - The interconnect employs arbitration mechanisms to manage simultaneous access requests from multiple masters.
   - This ensures fair and efficient utilization of the available bandwidth, preventing bottlenecks and contention for shared resources.

4. **Network Interface and Buffering**:
   - The network interface manages communication between IP cores and the NOC, handling data packetization, addressing, and routing.
   - Buffering temporarily stores packets to manage transmission delays and alleviate contention, ensuring efficient data transmission in complex System-on-Chip (SoC) designs.

## Conclusion

This study demonstrates the effectiveness of integrating ECC and HARQ mechanisms into NOC architectures, achieving significant reliability improvements with minimal resource overhead. The promising results suggest that further exploration into larger, high-speed NOC configurations is warranted.
