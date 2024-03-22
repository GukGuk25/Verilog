`timescale 1ns/1ps

module D_Flip_Flop(clk, d, q);
    input clk;
    input d;
    output q;
    wire nclk, slaveq;
    not n_clk(nclk,clk);
    D_Latch masterlatch(nclk,d,slaveq);
    D_Latch slavelatch(clk,slaveq,q);
    
    //D_Latch test(clk,d,q);
endmodule

module D_Latch(e, d, q);
    input e;
    input d;
    output q;
    wire nand1, nand2, nand3, nand4, nand5, notd, notdfq, notq, tq; //i tried alot of thing lol
    //assign nand4=1; //nand2 need a starting value
    //assign nand3=0; //nand3 need a starting value
        
    //not not_dfq(notdfq, D_Flip_Flop_t.q);
    not not_1(notd,d);
    //not not_2(notq,tq);
    nand nand_1(nand1, d, e);
    nand nand_2(nand2, notd, e);
    nand nand_3(q, notq, nand1);
    nand nand_4(notq, q, nand2);
    /*
    nand nand_1(nand1, d, e);
    nand nand_2(nand2, notd, e);
    nand nand_3(nand4, q, nand2);
    nand nand_4(q, nand1, notq);*/
endmodule