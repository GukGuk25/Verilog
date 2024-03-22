`timescale 1ns/1ps

module Sliding_Window_Sequence_Detector (clk, rst_n, in, dec);
    input clk, rst_n;
    input in;
    output dec;
    
    reg output_dec;
    assign dec = output_dec;
    reg [7-1:0]current_state;
    reg [7-1:0]upcoming_state;
    
    parameter Null_State = 7'bXXXX_XXX;
    parameter State_1 = 7'b1XXX_XXX;
    parameter State_11 = 7'b11XX_XXX;
    parameter State_111 = 7'b111X_XXX;
    parameter State_1110 = 7'b1110_XXX;
    parameter State_1110_0 = 7'b1110_0XX;
    parameter State_1110_01 = 7'b1110_01X;
    parameter State_1110_01_1 = 7'b1110_01_1;
    //parameter State_1110_01 = 4'b0000;
    
    always@(posedge clk) begin
        if(!rst_n) begin
            current_state <= Null_State;
        end else begin
            current_state <= upcoming_state;
        end
    end
    
    always@(*) begin
        case(current_state)
            Null_State: begin
                if(in) begin upcoming_state = State_1; end
                else begin upcoming_state = Null_State; end
                output_dec = 1'b0;
            end
            State_1: begin
                if(in) begin upcoming_state = State_11; end
                else begin upcoming_state = Null_State; end
                output_dec = 1'b0;
            end
            State_11: begin
                if(in) begin upcoming_state = State_111; end
                else begin upcoming_state = Null_State; end
                output_dec = 1'b0;
            end
            State_111: begin
                if(in) begin upcoming_state = State_111; end
                else begin upcoming_state = State_1110; end
                output_dec = 1'b0;
            end
            State_1110: begin
                if(in) begin upcoming_state = State_1; end
                else begin upcoming_state = State_1110_0; end
                output_dec = 1'b0;
            end
            State_1110_0: begin
                if(in) begin upcoming_state = State_1110_01; end
                else begin upcoming_state = Null_State; end
                output_dec = 1'b0;
            end
            State_1110_01: begin
                if(in) begin upcoming_state = State_1110_01_1; end
                else begin upcoming_state = State_1110_0; end
                output_dec = 1'b0;
            end
            State_1110_01_1: begin
                if(in) begin upcoming_state = State_111; output_dec = 1'b1;end
                else begin upcoming_state = Null_State; output_dec = 1'b0;end
            end                   
        endcase
    end

endmodule 