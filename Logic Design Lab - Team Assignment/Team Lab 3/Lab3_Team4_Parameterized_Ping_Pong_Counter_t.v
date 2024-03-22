`timescale 1ns/1ps

module Parameterized_Ping_Pong_Counter_t;
    reg clk, rst_n;
    reg enable;
    reg flip;
    reg [3:0] max;
    reg [3:0] min;
    wire direction;
    wire [3:0] out;

    parameter cyc = 10;

    Parameterized_Ping_Pong_Counter P(
        .clk(clk), 
        .rst_n(rst_n), 
        .enable(enable), 
        .flip(flip), 
        .max(max), 
        .min(min), 
        .direction(direction), 
        .out(out)
    );

    always#(cyc/2)clk = !clk;

    initial begin
        clk = 1'b1;
        rst_n = 1'b0;
        enable = 1'b0;
        flip = 1'b0;
        max = 1'b0;
        min = 1'b0;
        
        
        @(posedge clk) begin //begin
            rst_n = 1'd1;
            enable = 1'd1;
        end
        #(cyc * 2)
        @(posedge clk)begin // min < out < max hold val
            max = 4'd2;
            min = 4'd0;
        end
        @(posedge clk)begin // max < min hold val
            max = 4'd1;
            min = 4'd2;
        end
        @(posedge clk)begin // min==max < out hold val
            max = 4'd2;
            min = 4'd2;
        end
        @(posedge clk)begin // min == out == max hold val
            max = 4'd1;
            min = 4'd1;
        end
        @(posedge clk)begin // min == max > out hold val
            max = 4'd0;
            min = 4'd0;
        end
        @(posedge clk)begin // min == max > out hold val
            max = 4'd8;
            min = 4'd0;
        end
        #(cyc * 5)
        @(posedge clk) flip = 1'b1;
        @(posedge clk) flip = 1'b0;

        #(cyc * 10) enable = 1'b0;
        #(cyc * 5) enable = 1'b1;
        #(cyc * 7)
        @(posedge clk) begin
            max = 4'd15;
            min = 4'd0;
        end

        #(cyc * 7) 
        @(posedge clk) max = 4'd4;
        @(posedge clk) flip = 1'b1;
        @(posedge clk) flip = 1'b0;
        #(cyc * 1) 
        @(posedge clk) flip = 1'b1;
        @(posedge clk) flip = 1'b0;
        #(cyc * 7)
        @(posedge clk) begin
            min = 4'd0;
            max = 4'd15;
        end
        #(cyc*5)
        @(posedge clk) rst_n = 1'd0; // check when we reset is the out = 0
        #(cyc * 2)
        @(posedge clk) rst_n = 1'd1;
        #(cyc * 7) $finish;
    end

endmodule