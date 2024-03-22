`timescale 1ns / 1ps

module Round_Robin_FIFO_Arbiter_testbench;
    reg clk=0;
    reg rst_n=0;
    reg [3:0] wen=0;
    reg [7:0] a=1, b=1, c=1, d=1;
    wire [7:0] dout;
    wire valid;
    
    parameter cyc = 10;
    
    Round_Robin_FIFO_Arbiter ArbiterControl(clk, rst_n, wen, a, b, c, d, dout, valid);
    
    always#(cyc/2)clk = !clk;
        
    initial begin
        @(negedge clk)
            rst_n = 1'b0;
        @(negedge clk)
            rst_n = 1'b1;
            wen = 4'b1011;
            a = 8'd10; b = 8'd20; c = 8'd30; d = 8'd40;    
        repeat(5) begin
            @(negedge clk)
            a = a+1;
            b = b+1;
            c = c+1;
            d = d+1;
        end
        
      wen = 4'b0000;
      @(negedge clk)
        repeat(16) begin
            @(negedge clk)
            wen = 4'b0000;
        end
        
        @(posedge clk)
            rst_n = 1'b0;
        @(negedge clk)
            rst_n = 1'b1;
            wen = 4'b1111;
            a = 8'd10; b = 8'd20; c = 8'd30; d = 8'd40;    
        repeat(5) begin
            @(negedge clk)
            a = a+1;
            b = b+1;
            c = c+1;
            d = d+1;
        end
        
      wen = 4'b0000;
      @(negedge clk)
        repeat(16) begin
            @(negedge clk)
            wen = 4'b0000;
        end
    $finish;
    end
    
endmodule
