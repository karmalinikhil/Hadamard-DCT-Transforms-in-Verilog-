# 2D DCT Transform Source

This folder contains:

- Main source files
- Testbench files
- IP cores (FIFO, RAM, etc.)
- Simulation results

## Overview

This project implements a 2D Discrete Cosine Transform (2D DCT) on a 4x4 input matrix using custom-designed FIFOs, RAMs, and multiplier blocks.

## Workflow

### First Stage (C*X Matrix Generation)

- The 4x4 input data is fed into four FIFOs (`fifo_generator_r0`, `fifo_generator_r1`, `fifo_generator_r2`, `fifo_generator_r3`), each 8 bits wide and 16 elements deep.
- Once filled, each FIFO sequentially sends its data to the multiplier block, where each row is multiplied by the DCT coefficient matrix (C).
- The resulting products are temporarily stored in custom RAMs and added to form the rows of the intermediate matrix **C × X**.
- The generated rows are also stored in custom FIFOs (`custom_fifo_22x4_r0`, `r1`, `r2`, `r3`) for parallel access later.
- After all four rows are processed, the outputs are merged into a `custom_fifo_22x16` for serialized access to the complete **C × X** matrix.

### Second Stage ((CX)^T*C) Matrix Generation)

- The serialized **C × X** matrix is fed into `DCT_2D_source_mult2.v`.
- Instead of storing and transposing the DCT coefficient matrix, the intermediate matrix (**C × X**) itself is transposed using `trans_mat.v`.
- The transposed matrix is again multiplied by the DCT coefficient matrix (C) to complete the 2D DCT computation.

### Final Stage ((2D_DCT Transfomed)^T Matrix Generation)

- `DCT_2D_source_final.v` instantiates all necessary modules.
- It coordinates the computation to provide:
  - Parallel outputs via `DCT_2D_out_final_r0`, `r1`, `r2`, `r3`
  - Serialized output via `DCT_2D_train_out`

## Key Modules

- `DCT_2D_source.v` — Generates the intermediate **C × X** matrix.
- `trans_mat.v` — Transposes matrices.
- `DCT_2D_source_mult2.v` — Performs the second multiplication to complete the 2D DCT.
- `DCT_2D_source_final.v` — Top-level module integrating all submodules.

  ![Waveform Output](DCT_1d_test02_5721_mat.png)
