`timescale 1ns/1ps

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

module Dmux_1x4_4bit(in, a, b, c, d, sel);
     input [4-1:0] in;
     input [2-1:0] sel;
     output [4-1:0] a, b, c, d;

     wire [4-1:0] fronttop, frontbot;
     Dmux_1x2_4bit front(in, fronttop, frontbot, sel[1]);
     Dmux_1x2_4bit top(fronttop, a, b, sel[0]);
     Dmux_1x2_4bit bot(frontbot, c, d, sel[0]);
endmodule
