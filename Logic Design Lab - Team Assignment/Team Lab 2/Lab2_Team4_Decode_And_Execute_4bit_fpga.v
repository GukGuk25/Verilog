`timescale 1ns/1ps
module Decode_And_Execute(rs, rt, sel, anode, cathode);
    input [4-1:0] rs, rt;
    input [3-1:0] sel;
    output [3:0]anode;
    output [6:0] cathode;
    wire [4-1:0] rd;

    wire [4-1:0] subans,addans,orans,andans,rshiftans,lshiftans,ltans,eqans;
    wire more, equal, less, imm_more_equal;

    magnitude_4bit mag(rs,rt, less, equal);
    //if not more and not equal, then it is less.
    // (A'B') -> (A+B)'
    // uni_or or_less(more, equal, imm_more_equal);
    // uni_not lessgate(imm_more_equal, less);

    //prepare for sub
    wire [4-1:0] rtneg;
    second_complement negative_rt(rt, rtneg);
    special_add substraction(rs, rtneg, subans);

    //prepare for addition
    special_add addition(rs, rt, addans);

    //prepare for bitwise or
    uni_or bitwise_or[4-1:0](rs,rt,orans);
    // uni_or bitwise_or0(rs[0], rt[0], orans[0]);
    // uni_or bitwise_or1(rs[1], rt[1], orans[1]);
    // uni_or bitwise_or2(rs[2], rt[2], orans[2]);
    // uni_or bitwise_or3(rs[3], rt[3], orans[3]);

    //prepare for bitwise and
    uni_and bitwise_and[4-1:0](rs,rt,andans);
    // uni_or bitwise_and0(rs[0], rt[0], andans[0]);
    // uni_or bitwise_and1(rs[1], rt[1], andans[1]);
    // uni_or bitwise_and2(rs[2], rt[2], andans[2]);
    // uni_or bitwise_and3(rs[3], rt[3], andans[3]);

    //prepare for rshift
    uni_buffer rshift0(rt[3], rshiftans[3]);
    uni_buffer rshift1(rt[3], rshiftans[2]);
    uni_buffer rshift2(rt[2], rshiftans[1]);
    uni_buffer rshift3(rt[1], rshiftans[0]);

    //prepare for lshift
    uni_buffer lshift0(rs[2], lshiftans[3]);
    uni_buffer lshift1(rs[1], lshiftans[2]);
    uni_buffer lshift2(rs[0], lshiftans[1]);
    uni_buffer lshift3(rs[3], lshiftans[0]);

    //prepare lt
    uni_buffer lt0(1'b1, ltans[3]);
    uni_buffer lt1(1'b0, ltans[2]);
    uni_buffer lt2(1'b1, ltans[1]);
    uni_buffer lt3(less, ltans[0]);

    //prepare eq

    uni_buffer eq0(1'b1, eqans[3]);
    uni_buffer eq1(1'b1, eqans[2]);
    uni_buffer eq2(1'b1, eqans[1]);
    uni_buffer eq3(equal, eqans[0]);

    uni_mux8x1 selector(
        subans,addans,orans,andans,rshiftans,lshiftans,ltans,eqans, sel, rd
    );
    wire[6:0] cathode;
    wire[3:0] anode;
    setdisp disp_1(rd, anode, cathode);

    
endmodule


module setdisp(rd, anode, cathode);
    input[3:0] rd;
    output[6:0] cathode;
    output[3:0] anode;
    
    wire[3:0] nrd;
    wire or1, or2, or3, or4, or5, or6, or7, or8, or9, or10, or11, or12, or13, or14, or15, or16, or17, or18, or19, or20;
    wire ab, nanb, anb, nab, cd, ncnd, ncd, cnd; // AB, CD combination
    wire abcd, nanbcd, anbcd, nabcd, abncnd, nanbncnd, anbncnd, nabncnd, abncd, nanbncd, anbncd, nabncd, abcnd, nanbcnd, anbcnd, nabcnd; //ABCD combination
    
    
    uni_buffer buff1(1, anode[3]); //W4
    uni_buffer buff2(1, anode[2]); //V4
    uni_buffer buff3(1, anode[1]); //U4
    uni_buffer buff4(0, anode[0]); //U2
    
    uni_not not_rd0(rd[0],nrd[0]);
    uni_not not_rd1(rd[1],nrd[1]);
    uni_not not_rd2(rd[2],nrd[2]);
    uni_not not_rd3(rd[3],nrd[3]);
    
    uni_and and_ab(rd[3], rd[2], ab); //AB
    uni_and and_nanb(nrd[3], nrd[2], nanb); //A'B'
    uni_and and_anb(rd[3], nrd[2], anb); //AB'
    uni_and and_nab(nrd[3], rd[2], nab); //A'B
    
    uni_and and_cd(rd[1], rd[0], cd); //CD
    uni_and and_ncnd(nrd[1], nrd[0], ncnd); //C'D'
    uni_and and_ncd(nrd[1], rd[0], ncd); //C'D
    uni_and and_cnd(rd[1], nrd[0], cnd); //CD'
    
    uni_and and_abcd(ab, cd, abcd); //ABCD
    uni_and and_nanbcd(nanb, cd, nanbcd); //A'B'CD
    uni_and and_anbcd(anb, cd, anbcd); //AB'CD
    uni_and and_nabcd(nab, cd, nabcd); //A'BCD
    
    uni_and and_abncnd(ab, ncnd, abncnd); //ABC'D'
    uni_and and_nanbncnd(nanb, ncnd, nanbncnd); //A'B'C'D'
    uni_and and_anbncnd(anb, ncnd, anbncnd); //AB'C'D'
    uni_and and_nabncnd(nab, ncnd, nabncnd); //A'BC'D'
    
    uni_and and_abncd(ab, ncd, abncd); //ABC'D
    uni_and and_nanbncd(nanb, ncd, nanbncd); //A'B'C'D
    uni_and and_anbncd(anb, ncd, anbncd); //AB'C'D
    uni_and and_nabncd(nab, ncd, nabncd); //A'BC'D
    
    uni_and and_abcnd(ab, cnd, abcnd); //ABCD'
    uni_and and_nanbcnd(nanb, cnd, nanbcnd); //A'B'CD'
    uni_and and_anbcnd(anb, cnd, anbcnd); //AB'CD'
    uni_and and_nabcnd(nab, cnd, nabcnd); //A'BCD'
    
    //[6]atas tengah W7
    uni_or or_1(nanbncd, nabncnd, or1);
    uni_or or_2(anbcd, abncd, or2);
    uni_or or_cathode6(or1, or2, cathode[6]);
    
    //[5]kanan atas W6
    uni_or or_3(nabncd, nabcnd, or3);
    uni_or or_4(anbcd, abncnd, or4);
    uni_or or_5(abcnd, abcd, or5);
    uni_or or_6(or3, or4, or6);
    uni_or or_cathode5(or5, or6, cathode[5]);
    
    //[4]kanan bawah U8
    uni_or or_7(nanbcnd, abncnd, or7);
    uni_or or_8(abcnd, abcd, or8);
    uni_or or_cathode4(or7, or8, cathode[4]);
    
    //[3]bawah tengah V8
    uni_or or_9(nanbncd, nabncnd, or9);
    uni_or or_10(nabcd, abcd, or10);
    uni_or or_cathode3(or9, or10, cathode[3]);
    
    //[2] kiri bawah U5
    uni_or or_11(nanbncd, nanbcd, or11);
    uni_or or_12(nabncnd, nabncd, or12);
    uni_or or_13(nabcd, anbncd, or13);
    uni_or or_14(or11, or12, or14);
    uni_or or_cathode2(or13, or14, cathode[2]);
    
    //[1] kiri atas V5
    uni_or or_15(nanbncd, nanbcnd, or15);
    uni_or or_16(nanbcd, nabcd, or16);
    uni_or or_17(anbcnd, abncd, or17);
    uni_or or_18(or15, or16, or18);
    uni_or or_cathode1(or17, or18, cathode[1]);
    
    //[0] tengah U7
    uni_or or_19(nanbncnd, nanbncd, or19);
    uni_or or_20(nabcd, abncnd, or20);
    uni_or or_cathode0(or19, or20, cathode[0]);
    
endmodule

module Universal_Gate(a, b, out);
    input a,b;
    output out;
    wire bb;
    not not1(bb, b);
    and(out, a,bb);
endmodule

module uni_and(a,b,out);
    input a,b;
    output out;
    wire uniout1;

    Universal_Gate unifront(a,b,uniout1);
    Universal_Gate unilast(a, uniout1, out);
endmodule

module uni_buffer(a, out);
    input a;
    output out;
    wire buffer;

    Universal_Gate first(a,a,buffer);
    Universal_Gate last(a, buffer, out);
endmodule

module uni_not(a, out);
    input a;
    output out;
    wire buffertop, dummyout, bufferbot;

    Universal_Gate top(a,a,buffertop);
    Universal_Gate botfirst(1'b1, a, dummyout);

    Universal_Gate afterbot(dummyout, 1'b0, bufferbot);

    Universal_Gate finalgate(bufferbot, buffertop, out);
endmodule

module uni_or(a,b,out);
    input a,b;
    output out;
    //make a' first.

    wire nota, notb, andout;

    uni_not firstnot(a, nota);
    uni_not secondnot(b, notb);

    uni_and andgate(nota,notb,andout);

    uni_not final(andout, out);
endmodule

module uni_xor(a,b,out);
    input a,b;
    output out;
    

    wire nota, notb, compound1, compound2;
    
    uni_not firstnot(a, nota);
    uni_not secondnot(b, notb);

    uni_and firstand(a, notb, compound1); //AB'
    uni_and secondand(nota, b, compound2); //A'B

    uni_or finalgate(compound1, compound2, out);

endmodule

module Majority(a, b, c, out);
    input a, b, c;
    output out;
    wire and1, and2, and3, or1;
    
    uni_and and_1(a, b, and1);
    uni_and and_2(a, c, and2);
    uni_and and_3(b, c, and3);
    uni_or or_1(and1, and2, or1);
    uni_or or_2(or1, and3, out);
endmodule

module Full_Adder (a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;

    wire sum1,cout1, cout2, imm2,notcin;

    wire notmajortop;
    uni_not notcincin(cin, notcin);

    Majority MajorTop(a,b,cin, cout);
    uni_not notmajor(cout, notmajortop);

    Majority MajorBot(a,b,notcin, imm2);

    Majority LastMajor(imm2,cin, notmajortop, sum);

endmodule

//add module
module special_add(rs, rt, rd);
    input [4-1:0] rs, rt;
    output [4-1:0] rd;

    wire cin1, cin2, cin3, cin4;
    
    Full_Adder adder_0(rs[0],rt[0], 1'b0, cin1, rd[0]);
    Full_Adder adder_1(rs[1],rt[1], cin1, cin2, rd[1]);
    Full_Adder adder_2(rs[2],rt[2], cin2, cin3, rd[2]);
    Full_Adder adder_3(rs[3],rt[3], cin3, cin4, rd[3]);

endmodule

module second_complement(rs, rd);
    input [4-1:0] rs;
    output [4-1:0] rd;
    wire [4-1:0] temp;

    uni_not not0(rs[0], temp[0]);
    uni_not not1(rs[1], temp[1]);
    uni_not not2(rs[2], temp[2]);
    uni_not not3(rs[3], temp[3]);

    special_add final(temp, 4'b0001, rd);

endmodule

module uni_mux2x1(a,b, sel,out);
    input sel;
    input [4-1:0] a,b;
    output [4-1:0]out;
    wire notsel;
    wire [4-1:0] inter1, inter2;
    

    uni_not not1(sel, notsel);

    uni_and andfirst1(a[0], notsel, inter1[0]);
    uni_and andfirst2(a[1], notsel, inter1[1]);
    uni_and andfirst3(a[2], notsel, inter1[2]);
    uni_and andfirst4(a[3], notsel, inter1[3]);

    uni_and andsecond1(b[0], sel, inter2[0]);
    uni_and andsecond2(b[1], sel, inter2[1]);
    uni_and andsecond3(b[2], sel, inter2[2]);
    uni_and andsecond4(b[3], sel, inter2[3]);

    uni_or finalor1(inter1[0], inter2[0], out[0]);
    uni_or finalor2(inter1[1], inter2[1], out[1]);
    uni_or finalor3(inter1[2], inter2[2], out[2]);
    uni_or finalor4(inter1[3], inter2[3], out[3]);
endmodule

module uni_mux4x1(a,b,c,d,sel,out);
    input [4-1:0]a,b,c,d;
    input [2-1:0] sel;
    output [4-1:0]out;

    wire [4-1:0] topmuxout, botmuxout;

    //NOT_fromNand(sel[0], notsel[0]);
    //NOT_fromNand(sel[1], notsel[1]);

    uni_mux2x1 topmux(a,b, sel[1], topmuxout);
    uni_mux2x1 botmux(c,d, sel[1], botmuxout);
    uni_mux2x1 finalmux(topmuxout, botmuxout, sel[0], out);
endmodule

module uni_mux8x1(a,b,c,d,e,f,g,h,sel,out);
    input [4-1:0]a,b,c,d,e,f,g,h;
    input [3-1:0]sel;
    output [4-1:0]out;

    //wire [3-1:0] notsel;
    wire [4-1:0] topmux, botmux;
    //make 4 4 2.

    uni_mux4x1 top4x1(a,e,c,g, sel[2:1], topmux);
    uni_mux4x1 bot4x1(b,f,d,h, sel[2:1], botmux);
    uni_mux2x1 final (topmux, botmux, sel[0], out);

endmodule

module magnitude_4bit(a,b,more,equal);
    input [4-1:0] a,b;
    output more,equal;

    wire [4-1:0]xorout, bbar,notxor;
    wire [8:0] wirecluster;
    wire imm,imm2, andout, moreimm1, moreimm2;
    
    uni_not not_b[4-1:0] (a, bbar);

    uni_xor xor3(a[3],b[3],xorout[3]);
    uni_xor xor2(a[2],b[2],xorout[2]);
    uni_xor xor1(a[1],b[1],xorout[1]);
    uni_xor xor0(a[0],b[0],xorout[0]);

    uni_not not_xor[4-1:0] (xorout, notxor);
    uni_and and0(notxor[0], notxor[1], imm);
    uni_and and1(notxor[2], notxor[3], imm2);
    uni_and and2(imm,imm2, equal);

    //a<b.
    //top
    uni_and andmore3(b[3], bbar[3], andout);
    //second
    uni_and andmore2(b[2], bbar[2], wirecluster[0]);
    uni_and andmore2child(wirecluster[0], notxor[3], wirecluster[1]);
    //third
    uni_and andmore1(b[1], bbar[1], wirecluster[2]);
    uni_and andmore1child(notxor[3], notxor[2], wirecluster[3]);
    uni_and andmore1child_child(wirecluster[2], wirecluster[3], wirecluster[4]);
    //final
    uni_and andmore0(b[0], bbar[0], wirecluster[5]);
    uni_and andmore0child(notxor[3], notxor[2], wirecluster[6]);
    uni_and andmore0child_xor(notxor[1], wirecluster[6], wirecluster[7]);
    uni_and andmore0child_child(wirecluster[5], wirecluster[7], wirecluster[8]);

    //less output
    uni_or outputand(andout, wirecluster[1], moreimm1);
    uni_or outputand2(wirecluster[4], wirecluster[8], moreimm2);
    uni_or finalmore(moreimm1, moreimm2, more);


endmodule


