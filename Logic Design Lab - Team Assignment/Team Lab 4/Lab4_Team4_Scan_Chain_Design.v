`timescale 1ns/1ps

module Scan_Chain_Design(clk, rst_n, scan_in, scan_en, scan_out);
    input clk;
    input rst_n;
    input scan_in;
    input scan_en;
    output scan_out;
    wire[7:0] data, p;
    
    assign scan_out = data[0];
    
    //8 special DFF
    
    //A
    SDFF s0(clk, rst_n, scan_in, scan_en, p[7], data[7]);
    SDFF s1(clk, rst_n, data[7], scan_en, p[6], data[6]);
    SDFF s2(clk, rst_n, data[6], scan_en, p[5], data[5]);
    SDFF s3(clk, rst_n, data[5], scan_en, p[4], data[4]);
    //B
    SDFF s4(clk, rst_n, data[4], scan_en, p[3], data[3]);
    SDFF s5(clk, rst_n, data[3], scan_en, p[2], data[2]);
    SDFF s6(clk, rst_n, data[2], scan_en, p[1], data[1]);
    SDFF s7(clk, rst_n, data[1], scan_en, p[0], data[0]);
    
    //multiplication part A = data[7:4], B = data[3:0]
    multiplication m0(p, data[7:4], data[3:0]);
    //assign p = data[7:4] * data[3:0];

endmodule

module SDFF(clk, rst_n, scan_in, scan_en, data, out);
    input clk;
    input rst_n;
    input scan_in;
    input scan_en;
    input data;
    output reg out;//aka Q

    //Reset all SDFFs to 1'b0 when rst_n == 1'b0 
    always @(posedge clk)begin
        // a flip flop controlled by rst_n
        if(rst_n == 1'd0)begin
            out <= 1'd0;
        end else begin
            // a flip flop if rst_n == 1'd1 controled by scan_en
            if(scan_en == 1'd0)begin
                out <= data;
            end else begin
                out <= scan_in;
            end

        end
    end
            
endmodule

module multiplication(out, in1, in2);
    input [3:0]in1; //a
    input [3:0]in2; //b
    output [7:0]out; //p
    
    assign out = in1 * in2;
endmodule