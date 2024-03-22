`timescale 1ns / 1ps

module Mealy_Sequence_Detector_t;
reg clk = 1'b1;
reg rst_n = 1'b0;
reg in = 1'b0;
wire dec;

Mealy_Sequence_Detector mealy_sequence(
    clk, rst_n, in, dec
);
    
parameter cyc = 5;
always #(cyc) clk = ~clk;

initial begin
    @(negedge clk) rst_n = 1'b0;
    @(negedge clk) rst_n = 1'b1;

    @(posedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;

    @(negedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b0;

    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;

    @(negedge clk) rst_n = 0;in = 1'b1;
    @(negedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;
    @(negedge clk) rst_n = 1;
    
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b0;
    @(negedge clk) in = 1'b1;
    @(negedge clk) in = 1'b1;
    
    #10 $finish;
end
endmodule
