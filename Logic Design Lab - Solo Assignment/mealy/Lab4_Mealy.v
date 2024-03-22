`timescale 1ns/1ps

module Mealy (clk, rst_n, in, out, state);
    input clk, rst_n;
    input in;
    output reg out;
    output reg [3-1:0] state;
    reg [2:0] nextstate;
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    
    always@(posedge clk)begin
        if (rst_n == 1'd0)begin
            state <= S0;
        end else begin
            state <= nextstate;
        end
    end
    
    always@(*)begin
        case(state)
            S0 : begin
                if (in == 1'd1) begin
                    nextstate = S2;
                    out = 1'b1;
                end else begin
                    nextstate = S0;
                    out = 1'b0;
                end
            end
            S1 : begin
                if (in == 1'd1) begin
                    nextstate = S4;
                    out = 1'b1;
                end else begin
                    nextstate = S0;
                    out = 1'd1;
                end            
            end
            S2 : begin
                if (in == 1'd1) begin
                    nextstate = S1;
                    out = 1'b0;
                end else begin
                    nextstate = S5;
                    out = 1'b1;
                end
            end
            S3 : begin
                if (in == 1'd1) begin
                    nextstate = S2;
                    out = 1'b0;
                end else begin
                    nextstate = S3;
                    out = 1'b1;
                end            
            end
            S4 : begin
                if (in == 1'd1) begin
                    nextstate = S4;
                    out = 1'b1;
                end else begin
                    nextstate = S2;
                    out = 1'b1;
                end
            end
            S5 : begin
                if (in == 1'd1) begin
                    nextstate = S4;
                    out = 1'b0;
                end else begin
                    nextstate = S3;
                    out = 1'b0;
                end
            end
            default : begin
                if (in == 1'd1) begin
                    nextstate = S1;
                    out = 1'b0;
                end else begin
                    nextstate = S0;
                    out = 1'd1;
                end
            end
        endcase
    end
endmodule



