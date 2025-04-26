# Source and Testbench Files

This folder contains:

- Source Verilog files for the 2D DCT Transform design
- A dedicated testbench file for simulation

## Overview

This directory includes all the Verilog source modules necessary for performing the complete 2D DCT transform, as well as the testbench used to verify the design through simulation.

## Key Files

- **DCT_2D_source.v** — Module to generate the intermediate C × X matrix by row-wise DCT transformation.
- **DCT_2D_source_mult2.v** — Module to complete the column-wise DCT multiplication after transposing the intermediate matrix.
- **DCT_2D_source_final.v** — Top-level module that integrates all stages to perform the full 2D DCT transformation.
- **DCT_2D_tb.v** — Testbench to simulate and verify the correct functionality of the complete 2D DCT system.

## Notes

- The testbench **2D_DCT_tb.v** is designed to validate the final output by simulating the integrated top-level design.
- All source files are structured for modularity and ease of reuse.


