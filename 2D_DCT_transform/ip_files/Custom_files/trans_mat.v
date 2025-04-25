`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2025 08:05:19 PM
// Design Name: 
// Module Name: trans_mat
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
/////////////////////////////////////////////////////////////////////////////////

module trans_mat(
    input clk,
    input rst,
    input valid_in,
    input [21:0] col_in0,
    input [21:0] col_in1,
    input [21:0] col_in2,
    input [21:0] col_in3,
    output reg valid_out,
    output reg [21:0] col_out0,
    output reg [21:0] col_out1,
    output reg [21:0] col_out2,
    output reg [21:0] col_out3
);

    reg [21:0] matrix[3:0][3:0]; // 4x4 matrix storage
    reg [21:0] transposed[3:0][3:0]; // Transposed matrix storage
    reg [1:0] row_count = 0;
    reg [1:0] col_count = 0;
    reg data_ready = 0;
    reg [1:0] repeat_count = 0;

    always @(posedge clk or posedge rst) begin
        if (!rst) begin
            row_count <= 0;
            col_count <= 0;
            data_ready <= 0;
            repeat_count <= 0;
            valid_out <= 0;
        end 
        else if (valid_in && !data_ready) begin
            // Store incoming column into the matrix
            matrix[col_count][0] <= col_in0;
            matrix[col_count][1] <= col_in1;
            matrix[col_count][2] <= col_in2;
            matrix[col_count][3] <= col_in3;

            // Update column counter
            if (col_count == 3) begin
                col_count <= 0;
                data_ready <= 1; // Matrix is fully received
                
                // Perform transposition
                transposed[0][0] <= matrix[0][0];
                transposed[0][1] <= matrix[1][0];
                transposed[0][2] <= matrix[2][0];
                transposed[0][3] <= matrix[3][0];
                
                transposed[1][0] <= matrix[0][1];
                transposed[1][1] <= matrix[1][1];
                transposed[1][2] <= matrix[2][1];
                transposed[1][3] <= matrix[3][1];
                
                transposed[2][0] <= matrix[0][2];
                transposed[2][1] <= matrix[1][2];
                transposed[2][2] <= matrix[2][2];
                transposed[2][3] <= matrix[3][2];
                
                transposed[3][0] <= matrix[0][3];
                transposed[3][1] <= matrix[1][3];
                transposed[3][2] <= matrix[2][3];
                transposed[3][3] <= matrix[3][3];
            end else begin
                col_count <= col_count + 1;
            end
        end
        else if (data_ready && repeat_count < 4) begin
            // Send transposed matrix column by column
            valid_out <= 1;
            col_out0 <= transposed[row_count][0];
            col_out1 <= transposed[row_count][1];
            col_out2 <= transposed[row_count][2];
            col_out3 <= transposed[row_count][3];
            
            if (row_count == 3) begin
                row_count <= 0;
                repeat_count <= repeat_count + 1;
                if (repeat_count == 3) begin
                    data_ready <= 0; // Stop output after 4 repetitions
                    valid_out <= 0;
                end
            end else begin
                row_count <= row_count + 1;
            end
        end
    end
endmodule


