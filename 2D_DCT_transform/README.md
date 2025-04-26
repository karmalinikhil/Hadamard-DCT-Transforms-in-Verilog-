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

## Simulation Results

Below are the simulation outputs generated for the 2D DCT Transform:

### C and X Matrix used 

![C and X Matrix used ](Test_results/C*X_51149.png)

### Input Data Waveform

![Input Data Waveform](Test_results/2D_DCT_input_data_full.png)

### Intermediate CX Matrix (After First Stage)

![CX Matrix Output](Test_results/C*X_51149_result.png)

### Intermediate CX Matrix Waveform 

![CX Matrix Output](Test_results/2D_DCT_mid_parallel_out.png)

###  (CX)^T Matrix Generated

![(CX)^T Matrix Generated](Test_results/C*X_51149_result_tran.png)

###  (CX)^T * C Matrices 

![(CX)^T * C Matrices ](Test_results/C*(C*X)T_51149.png)

### Final 2D DCT Transformed Matrix (After Second Stage)

![Final 2D DCT Output](Test_results/C*(C*X)T_51149_result.png)

### Final 2D DCT Transformed Matrix Waveform ( Parallel )

![Final 2D DCT Output](Test_results/2D_DCT_parallel_out.png)


### Final 2D DCT Transformed Matrix Waveform ( Serial )

![Final 2D DCT Output](Test_results/2D_DCT_serial_out_1.png)
![Final 2D DCT Output](Test_results/2D_DCT_serial_out_2.png)


### Full Output Wavform With all Sources and Ips used 

![Final 2D DCT Output](Test_results/2D_DCT_Full_waveform.png)




  
