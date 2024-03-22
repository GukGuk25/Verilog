`timescale 1ns/1ps

module Clock_Divider (clk, rst_n, sel, clk1_2, clk1_4, clk1_8, clk1_3, dclk);
    input clk, rst_n;
    input [2-1:0] sel;
    output clk1_2;
    output clk1_4;
    output clk1_8;
    output clk1_3;
    output dclk;
    
    reg[4:0] counter = 4'd0;
    reg clk2 = 1'b0, clk4= 1'b0, clk8= 1'b0, clk3= 1'b0;
    
    assign clk1_2 = clk2;    
    assign clk1_3 = clk3;
    assign clk1_4 = clk4;
    assign clk1_8 = clk8;
    assign dclk = sel[1] ? (sel[0] ? clk1_8: clk1_4) : (sel[0]? clk1_2 : clk1_3);
    
    always @(posedge clk) begin
        if (rst_n==1'b0) begin //set condition when rst_n is 0 then we need to rest all to 0
            clk2 <= 1'b1;
            clk4 <= 1'b1;
            clk8 <= 1'b1;
            clk3 <= 1'b1;
            counter <= 4'b0;
            end
      
        else begin 
            counter = counter + 4'b1;
            clk2 <= (counter%2) ? 1'b0 : 1'b1;
            clk3 <= (counter%3) ? 1'b0 : 1'b1;
            clk4 <= (counter%4) ? 1'b0 : 1'b1;
            clk8 <= (counter%8) ? 1'b0 : 1'b1; 
            end
    end
    
//    always @(*) begin
//        case(sel)
//            2'b00 : dclk = clk3;
//            2'b01 : dclk = clk1_2;
//            2'b10 : dclk = clk1_4;
//            2'b11 : dclk = clk1_8;
//            default : dclk = 4'd0;
//        endcase
//    end
endmodule


    