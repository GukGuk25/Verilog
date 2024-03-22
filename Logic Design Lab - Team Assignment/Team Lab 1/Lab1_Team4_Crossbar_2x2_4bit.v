`timescale 1ns/1ps

module Crossbar_2x2_4bit(in1, in2, control, out1, out2);
    input [4-1:0] in1, in2;
    input control;
    output [4-1:0] out1, out2;
    
    wire negcontrol;
    not not1(negcontrol, control);
    
    wire [4-1:0]DmuxOutTopA, DmuxOutTopB, DmuxOutBotA, DmuxOutBotB;
    
    //dmux part
    Dmux_1x2_4bit TopDmux(in1, DmuxOutTopA, DmuxOutTopB, control);
    Dmux_1x2_4bit BotDmux(in2, DmuxOutBotA, DmuxOutBotB, negcontrol);
    
    //mux part
    Mux_2x1_4bit TopMux(out1, DmuxOutTopA, DmuxOutBotA, control);
    Mux_2x1_4bit BotMux(out2, DmuxOutTopB, DmuxOutBotB, negcontrol);
    
endmodule

module Dmux_1x2_4bit(in, a, b, sel);
    input [4-1:0] in;
    input sel;
    output [4-1:0] a,b;
    
    wire notsel;
    not notselwire(notsel, sel);
    
    and and_a0(a[0], in[0], notsel);
    and and_a1(a[1], in[1], notsel);
    and and_a2(a[2], in[2], notsel);
    and and_a3(a[3], in[3], notsel);
    
    and and_b0(b[0], in[0], sel);
    and and_b1(b[1], in[1], sel);
    and and_b2(b[2], in[2], sel);
    and and_b3(b[3], in[3], sel);
    
endmodule



module Mux_2x1_4bit(f, a, b, sel);
        input [4-1:0] a,b;
        input sel;
        output [4-1:0] f;
    
        wire selbar;
        wire [2-1:0]n1,n2,n3,n4;
    
        not notw(selbar, sel);
    
        and and0(n1[0], a[0], selbar);
        and and0a(n1[1], b[0], sel);
    
        and and1(n2[0], a[1], selbar);
        and and1a(n2[1], b[1], sel);    
    
        and and2(n3[0], a[2], selbar);
        and and2a(n3[1], b[2], sel);
    
        and and3(n4[0], a[3], selbar);
        and and3a(n4[1], b[3], sel);
    
        or or0(f[0], n1[0],n1[1]);
        or or1(f[1], n2[0],n2[1]);
        or or2(f[2], n3[0],n3[1]);
        or or3(f[3], n4[0],n4[1]);
endmodule
