`timescale 1ns/1ps

module Moore (clk, rst_n, in, out, state);
    input clk, rst_n;
    input in;
    output reg[2-1:0] out;
    output reg[3-1:0] state;
    reg [2:0]nextstate;
    reg [1:0]nextout;
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    
    always@(posedge clk)begin
        if (rst_n == 1'd0)begin
            state <= S0;
            out <= 2'b11;
        end else begin
            state <= nextstate;
            out <= nextout;
        end
    end
    
    always@(*)begin
        case(state)
            S0 : begin
                if (in == 1'd1) begin
                    nextstate = S2;
                    nextout = 2'b11;
                end else begin
                    nextstate = S1;
                    nextout = 2'b01;
                end
            end
            S1 : begin
                if (in == 1'd1) begin
                    nextstate = S5;
                    nextout = 2'b00;
                end else begin
                    nextstate = S4;
                    nextout = 2'b10;
                end            
            end
            S2 : begin
                if (in == 1'd1) begin
                    nextstate = S3;
                    nextout = 2'b10;
                end else begin
                    nextstate = S1;
                    nextout =  2'b01;
                end
            end
            S3 : begin
                if (in == 1'd1) begin
                    nextstate = S0;
                    nextout = 2'b11;
                end else begin
                    nextstate = S1;
                    nextout = 2'b01;
                end            
            end
            S4 : begin
                if (in == 1'd1) begin
                    nextstate = S5;
                    nextout = 2'b00;
                end else begin
                    nextstate = S4;
                    nextout = 2'b10;
                end
            end
            S5 : begin
                if (in == 1'd1) begin
                    nextstate = S0;
                    nextout = 2'b11;
                end else begin
                    nextstate = S3;
                    nextout = 2'b10;
                end
            end
            default : begin
                if (in == 1'd1) begin
                    nextstate = S1;
                    nextout = 2'b01;
                end else begin
                    nextstate = S0;
                    nextout = 2'b11;
                end
            end
        endcase
    end
endmodule
