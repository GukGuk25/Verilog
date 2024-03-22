`timescale 1ns/1ps

module AND_fromNand(a,b,out);
    input a,b;
    output out;
    wire nandout;

    nand first(nandout, a,b);
    nand final(out, nandout, nandout);

endmodule

module OR_fromNand(a,b,out);
    input a,b;
    output out;
    wire [2-1:0]nandout;

    nand top(nandout[0],a,a);
    nand bot(nandout[1],b,b);
    nand final(out,nandout[0],nandout[1]);
endmodule

module XOR_fromNand(a,b,out);
    input a,b;
    output out;
    wire first;
    wire [2-1:0] second;

    nand front(first,a,b);
    nand midtop(second[0], a, first);
    nand midbot(second[1], b, first);
    nand final(out, second[0], second[1]);

endmodule

module Majority(a, b, c, out);
    input a, b, c;
    output out;
    wire [3-1:0] nwire;
    wire orwire;

    AND_fromNand topand(a,b, nwire[0]);
    AND_fromNand midand(a,c, nwire[1]);
    OR_fromNand ortop(nwire[0], nwire[1], orwire);

    AND_fromNand botand(b,c, nwire[2]);
    OR_fromNand finalor(orwire, nwire[2], out);

endmodule

module Half_Adder(a, b, cout, sum);
    input a, b;
    output cout, sum;

    //carry
    AND_fromNand and1(a,b,cout);
    XOR_fromNand xor1(a,b,sum);

endmodule

module Full_Adder (a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;

    wire sum1,cout1, cout2, imm2,notcin;

    wire notmajortop;
    NOT_fromNand notcincin(cin, notcin);

    Majority MajorTop(a,b,cin, cout);
    NOT_fromNand notmajor(cout, notmajortop);

    Majority MajorBot(a,b,notcin, imm2);

    Majority LastMajor(imm2,cin, notmajortop, sum);

    //Half_Adder half1(a,b, cout1,sum1);
    //Half_Adder half2(sum1, cin, cout2,sum);

    //Majority Major(a,b,cin, cout);

    // AND_fromNand Generate_And(a,b,GEN);
    // XOR_fromNand abxor(a,b,imm);
    // AND_fromNand Propagate(imm,cin,PROP);

    //OR_fromNand or1(cout1, cout2, cout);

endmodule

module NOT_fromNand(a, out);
    input a;
    output out;
    nand final_nand(out,a,a);
endmodule

module BUFF_fromNand(a, out);
    input a;
    output out;
    wire imm;
    NOT_fromNand not1(a, imm);
    NOT_fromNand inv(imm, out);
endmodule


module Multiplier_4bit(a, b, p);
    input [4-1:0] a, b;
    output [8-1:0] p;

    //combinational multiplier.

    //b0
    wire [4-1:0] and0out, and1out, and2out, and3out;
    wire [2-1:0] FA_Tier0_Sum, FA_Tier0_Cout, HA_Tier0_Cout;
    wire [3-1:0] FA_Tier1_Sum, FA_Tier1_Cout, HA_Tier1_Cout;
    wire [3-1:0] FA_Tier2_Sum, FA_Tier2_Cout, HA_Tier2_Cout;
    wire HA_TIER0_Sum;
    AND_fromNand andb0[4-1:0] (a, b[0], and0out);
    AND_fromNand andb1[4-1:0] (a, b[1], and1out);
    AND_fromNand andb2[4-1:0] (a, b[2], and2out);
    AND_fromNand andb3[4-1:0] (a, b[3], and3out);


    //layer 0.
    BUFF_fromNand z0(and0out[0], p[0]);
    Half_Adder HA_T1_1(and0out[1], and1out[0], HA_Tier0_Cout[0], p[1]);
    Full_Adder FA_T1_1(and0out[2], and1out[1], HA_Tier0_Cout[0], FA_Tier0_Cout[0], FA_Tier0_Sum[0]);
    Full_Adder FA_T1_2(and0out[3], and1out[2], FA_Tier0_Cout[0], FA_Tier0_Cout[1], FA_Tier0_Sum[1]);
    Half_Adder HA_T1_2(FA_Tier0_Cout[1], and1out[3], HA_Tier0_Cout[1], HA_Tier0_Sum);

    //layer 1.
    Half_Adder HA_T2_1(and2out[0], FA_Tier0_Sum[0], HA_Tier1_Cout[0], p[2]);
    Full_Adder FA_T2_1(and2out[1], FA_Tier0_Sum[1], HA_Tier1_Cout[0], FA_Tier1_Cout[0], FA_Tier1_Sum[0]);
    Full_Adder FA_T2_2(and2out[2], HA_Tier0_Sum, FA_Tier1_Cout[0], FA_Tier1_Cout[1], FA_Tier1_Sum[1]);
    Full_Adder FA_T2_3(and2out[3], HA_Tier0_Cout[1], FA_Tier1_Cout[1], FA_Tier1_Cout[2], FA_Tier1_Sum[2]);

    //layer 2.
    Half_Adder HA_T3_1(and3out[0], FA_Tier1_Sum[0], HA_Tier2_Cout[0], p[3]);
    Full_Adder FA_T3_1(and3out[1], FA_Tier1_Sum[1], HA_Tier2_Cout[0], FA_Tier2_Cout[0], p[4]);
    Full_Adder FA_T3_2(and3out[2], FA_Tier1_Sum[2], FA_Tier2_Cout[0], FA_Tier2_Cout[1], p[5]);
    Full_Adder FA_T3_3(and3out[3], FA_Tier1_Cout[2], FA_Tier2_Cout[1], p[7], p[6]);

endmodule
