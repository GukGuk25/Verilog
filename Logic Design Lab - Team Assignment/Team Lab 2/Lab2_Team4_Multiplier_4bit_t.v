`timescale 1ns / 1ps

module Testbench;
reg [4-1:0] a=4'b0000,b=4'b0000;
wire [8-1:0] p;

Multiplier_4bit multiplier(
    .a(a),
    .b(b),
    .p(p)
 );
 
     initial begin
         repeat(16) begin
            #1 a = a + 4'b0001;
            repeat(16) begin
               #1 b = b + 4'b0001;
            end
         end
         #1 $finish;
     end 
endmodule
