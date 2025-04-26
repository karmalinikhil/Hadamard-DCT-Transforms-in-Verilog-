# Discrete Transforms Repository

This repository contains Verilog implementations of several important transforms widely used in image processing, data compression, and communication systems.  
Each design is modular, reusable, and comes with complete testbenches and simulation results.

## Use Cases

- **Image Compression** — (e.g., JPEG uses DCT transforms)
- **Signal Processing** — Noise reduction, data analysis
- **Feature Extraction** — Machine learning, computer vision
- **Hardware Acceleration** — FPGA/ASIC prototyping

---

## Repository Structure

- **Hadamard_transform/** — Contains the 1D Hadamard Transform implementation.
- **1D_Dct_transform/** — Contains the 1D Discrete Cosine Transform (DCT) implementation.
- **2D_Dct_transform/** — Contains the 2D Discrete Cosine Transform (2D DCT) implementation.

---

## Project Summaries

### Hadamard Transform

- **Workflow**:
  - The input vector is loaded into custom FIFOs.
  - It is multiplied by the Hadamard matrix through a series of additions and subtractions (no multipliers required).
  - The intermediate values are stored and serialized into the final output.

- **Simulation Results**:
  - Parallel and serial outputs of the transformed data are validated.
  - Detailed plots are provided in the [hadamard_transform/Test_results](Hadamard_transform/Test_results/README.md) folder.

[See full details ➔](Hadamard_transform/README.md)

---

### 1D DCT Transform

- **Workflow**:
  - The input vector is loaded into custom-designed FIFOs.
  - It is multiplied by the DCT coefficient matrix (C) using dedicated multiplier blocks.
  - The resulting intermediate products are stored temporarily in custom RAMs.
  - Additions are performed to obtain the final DCT-transformed output.

- **Simulation Results**:
  - Each stage of transformation is validated via testbenches.
  - Simulation waveforms are available in [1D_DCT_transform/Test_results](1D_DCT_transform/Test_results/README.md).

[See full details ➔](1D_DCT_transform/README.md)

---

### 2D DCT Transform

- **Workflow**:
  - To perform a 2D DCT, the basic mathematical requirement is:
    \[
    Y = C \times X \times C^T
    \]
    where:
      - \( X \) is the input matrix,
      - \( C \) is the DCT coefficient matrix,
      - \( C^T \) is the transpose of \( C \).

- **Logic Flow**:
  - **First Stage (Row Transformation)**:
    - The input 4x4 matrix is loaded into four separate FIFOs.
    - Each row is multiplied by the DCT coefficient matrix (C) to form an intermediate matrix (C × X).
    - Temporary RAMs and FIFOs are used for structured storage and parallelism.

  - **Transpose Stage**:
    - Instead of transposing the DCT coefficient matrix, the intermediate matrix (C × X) itself is transposed using `trans_mat.v`.
    - This tweak simplifies the hardware structure while achieving the same final result.

  - **Second Stage (Column Transformation)**:
    - The transposed matrix is again multiplied by the DCT coefficient matrix (C) to obtain the final transformed 2D DCT matrix.

  - **Final Output**:
    - Parallel outputs are provided for all rows.
    - Serial output is available for streaming applications.

- **Simulation Results**:
  - The correctness of row and column transformations is validated.
  - Waveforms and output snapshots are available in [2D_DCT_transform/Test_results](2D_DCT_transform/Test_results/README.md).

[See full details ➔](2D_DCT_transform/README.md)

---

## Highlights

- Modular Verilog design for easy FPGA/ASIC deployment.
- Complete simulation testbenches for validation.
- Custom IP blocks (FIFO, RAM, Multiplier modules) provided for reuse.
- Optimized data handling with serialized and parallel outputs.

---

## License

This project is released for academic, learning, and personal development purposes.
Feel free to fork and extend the designs!

