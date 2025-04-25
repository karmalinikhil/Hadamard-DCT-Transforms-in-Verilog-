#  1D DCT Transform – Verilog Source & Testbench

This folder contains the main Verilog module and testbench for a 1D Discrete Cosine Transform (DCT), designed to process a 4×4 matrix of 8-bit input values.

##  Contents
- `dct_top.v` – Main Verilog module implementing the 1D DCT logic
- `dct_tb.v` – Testbench to simulate and verify the design


## ⚙ How It Works
1. 4×4 input data (8-bit each) is pushed into a 16-depth FIFO.
2. Data is fed into a multiplier block where it is multiplied with the DCT coefficient matrix.
3. Multiplied results are stored in a 96-bit wide custom RAM.
4. Each 96-bit RAM output is split into four 24-bit values, added to compute one DCT output element.
5. Repeated for all four rows to generate a 4×1 DCT-transformed matrix.

##  Simulation Results
Check the `test_results/` folder for waveform outputs validating the DCT logic.


