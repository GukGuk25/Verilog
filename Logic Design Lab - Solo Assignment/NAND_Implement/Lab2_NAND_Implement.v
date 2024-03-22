`timescale 1ns/1ps

module NAND_Implement (a, b, sel, out);
    input a, b;
    input [2:0] sel;
    output out;
    wire nandand, nandor, nandnor, nandxor, nandxnor, nandnot, nands;
    nand nand_1(nands, a, b);
    nand_and nandand_1(nandand, a, b);
    nand_or nandor_1(nandor, a, b);
    nand_nor nandnor_1(nandnor, a, b);
    nand_xor nandxor_1(nandxor, a, b);
    nand_xnor nandxnor_1(nandxnor, a, b);
    nand_not nandnot_1(nandnot, a);
    
    mux8x1_1bit mux_1(out, nands, nandxor, nandor, nandnot, nandand, nandxnor, nandnor, nandnot, sel);
endmodule

module mux2x1_1bit(out,a, b, sel);
    input a, b, sel;
    output out;
    wire notsel, and1, and2;
    
    nand_not not_sel(notsel, sel);
    nand_and and_1(and1, a, notsel);
    nand_and and_2(and2, b, sel);
    nand_or or_1(out, and1, and2);
    
endmodule

module mux4x1_1bit(out, a, b, c, d, sel);
    input a, b, c ,d;
    input[1:0] sel;
    output out;
    wire out1, out2;
    
    mux2x1_1bit mux2x1_1(out1, a, b, sel[1]);
    mux2x1_1bit mux2x1_2(out2, c, d, sel[1]);
    mux2x1_1bit mux2x1_3(out, out1, out2, sel[0]);
endmodule

module mux8x1_1bit(out, a, b, c, d, e, f, g, h, sel);
    input a, b, c, d, e, f, g, h;
    input[2:0] sel;
    output out;
    wire mux1, mux2;
    mux4x1_1bit mux_1(mux1, a, b, c, d, sel[2:1]);
    mux4x1_1bit mux_2(mux2, e, f, g, h, sel[2:1]);
    mux2x1_1bit mux_3(out, mux1, mux2, sel[0]);
    
    
endmodule

module nand_and (out, a, b);
    input a, b;
    output out;
    wire nand1;
    
    nand nand_1(nand1, a, b);
    nand nand_2(out, nand1, nand1);
    
endmodule

module nand_or (out, a, b);
    input a, b;
    output out;
    wire nanda, nandb;
    
    nand nand_a(nanda, a, a);
    nand nand_b(nandb, b, b);
    nand nand_out(out, nanda, nandb);
    
endmodule

module nand_nor (out, a, b);
    input a, b;
    output out;
    wire nanda, nandb, nand1;
    
    nand nand_a(nanda, a, a);
    nand nand_b(nandb, b, b);
    nand nand_1(nand1, nanda, nandb);
    nand nand_2(out, nand1, nand1);
    

endmodule

module nand_xor (out, a, b);
    input a, b;
    output out;
    wire nand1, nand2, nand3;
    nand nand_1(nand1, a, b);
    nand nand_2(nand2, nand1, a);
    nand nand_3(nand3, nand1, b);
    nand nand_4(out, nand2, nand3);

endmodule

module nand_xnor (out, a, b);
    input a, b;
    output out;
    wire nand1, nanda, nandb, nand2;
    
    nand nand_1(nand1, a, b);
    nand nand_a(nanda, a, a);
    nand nand_b(nandb, b, b);
    nand nand_2(nand2, nanda, nandb);
    nand nand_3(out, nand1, nand2);
    
endmodule

module nand_not (out, a);
    input a;
    output out;
    
    nand nand_1(out, a, a);
    
endmodule