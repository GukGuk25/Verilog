`timescale 1ns/1ps

module Majority(a, b, c, out);
    input a, b, c;
    output out;
    wire and1, and2, and3, or1;
    
    nand_and and_1(and1, a, b);
    nand_and and_2(and2, a, c);
    nand_and and_3(and3, b, c);
    nand_or or_1(or1, and1, and2);
    nand_or or_2(out, or1, and3);
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