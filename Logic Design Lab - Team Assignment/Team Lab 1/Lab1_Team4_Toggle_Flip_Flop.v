`timescale 1ns/1ps

module Toggle_Flip_Flop(clk, q, t, rst_n);
    input clk;
    input t;
    input rst_n;
    output q;
    wire xor1, and1;
    
    myxor xor_1(xor1, q, t);
    and and_1(and1, xor1, rst_n);
    D_Flip_Flop DFF_1(clk, and1, q);

endmodule

module myxor(q, b, a); //we are not allowed to use xor :(
    input a,b;
    output q;
    wire and1, and2, nota, notb;
    
    not not_1(nota,a);
    not not_2(notb,b);
    and and_1(and1, a, notb);
    and and_2(and2, b, nota);
    or or_1(q, and1, and2);
    
endmodule


module D_Flip_Flop(clk, d, q); //this is 109006240's flip flop cuz we are doing this one in 109006240 laptops XD
    input clk;
    input d;
    output q;
    wire nclk, slaveq;
    not n_clk(nclk,clk);
    D_Latch masterlatch(nclk,d,slaveq);
    D_Latch slavelatch(clk,slaveq,q);
    
    //D_Latch test(clk,d,q);
endmodule

module D_Latch(e, d, q); //this latch is also 109006240's cuz we are doing it on 109006240 laptop
    input e;
    input d;
    output q;
    wire nand1, nand2, notd, notq;

    not not_1(notd,d);
    nand nand_1(nand1, d, e);
    nand nand_2(nand2, notd, e);
    nand nand_3(q, notq, nand1);
    nand nand_4(notq, q, nand2);

endmodule