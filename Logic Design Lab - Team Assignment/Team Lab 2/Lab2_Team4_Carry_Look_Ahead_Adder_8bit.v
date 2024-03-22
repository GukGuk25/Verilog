`timescale 1ns/1ps

module Carry_Look_Ahead_Adder_8bit(a, b, c0, s, c8);
    input [8-1:0] a, b;
    input c0;
    output [8-1:0] s;
    output c8;

    wire [5-1:0] firstC, secondC;

    //we need 8 FA for 8 bits
    Gen_Prop_Carry_Generator firstlookahead(a[3:0],b[3:0],c0,firstC);    
    Full_Adder FA_0(a[0], b[0], firstC[0],s[0]);
    Full_Adder FA_1(a[1], b[1], firstC[1],s[1]);
    Full_Adder FA_2(a[2], b[2], firstC[2],s[2]);
    Full_Adder FA_3(a[3], b[3], firstC[3],s[3]);

    Gen_Prop_Carry_Generator secondlookahead(a[7:4],b[7:4],firstC[4],secondC);
    
    Full_Adder FA_4(a[4], b[4], secondC[0],s[4]);
    Full_Adder FA_5(a[5], b[5], secondC[1],s[5]);
    Full_Adder FA_6(a[6], b[6], secondC[2],s[6]);
    Full_Adder FA_7(a[7], b[7], secondC[3],s[7]);

    BUFF_fromNand finalbit(secondC[4], c8);


    // Full_Adder FA_1(a[1], b[1], carry[0], , s[1], gen[1], prop[1]);
    // Full_Adder FA_2(a[2], b[2], carry[1], , s[2], gen[2], prop[2]);
    // Full_Adder FA_3(a[3], b[3], carry[2], , s[3], gen[3], prop[3]);
    // Full_Adder FA_4(a[4], b[4], carry[3], , s[4], gen[4], prop[4]);
    // Full_Adder FA_5(a[5], b[5], carry[4], , s[5], gen[5], prop[5]);
    // Full_Adder FA_6(a[6], b[6], carry[5], , s[6], gen[6], prop[6]);
    // Full_Adder FA_7(a[7], b[7], carry[6], , s[7], gen[7], prop[7]);


endmodule

module Gen_Prop_Carry_Generator(a, b, cin,C);
    input [4-1:0]a,b;
    input cin;
    output [5-1:0] C;
    wire [4-1:0] GEN, PRO, pro_and_C;

    AND_fromNand gen0(a[0], b[0], GEN[0]);
    XOR_fromNand pro0(a[0], b[0], PRO[0]);
    AND_fromNand gen1(a[1], b[1], GEN[1]);
    XOR_fromNand pro1(a[1], b[1], PRO[1]);
    AND_fromNand gen2(a[2], b[2], GEN[2]);
    XOR_fromNand pro2(a[2], b[2], PRO[2]);
    AND_fromNand gen3(a[3], b[3], GEN[3]);
    XOR_fromNand pro3(a[3], b[3], PRO[3]);

    //Ci = G + P.Ci-1.
    BUFF_fromNand c0(cin, C[0]);
    AND_fromNand and0(PRO[0], C[0], pro_and_C[0]);
    OR_fromNand c1(GEN[0], pro_and_C[0], C[1]);
    
    AND_fromNand and1(PRO[1], C[1], pro_and_C[1]);
    OR_fromNand c2(GEN[1], pro_and_C[1], C[2]);

    AND_fromNand and2(PRO[2], C[2], pro_and_C[2]);
    OR_fromNand c3(GEN[2], pro_and_C[2], C[3]);

    AND_fromNand and3(PRO[3], C[3], pro_and_C[3]);
    OR_fromNand c4(GEN[3], pro_and_C[3], C[4]);
    

endmodule

module Full_Adder (a, b, cin, sum);
    input a, b, cin;
    output sum;

    wire sum1,cout1, cout2, imm2,notcin;

    wire notmajortop;
    NOT_fromNand notcincin(cin, notcin);

    Majority MajorTop(a,b,cin, cout);
    NOT_fromNand notmajor(cout, notmajortop);

    Majority MajorBot(a,b,notcin, imm2);

    Majority LastMajor(imm2,cin, notmajortop, sum);

endmodule

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
