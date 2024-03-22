`timescale 1ns/1ps

module Memory (clk, ren, wen, addr, din, dout);
    input clk;
    input ren, wen;
    input [7-1:0] addr;
    input [8-1:0] din;
    output reg[8-1:0] dout;
    
    reg [7:0]memory[127:0];
    reg rst_n = 1'b1;

    integer i;
    always@(posedge clk) begin
        if (rst_n == 1'b1) begin
            for (i=0 ; i<128 ; i=i+1) begin
                memory[i] <= 8'b0;
            end
            rst_n <= 1'b0;
        end else begin
            if (ren == 1'b1) begin
                dout <= memory[addr];
            end else begin
                if (wen ==1) begin
                    memory[addr] <= din;
                    dout <= 8'd0;
                end else begin
                    dout<=8'b0;
                end
            end
        end
    end
    

endmodule
