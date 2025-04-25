# IP Cores – 1D DCT Transform

This folder contains the IP core configuration files (`.xci`) used in the 1D DCT Transform project. These are Vivado-generated IPs essential for buffering, computation, and storage.

##  Included IPs
- **FIFO Generator** – 8-bit wide, 16-depth FIFO for input buffering
- **Multipliers** – Used to multiply input data with DCT coefficients
- **Custom RAM** – 96-bit wide memory for storing intermediate multiplication results

>  Only the `.xci` files are included here along with the .v file for the custom ram. Vivado will automatically regenerate the required IP source files during synthesis or simulation.

Make sure to open the full project in Vivado using the `.xpr` file to rebuild the IPs as needed.

