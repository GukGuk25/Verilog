`timescale 1ns/1ps

module Mealy_Sequence_Detector (clk, rst_n, in, dec);
input clk, rst_n;
input in;
output dec;
reg[4-1:0] current_state;

//reg [4-1:0] current_state;
reg [4-1:0] next_state;
reg decout;
assign dec = decout;

parameter S0  = 4'bXXXX;
parameter SA1 = 4'b0XXX;
parameter SA2 = 4'b01XX;
parameter SA3 = 4'b011X;

parameter SBC1 = 4'b1XXX;
parameter SC2 = 4'b11XX;
parameter SC3 = 4'b110X;

parameter SB2 = 4'b10XX;
parameter SB3 = 4'b101X;

parameter SErr2 = 4'bXXX1;
parameter SErr3 = 4'bXX11;

always@(posedge clk) begin
    if(!rst_n) begin
        current_state <= S0;
    end else begin
        current_state <= next_state;
    end
    //stateout <= current_state;
end

always@(*)begin
    if(!rst_n) begin
        next_state = S0;
        decout = 1'b0;
    end else begin
    case(current_state)
        S0: begin
            if(in==1'b1) begin
                next_state = SBC1; //1
            end else begin
                next_state = SA1; //0
            end
            decout = 1'b0;
        end
        SA1: begin
            if(in==1'b1) begin
                next_state = SA2; //01
            end else begin
                next_state = SErr2;
            end
            decout = 1'b0;
        end
        SA2: begin
            if(in==1'b1) begin
                next_state = SA3; //011
            end else begin
                next_state = SErr3;
            end
            decout = 1'b0;
        end
        SA3: begin
            if(in==1'b1) begin
                decout = 1'b1; //FOUND 0111
            end else begin
                decout = 1'b0;
            end
            next_state = S0;
        end
        SBC1: begin
            if(in==1'b1) begin
                next_state = SC2; //11
            end else begin
                next_state = SB2; //10
            end
            decout = 1'b0;
        end
        SC2: begin
            if(in==1'b1) begin
                next_state = SErr3;
            end else begin
                next_state = SC3; //110
            end
            decout = 1'b0;
        end
        SC3: begin
            if(in==1'b1) begin
                decout = 1'b0;
            end else begin
                decout = 1'b1; //FOUND 1100
            end
            next_state = S0;
        end
        SB2: begin
            if(in==1'b1) begin
                next_state = SB3; //101
            end else begin
                next_state = SErr3; 
            end
            decout = 1'b0;
        end
        SB3: begin
            if(in==1'b1) begin
                decout = 1'b1; //FOUND 1011
            end else begin
                decout = 1'b0;
            end
            next_state = S0;
        end
        SErr2: begin
            next_state = SErr3;
            decout = 1'b0;
        end
        SErr3: begin
            next_state = S0;
            decout = 1'b0;
        end
    endcase
    end
end


endmodule
