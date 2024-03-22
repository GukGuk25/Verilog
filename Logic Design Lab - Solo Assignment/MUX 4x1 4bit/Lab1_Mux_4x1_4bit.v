`timescale 1ns/1ps

module Mux_2x1(o,a,b,s);
    input[4-1:0] a,b;
    input s;
    output[4-1:0] o;
    wire nots, and0, and1, and2, and3, and4, and5, and6,and7;
    
    not not_s(nots,s);
    and and_0(and0,a[0], nots);
    and and_1(and1,b[0], s);
    or or_1(o[0],and1, and0);
   
    and and_2(and2,a[1], nots);
    and and_3(and3,b[1], s);
    or or_2(o[1],and2, and3);
    
    and and_4(and4,a[2], nots);
    and and_5(and5,b[2], s);
    or or_3(o[2],and4, and5);
 
    and and_6(and6,a[3], nots);
    and and_7(and7,b[3], s);
    or or_4(o[3],and6, and7);
endmodule




module Mux_4x1_4bit(a, b, c, d, sel, f);
    input [4-1:0] a, b, c, d;
    input [2-1:0] sel;
    output [4-1:0] f;
    wire [3:0]mux_1,mux_2;
    
    Mux_2x1 m1(mux_1,a,b,sel[0]);
    Mux_2x1 m2(mux_2,c,d,sel[0]);
    Mux_2x1 m3(f,mux_1,mux_2,sel[1]);
    

endmodule
