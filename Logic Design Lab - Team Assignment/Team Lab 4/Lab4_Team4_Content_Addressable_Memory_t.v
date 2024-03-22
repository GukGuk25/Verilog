`timescale 1ns/1ps

module cam_tb;
reg clk = 1'b0;
reg wen = 1'b0, ren = 1'b0;
reg [4-1:0] addr = 1'b0;
reg [8-1:0] din = 1'b0;
wire [4-1:0] dout;
wire hit;

parameter cyc = 10;
always #(cyc/2) clk = ~clk;

Content_Addressable_Memory scam(clk, wen, ren, din, addr, dout, hit);

initial begin
    @(negedge clk) wen = 1'b1; addr = 4'd1; din =8'd4;
    @(negedge clk) wen = 1'b1; addr = 4'd7; din =8'd8;
    @(negedge clk) wen = 1'b1; addr = 4'd15; din =8'd35;
    @(negedge clk) wen = 1'b1; addr = 4'd9; din =8'd8;
    @(negedge clk) wen = 1'b0; addr = 4'd0; din =8'd0;
    @(negedge clk) wen = 1'b0;
    @(negedge clk) wen = 1'b0;
    @(negedge clk) wen = 1'b0;
    @(negedge clk) wen =1'b1;ren = 1'b1; addr = 4'b0; din =8'd4;
    @(negedge clk) ren = 1'b1; addr = 4'b1; din =8'd100;  //
    @(negedge clk) ren = 1'b1; addr = 4'b0; din =8'd35;
    @(negedge clk) ren = 1'b1; addr = 4'b0; din =8'd87;
    @(negedge clk) ren = 1'b1; addr = 4'b0; din =8'd8;
    @(negedge clk) ren = 1'b0; addr = 4'b0; din =8'd0;
    @(negedge clk) ren = 1'b1; addr = 4'b0; din =8'd87;
    @(negedge clk) ren = 1'b1; addr=4'b0; din =8'd0;
    
    @(negedge clk) wen = 1'b0; ren = 1'b0;
    @(negedge clk) wen = 1'b1; addr = 4'd5; din = 8'd11;
    @(negedge clk) wen = 1'b1; addr = 4'd5; din = 8'd100;
    @(negedge clk) wen = 1'b0; ren =1'b1; din =8'd11;
    @(negedge clk) wen = 1'b0; ren =1'b1; din =8'd100;
    @(negedge clk) ren = 1'b0;
    @(negedge clk) ren = 1'b0;
    @(negedge clk) $finish;
end

endmodule