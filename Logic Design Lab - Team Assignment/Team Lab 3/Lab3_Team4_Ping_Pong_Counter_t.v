`timescale 1ns / 1ps

module Ping_Pong_Counter_t;
    reg clk = 1'b0, rst_n = 1'b0, enable = 1'b0;
    wire direction;
    wire[3:0] out;
    //reg [15:0] counter = 16'd0;
    Ping_Pong_Counter PPC(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .direction(direction),
        .out(out)
    );
    
    always #1 begin
        clk = !clk; //to make clock up and down every 1 ns
    end
    initial begin
        @(negedge clk)begin
            rst_n <= 1'b1;                
            enable <= 1'b1;
        end
        #100 $finish;
    end
    
endmodule