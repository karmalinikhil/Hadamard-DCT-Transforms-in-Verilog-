# IP Files

This folder contains:

- Custom Verilog IP modules (FIFOs, RAMs, etc.)
- Xilinx Core Generator IP (.xci) files

## Overview

This directory holds all reusable IP cores that were used in building the DCT Transform projects.  
It is organized as follows:

- **Custom_files/** — Contains all hand-written Verilog modules such as custom FIFOs, RAMs, and supporting logic blocks.
- **XCI_files/** — Contains `.xci` files for IP cores generated using Xilinx Vivado tools (e.g., FIFO Generators, RAM Blocks).

## Key Modules

- **custom_fifo_22x4.v** — Custom 22-bit wide, 4-depth FIFO for intermediate row storage.
- **custom_fifo_22x16.v** — Custom 22-bit wide, 16-depth FIFO for serialized matrix storage.
- **custom_ram.v** — 96-bit wide custom RAM used for temporary data storage.
- **trans_mat.v** — Module to perform matrix transposition.

Other files inside the `xci_files/` folder include configuration files for standard FIFOs and RAMs generated via Vivado’s IP catalog.

These IPs are essential building blocks for both 1D and 2D DCT projects.


