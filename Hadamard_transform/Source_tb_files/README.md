# Hadamard Transform – Source & Testbench

This folder contains the Verilog source code and simulation testbench used to implement and verify a 4×4 Hadamard transform.

# Files Included
- `had_trans_display.v` – Main source file with the complete transform logic
- `tb_had_trans.v` – Testbench used to simulate the design

# Workflow Summary
- 8-bit input data is pushed into a FIFO (16-depth).
- Data flows from FIFO into RAM, grouping every 4 bytes into a 32-bit word.
- The RAM output is processed by parallel adder logic to generate 4 Hadamard outputs per cycle.
- The full 4×4 matrix is computed and the result is stored in a custom fifo for later use.
  

# Simulation Output
Simulation results are available in the Test_results folder or are included in the readme file in the hadamard_transform folder.


*Designed using Verilog HDL | Simulated in Vivado*


    
   
