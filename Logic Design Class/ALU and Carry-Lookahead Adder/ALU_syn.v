/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri Apr 30 14:48:27 2021
/////////////////////////////////////////////////////////////


module CLA_4bit_0 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_9 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_10 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_11 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module Adder_16bit_0 ( A, B, Cin, S, Cout );
  input [15:0] A;
  input [15:0] B;
  output [15:0] S;
  input Cin;
  output Cout;
  wire   C4, C8, C12;

  CLA_4bit_0 cla0 ( .A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C4)
         );
  CLA_4bit_11 cla1 ( .A(A[7:4]), .B(B[7:4]), .Cin(C4), .S(S[7:4]), .Cout(C8)
         );
  CLA_4bit_10 cla2 ( .A(A[11:8]), .B(B[11:8]), .Cin(C8), .S(S[11:8]), .Cout(
        C12) );
  CLA_4bit_9 cla3 ( .A(A[15:12]), .B(B[15:12]), .Cin(C12), .S(S[15:12]), 
        .Cout(Cout) );
endmodule


module CLA_4bit_1 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_2 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_3 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_4 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module Adder_16bit_1 ( A, B, Cin, S, Cout );
  input [15:0] A;
  input [15:0] B;
  output [15:0] S;
  input Cin;
  output Cout;
  wire   C4, C8, C12;

  CLA_4bit_4 cla0 ( .A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C4)
         );
  CLA_4bit_3 cla1 ( .A(A[7:4]), .B(B[7:4]), .Cin(C4), .S(S[7:4]), .Cout(C8) );
  CLA_4bit_2 cla2 ( .A(A[11:8]), .B(B[11:8]), .Cin(C8), .S(S[11:8]), .Cout(C12) );
  CLA_4bit_1 cla3 ( .A(A[15:12]), .B(B[15:12]), .Cin(C12), .S(S[15:12]), 
        .Cout(Cout) );
endmodule


module CLA_4bit_5 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_6 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_7 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module CLA_4bit_8 ( A, B, Cin, S, Cout );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18;

  XOR2X1 U1 ( .A(n10), .B(n11), .Y(S[3]) );
  XOR2X1 U2 ( .A(n12), .B(n13), .Y(S[2]) );
  XOR2X1 U3 ( .A(n14), .B(n15), .Y(S[1]) );
  XOR2X1 U4 ( .A(Cin), .B(n16), .Y(S[0]) );
  OAI2BB2XL U5 ( .B0(n11), .B1(n10), .A0N(B[3]), .A1N(A[3]), .Y(Cout) );
  XNOR2X1 U6 ( .A(A[3]), .B(B[3]), .Y(n10) );
  OA21XL U7 ( .A0(n13), .A1(n12), .B0(n17), .Y(n11) );
  OAI21XL U8 ( .A0(B[2]), .A1(A[2]), .B0(n17), .Y(n12) );
  NAND2X1 U9 ( .A(B[2]), .B(A[2]), .Y(n17) );
  OA21XL U10 ( .A0(n15), .A1(n14), .B0(n18), .Y(n13) );
  OAI21XL U11 ( .A0(B[1]), .A1(A[1]), .B0(n18), .Y(n14) );
  NAND2X1 U12 ( .A(B[1]), .B(A[1]), .Y(n18) );
  AOI22X1 U13 ( .A0(n16), .A1(Cin), .B0(A[0]), .B1(B[0]), .Y(n15) );
  XOR2X1 U14 ( .A(A[0]), .B(B[0]), .Y(n16) );
endmodule


module Adder_16bit_2 ( A, B, Cin, S, Cout );
  input [15:0] A;
  input [15:0] B;
  output [15:0] S;
  input Cin;
  output Cout;
  wire   C4, C8, C12;

  CLA_4bit_8 cla0 ( .A(A[3:0]), .B(B[3:0]), .Cin(Cin), .S(S[3:0]), .Cout(C4)
         );
  CLA_4bit_7 cla1 ( .A(A[7:4]), .B(B[7:4]), .Cin(C4), .S(S[7:4]), .Cout(C8) );
  CLA_4bit_6 cla2 ( .A(A[11:8]), .B(B[11:8]), .Cin(C8), .S(S[11:8]), .Cout(C12) );
  CLA_4bit_5 cla3 ( .A(A[15:12]), .B(B[15:12]), .Cin(C12), .S(S[15:12]), 
        .Cout(Cout) );
endmodule


module ALU ( A, B, Cin, Mode, Y, Cout, Overflow );
  input [15:0] A;
  input [15:0] B;
  input [3:0] Mode;
  output [15:0] Y;
  input Cin;
  output Cout, Overflow;
  wire   Cout4, Cout5t, Cout5, N375, N376, N377, N378, N379, N380, N381, N382,
         N383, N384, N385, N386, N387, N388, N389, N390, N391, N392, N393,
         N394, n460, n461, n462, n463, n464, n465, n466, n467, n468, n469,
         n470, n471, n472, n473, n474, n475, n635, n636, n637, n638, n639,
         n640, n641, n642, n643, n644, n645, n646, n647, n648, n649, n650,
         n651, n652, n653, n654, n655, n656, n657, n658, n659, n660, n661,
         n662, n663, n664, n665, n666, n667, n668, n669, n670, n671, n672,
         n673, n674, n675, n676, n677, n678, n679, n680, n681, n682, n683,
         n684, n685, n686, n687, n688, n689, n690, n691, n692, n693, n694,
         n695, n696, n697, n698, n699, n700, n701, n702, n703, n704, n705,
         n706, n707, n708, n709, n710, n711, n712, n713, n714, n715, n716,
         n717, n718, n719, n720, n721, n722, n723, n724, n725, n726, n727,
         n728, n729, n730, n731, n732, n733, n734, n735, n736, n737, n738,
         n739, n740, n741, n742, n743, n744, n745, n746, n747, n748, n749,
         n750, n751, n752, n753, n754, n755, n756, n757, n758, n759, n760,
         n761, n762, n763, n764, n765, n766, n767, n768, n769, n770, n771,
         n772, n773, n774, n775, n776, n777, n778, n779, n780, n781, n782,
         n783, n784, n785, n786, n787, n788, n789, n790, n791, n792, n793,
         n794, n795, n796, n797, n798, n799, n800, n801, n802, n803, n804,
         n805, n806, n807, n808, n809, n810, n811, n812, n813, n814, n815,
         n816, n817, n818, n819, n820;
  wire   [15:0] Yout4;
  wire   [15:0] Yout5t;
  wire   [15:0] Yout5;

  Adder_16bit_0 adder1 ( .A(A), .B(B), .Cin(Cin), .S(Yout4), .Cout(Cout4) );
  Adder_16bit_2 adder2 ( .A({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1}), .B({n460, n461, n462, 
        n463, n464, n465, n466, n467, n468, n469, n470, n471, n472, n473, n474, 
        n475}), .Cin(Cin), .S(Yout5t), .Cout(Cout5t) );
  Adder_16bit_1 adder3 ( .A(Yout5t), .B(A), .Cin(Cout5t), .S(Yout5), .Cout(
        Cout5) );
  TLATX1 Cout_reg ( .G(N392), .D(N393), .Q(Cout) );
  TLATX1 Overflow_reg ( .G(N392), .D(N394), .Q(Overflow) );
  TLATXL \Y_reg[15]  ( .G(N375), .D(N391), .Q(Y[15]) );
  TLATXL \Y_reg[14]  ( .G(N375), .D(N390), .Q(Y[14]) );
  TLATXL \Y_reg[13]  ( .G(N375), .D(N389), .Q(Y[13]) );
  TLATX1 \Y_reg[12]  ( .G(N375), .D(N388), .Q(Y[12]) );
  TLATX1 \Y_reg[11]  ( .G(N375), .D(N387), .Q(Y[11]) );
  TLATX1 \Y_reg[10]  ( .G(N375), .D(N386), .Q(Y[10]) );
  TLATX1 \Y_reg[9]  ( .G(N375), .D(N385), .Q(Y[9]) );
  TLATX1 \Y_reg[8]  ( .G(N375), .D(N384), .Q(Y[8]) );
  TLATX1 \Y_reg[7]  ( .G(N375), .D(N383), .Q(Y[7]) );
  TLATX1 \Y_reg[6]  ( .G(N375), .D(N382), .Q(Y[6]) );
  TLATX1 \Y_reg[5]  ( .G(N375), .D(N381), .Q(Y[5]) );
  TLATX1 \Y_reg[4]  ( .G(N375), .D(N380), .Q(Y[4]) );
  TLATX1 \Y_reg[3]  ( .G(N375), .D(N379), .Q(Y[3]) );
  TLATX1 \Y_reg[2]  ( .G(N375), .D(N378), .Q(Y[2]) );
  TLATX1 \Y_reg[1]  ( .G(N375), .D(N377), .Q(Y[1]) );
  TLATX1 \Y_reg[0]  ( .G(N375), .D(N376), .Q(Y[0]) );
  CLKINVX1 U439 ( .A(B[0]), .Y(n475) );
  CLKINVX1 U440 ( .A(B[2]), .Y(n473) );
  CLKINVX1 U441 ( .A(B[4]), .Y(n471) );
  CLKINVX1 U442 ( .A(B[5]), .Y(n470) );
  CLKINVX1 U443 ( .A(B[6]), .Y(n469) );
  CLKINVX1 U444 ( .A(B[7]), .Y(n468) );
  CLKINVX1 U445 ( .A(B[8]), .Y(n467) );
  CLKINVX1 U446 ( .A(B[9]), .Y(n466) );
  CLKINVX1 U447 ( .A(B[10]), .Y(n465) );
  CLKINVX1 U448 ( .A(B[11]), .Y(n464) );
  CLKINVX1 U449 ( .A(B[12]), .Y(n463) );
  CLKINVX1 U450 ( .A(B[13]), .Y(n462) );
  CLKINVX1 U451 ( .A(B[14]), .Y(n461) );
  CLKINVX1 U452 ( .A(B[15]), .Y(n460) );
  MX4X1 U453 ( .A(n635), .B(n636), .C(n637), .D(n638), .S0(B[15]), .S1(A[15]), 
        .Y(N394) );
  NOR2X1 U454 ( .A(Yout4[15]), .B(n639), .Y(n638) );
  NOR2X1 U455 ( .A(Yout5[15]), .B(n640), .Y(n637) );
  NOR2BX1 U456 ( .AN(Yout5[15]), .B(n640), .Y(n636) );
  NOR2BX1 U457 ( .AN(Yout4[15]), .B(n639), .Y(n635) );
  AO22X1 U458 ( .A0(Cout4), .A1(n641), .B0(Cout5), .B1(n642), .Y(N393) );
  OAI211X1 U459 ( .A0(Mode[0]), .A1(n643), .B0(n640), .C0(n639), .Y(N392) );
  CLKINVX1 U460 ( .A(n641), .Y(n639) );
  CLKINVX1 U461 ( .A(n642), .Y(n640) );
  NAND4X1 U462 ( .A(n644), .B(n645), .C(n646), .D(n647), .Y(N391) );
  AOI221XL U463 ( .A0(Yout5[15]), .A1(n642), .B0(Yout4[15]), .B1(n641), .C0(
        n648), .Y(n647) );
  CLKINVX1 U464 ( .A(n649), .Y(n648) );
  AOI32X1 U465 ( .A0(A[0]), .A1(Mode[0]), .A2(n650), .B0(n651), .B1(n652), .Y(
        n649) );
  MX3XL U466 ( .A(n653), .B(n654), .C(n655), .S0(A[15]), .S1(B[15]), .Y(n646)
         );
  NOR2X1 U467 ( .A(n656), .B(n657), .Y(n655) );
  MXI2X1 U468 ( .A(n654), .B(n658), .S0(A[15]), .Y(n657) );
  NAND2X1 U469 ( .A(A[14]), .B(n659), .Y(n645) );
  MXI2X1 U470 ( .A(n660), .B(n661), .S0(A[15]), .Y(n644) );
  NAND4X1 U471 ( .A(n662), .B(n663), .C(n664), .D(n665), .Y(N390) );
  AOI221XL U472 ( .A0(n666), .A1(n652), .B0(Yout5[14]), .B1(n642), .C0(n667), 
        .Y(n665) );
  AO22X1 U473 ( .A0(A[15]), .A1(n650), .B0(Yout4[14]), .B1(n641), .Y(n667) );
  MX3XL U474 ( .A(n653), .B(n654), .C(n668), .S0(A[14]), .S1(B[14]), .Y(n664)
         );
  NOR2X1 U475 ( .A(n656), .B(n669), .Y(n668) );
  MXI2X1 U476 ( .A(n654), .B(n658), .S0(A[14]), .Y(n669) );
  NAND2X1 U477 ( .A(A[13]), .B(n659), .Y(n663) );
  MXI2X1 U478 ( .A(n660), .B(n661), .S0(A[14]), .Y(n662) );
  NAND4X1 U479 ( .A(n670), .B(n671), .C(n672), .D(n673), .Y(N389) );
  AOI221XL U480 ( .A0(n674), .A1(n652), .B0(Yout5[13]), .B1(n642), .C0(n675), 
        .Y(n673) );
  AO22X1 U481 ( .A0(n650), .A1(A[14]), .B0(Yout4[13]), .B1(n641), .Y(n675) );
  MX3XL U482 ( .A(n653), .B(n654), .C(n676), .S0(A[13]), .S1(B[13]), .Y(n672)
         );
  NOR2X1 U483 ( .A(n656), .B(n677), .Y(n676) );
  MXI2X1 U484 ( .A(n654), .B(n658), .S0(A[13]), .Y(n677) );
  NAND2X1 U485 ( .A(A[12]), .B(n659), .Y(n671) );
  MXI2X1 U486 ( .A(n660), .B(n661), .S0(A[13]), .Y(n670) );
  NAND4X1 U487 ( .A(n678), .B(n679), .C(n680), .D(n681), .Y(N388) );
  AOI221XL U488 ( .A0(n682), .A1(n652), .B0(Yout5[12]), .B1(n642), .C0(n683), 
        .Y(n681) );
  OAI2BB2XL U489 ( .B0(n684), .B1(n685), .A0N(Yout4[12]), .A1N(n641), .Y(n683)
         );
  AND2X1 U490 ( .A(n686), .B(A[3]), .Y(n652) );
  MX3XL U491 ( .A(n653), .B(n654), .C(n687), .S0(A[12]), .S1(B[12]), .Y(n680)
         );
  NOR2X1 U492 ( .A(n656), .B(n688), .Y(n687) );
  MXI2X1 U493 ( .A(n654), .B(n658), .S0(A[12]), .Y(n688) );
  NAND2X1 U494 ( .A(A[11]), .B(n659), .Y(n679) );
  MXI2X1 U495 ( .A(n660), .B(n661), .S0(A[12]), .Y(n678) );
  NAND4X1 U496 ( .A(n689), .B(n690), .C(n691), .D(n692), .Y(N387) );
  AOI221XL U497 ( .A0(n693), .A1(n651), .B0(Yout5[11]), .B1(n642), .C0(n694), 
        .Y(n692) );
  AO22X1 U498 ( .A0(n650), .A1(A[12]), .B0(Yout4[11]), .B1(n641), .Y(n694) );
  MX3XL U499 ( .A(n653), .B(n654), .C(n695), .S0(A[11]), .S1(B[11]), .Y(n691)
         );
  NOR2X1 U500 ( .A(n656), .B(n696), .Y(n695) );
  MXI2X1 U501 ( .A(n654), .B(n658), .S0(A[11]), .Y(n696) );
  NAND2X1 U502 ( .A(A[10]), .B(n659), .Y(n690) );
  MXI2X1 U503 ( .A(n660), .B(n661), .S0(A[11]), .Y(n689) );
  NAND4X1 U504 ( .A(n697), .B(n698), .C(n699), .D(n700), .Y(N386) );
  AOI221XL U505 ( .A0(n693), .A1(n666), .B0(Yout5[10]), .B1(n642), .C0(n701), 
        .Y(n700) );
  AO22X1 U506 ( .A0(n650), .A1(A[11]), .B0(Yout4[10]), .B1(n641), .Y(n701) );
  MX3XL U507 ( .A(n653), .B(n654), .C(n702), .S0(A[10]), .S1(B[10]), .Y(n699)
         );
  NOR2X1 U508 ( .A(n656), .B(n703), .Y(n702) );
  MXI2X1 U509 ( .A(n654), .B(n658), .S0(A[10]), .Y(n703) );
  NAND2X1 U510 ( .A(A[9]), .B(n659), .Y(n698) );
  MXI2X1 U511 ( .A(n660), .B(n661), .S0(A[10]), .Y(n697) );
  NAND4X1 U512 ( .A(n704), .B(n705), .C(n706), .D(n707), .Y(N385) );
  AOI221XL U513 ( .A0(n693), .A1(n674), .B0(Yout5[9]), .B1(n642), .C0(n708), 
        .Y(n707) );
  OAI2BB2XL U514 ( .B0(n684), .B1(n709), .A0N(Yout4[9]), .A1N(n641), .Y(n708)
         );
  MX3XL U515 ( .A(n653), .B(n654), .C(n710), .S0(A[9]), .S1(B[9]), .Y(n706) );
  NOR2X1 U516 ( .A(n656), .B(n711), .Y(n710) );
  MXI2X1 U517 ( .A(n654), .B(n658), .S0(A[9]), .Y(n711) );
  NAND2X1 U518 ( .A(A[8]), .B(n659), .Y(n705) );
  MXI2X1 U519 ( .A(n660), .B(n661), .S0(A[9]), .Y(n704) );
  NAND4X1 U520 ( .A(n712), .B(n713), .C(n714), .D(n715), .Y(N384) );
  AOI221XL U521 ( .A0(n693), .A1(n682), .B0(Yout5[8]), .B1(n642), .C0(n716), 
        .Y(n715) );
  AO22X1 U522 ( .A0(n650), .A1(A[9]), .B0(Yout4[8]), .B1(n641), .Y(n716) );
  NOR2BX1 U523 ( .AN(n717), .B(n718), .Y(n693) );
  MX3XL U524 ( .A(n653), .B(n654), .C(n719), .S0(A[8]), .S1(B[8]), .Y(n714) );
  NOR2X1 U525 ( .A(n656), .B(n720), .Y(n719) );
  MXI2X1 U526 ( .A(n654), .B(n658), .S0(A[8]), .Y(n720) );
  NAND2X1 U527 ( .A(A[7]), .B(n659), .Y(n713) );
  MXI2X1 U528 ( .A(n660), .B(n661), .S0(A[8]), .Y(n712) );
  NAND4X1 U529 ( .A(n721), .B(n722), .C(n723), .D(n724), .Y(N383) );
  AOI221XL U530 ( .A0(n725), .A1(n651), .B0(Yout5[7]), .B1(n642), .C0(n726), 
        .Y(n724) );
  AO22X1 U531 ( .A0(n650), .A1(A[8]), .B0(Yout4[7]), .B1(n641), .Y(n726) );
  MX3XL U532 ( .A(n653), .B(n654), .C(n727), .S0(A[7]), .S1(B[7]), .Y(n723) );
  NOR2X1 U533 ( .A(n656), .B(n728), .Y(n727) );
  MXI2X1 U534 ( .A(n654), .B(n658), .S0(A[7]), .Y(n728) );
  NAND2X1 U535 ( .A(A[6]), .B(n659), .Y(n722) );
  MXI2X1 U536 ( .A(n660), .B(n661), .S0(A[7]), .Y(n721) );
  NAND4X1 U537 ( .A(n729), .B(n730), .C(n731), .D(n732), .Y(N382) );
  AOI221XL U538 ( .A0(n725), .A1(n666), .B0(Yout5[6]), .B1(n642), .C0(n733), 
        .Y(n732) );
  OAI2BB2XL U539 ( .B0(n684), .B1(n734), .A0N(Yout4[6]), .A1N(n641), .Y(n733)
         );
  MX3XL U540 ( .A(n653), .B(n654), .C(n735), .S0(A[6]), .S1(B[6]), .Y(n731) );
  NOR2X1 U541 ( .A(n656), .B(n736), .Y(n735) );
  MXI2X1 U542 ( .A(n654), .B(n658), .S0(A[6]), .Y(n736) );
  NAND2X1 U543 ( .A(A[5]), .B(n659), .Y(n730) );
  MXI2X1 U544 ( .A(n660), .B(n661), .S0(A[6]), .Y(n729) );
  NAND4X1 U545 ( .A(n737), .B(n738), .C(n739), .D(n740), .Y(N381) );
  AOI221XL U546 ( .A0(n725), .A1(n674), .B0(Yout5[5]), .B1(n642), .C0(n741), 
        .Y(n740) );
  AO22X1 U547 ( .A0(n650), .A1(A[6]), .B0(Yout4[5]), .B1(n641), .Y(n741) );
  NOR2X1 U548 ( .A(n742), .B(A[1]), .Y(n674) );
  MX3XL U549 ( .A(n653), .B(n654), .C(n743), .S0(A[5]), .S1(B[5]), .Y(n739) );
  NOR2X1 U550 ( .A(n656), .B(n744), .Y(n743) );
  MXI2X1 U551 ( .A(n654), .B(n658), .S0(A[5]), .Y(n744) );
  NAND2X1 U552 ( .A(A[4]), .B(n659), .Y(n738) );
  MXI2X1 U553 ( .A(n660), .B(n661), .S0(A[5]), .Y(n737) );
  NAND4X1 U554 ( .A(n745), .B(n746), .C(n747), .D(n748), .Y(N380) );
  AOI221XL U555 ( .A0(n725), .A1(n682), .B0(Yout5[4]), .B1(n642), .C0(n749), 
        .Y(n748) );
  OAI2BB2XL U556 ( .B0(n684), .B1(n750), .A0N(Yout4[4]), .A1N(n641), .Y(n749)
         );
  NOR2BX1 U557 ( .AN(n686), .B(A[3]), .Y(n725) );
  NOR3X1 U558 ( .A(n751), .B(Mode[0]), .C(n752), .Y(n686) );
  MX3XL U559 ( .A(n653), .B(n654), .C(n753), .S0(A[4]), .S1(B[4]), .Y(n747) );
  NOR2X1 U560 ( .A(n656), .B(n754), .Y(n753) );
  MXI2X1 U561 ( .A(n654), .B(n658), .S0(A[4]), .Y(n754) );
  NAND2X1 U562 ( .A(A[3]), .B(n659), .Y(n746) );
  MXI2X1 U563 ( .A(n660), .B(n661), .S0(A[4]), .Y(n745) );
  OR4X1 U564 ( .A(n755), .B(n756), .C(n757), .D(n758), .Y(N379) );
  OAI2BB2XL U565 ( .B0(n472), .B1(n759), .A0N(Yout4[3]), .A1N(n641), .Y(n758)
         );
  CLKINVX1 U566 ( .A(B[3]), .Y(n472) );
  AO22X1 U567 ( .A0(Yout5[3]), .A1(n642), .B0(n760), .B1(n761), .Y(n757) );
  OAI2BB2XL U568 ( .B0(n643), .B1(n752), .A0N(n650), .A1N(A[4]), .Y(n756) );
  MXI2X1 U569 ( .A(n762), .B(n763), .S0(A[3]), .Y(n755) );
  NOR2X1 U570 ( .A(n661), .B(n764), .Y(n763) );
  MXI2X1 U571 ( .A(n654), .B(n658), .S0(B[3]), .Y(n764) );
  AOI211X1 U572 ( .A0(n717), .A1(n651), .B0(n765), .C0(n660), .Y(n762) );
  MXI2X1 U573 ( .A(n653), .B(n654), .S0(B[3]), .Y(n765) );
  NOR2X1 U574 ( .A(n766), .B(n742), .Y(n651) );
  CLKINVX1 U575 ( .A(A[0]), .Y(n742) );
  NAND4BX1 U576 ( .AN(n767), .B(n768), .C(n769), .D(n770), .Y(N378) );
  AOI221XL U577 ( .A0(Yout5[2]), .A1(n642), .B0(Yout4[2]), .B1(n641), .C0(n771), .Y(n770) );
  AO22X1 U578 ( .A0(n666), .A1(n772), .B0(n760), .B1(n773), .Y(n771) );
  OAI21XL U579 ( .A0(n774), .A1(n761), .B0(n775), .Y(n773) );
  NOR2BX1 U580 ( .AN(n776), .B(A[7]), .Y(n774) );
  NOR2X1 U581 ( .A(n766), .B(A[0]), .Y(n666) );
  MXI2X1 U582 ( .A(n660), .B(n661), .S0(A[2]), .Y(n769) );
  MX3XL U583 ( .A(n653), .B(n654), .C(n777), .S0(A[2]), .S1(B[2]), .Y(n768) );
  NOR2X1 U584 ( .A(n656), .B(n778), .Y(n777) );
  MXI2X1 U585 ( .A(n654), .B(n658), .S0(A[2]), .Y(n778) );
  OAI22XL U586 ( .A0(n643), .A1(n766), .B0(n684), .B1(n718), .Y(n767) );
  NAND3X1 U587 ( .A(n779), .B(n780), .C(n781), .Y(N377) );
  AOI221XL U588 ( .A0(A[2]), .A1(n650), .B0(A[0]), .B1(n659), .C0(n782), .Y(
        n781) );
  MXI2X1 U589 ( .A(n783), .B(n784), .S0(A[1]), .Y(n782) );
  NOR2X1 U590 ( .A(n661), .B(n785), .Y(n784) );
  MXI2X1 U591 ( .A(n654), .B(n658), .S0(B[1]), .Y(n785) );
  AOI211X1 U592 ( .A0(n772), .A1(A[0]), .B0(n786), .C0(n660), .Y(n783) );
  MXI2X1 U593 ( .A(n653), .B(n654), .S0(B[1]), .Y(n786) );
  AOI22X1 U594 ( .A0(n760), .A1(n787), .B0(Yout5[1]), .B1(n642), .Y(n780) );
  OAI211X1 U595 ( .A0(n709), .A1(n788), .B0(n789), .C0(n790), .Y(n787) );
  AOI221XL U596 ( .A0(n791), .A1(A[6]), .B0(n792), .B1(A[2]), .C0(A[14]), .Y(
        n790) );
  CLKINVX1 U597 ( .A(n775), .Y(n788) );
  AOI2BB2X1 U598 ( .B0(Yout4[1]), .B1(n641), .A0N(n474), .A1N(n759), .Y(n779)
         );
  CLKINVX1 U599 ( .A(B[1]), .Y(n474) );
  NAND2X1 U600 ( .A(n793), .B(n794), .Y(N376) );
  AOI222XL U601 ( .A0(Yout4[0]), .A1(n641), .B0(n760), .B1(n795), .C0(Yout5[0]), .C1(n642), .Y(n794) );
  OAI211X1 U602 ( .A0(A[14]), .A1(n685), .B0(n789), .C0(n796), .Y(n795) );
  AOI31X1 U603 ( .A0(A[9]), .A1(n709), .A2(n775), .B0(n797), .Y(n796) );
  OAI33X1 U604 ( .A0(n761), .A1(A[6]), .A2(n750), .B0(n798), .B1(A[2]), .B2(
        n766), .Y(n797) );
  CLKINVX1 U605 ( .A(A[5]), .Y(n750) );
  AOI211X1 U606 ( .A0(A[3]), .A1(n792), .B0(A[15]), .C0(n799), .Y(n789) );
  OAI2BB2XL U607 ( .B0(n761), .B1(n734), .A0N(n775), .A1N(A[11]), .Y(n799) );
  CLKINVX1 U608 ( .A(A[13]), .Y(n685) );
  NOR3BXL U609 ( .AN(Mode[1]), .B(n800), .C(n801), .Y(n760) );
  AOI221XL U610 ( .A0(n656), .A1(B[0]), .B0(A[1]), .B1(n650), .C0(n802), .Y(
        n793) );
  MXI2X1 U611 ( .A(n803), .B(n804), .S0(A[0]), .Y(n802) );
  NOR2X1 U612 ( .A(n661), .B(n805), .Y(n804) );
  MXI2X1 U613 ( .A(n654), .B(n658), .S0(B[0]), .Y(n805) );
  NOR2BX1 U614 ( .AN(n806), .B(n800), .Y(n661) );
  OAI2BB1X1 U615 ( .A0N(n807), .A1N(Mode[1]), .B0(n751), .Y(n806) );
  AOI211X1 U616 ( .A0(n772), .A1(n766), .B0(n808), .C0(n660), .Y(n803) );
  CLKINVX1 U617 ( .A(n809), .Y(n660) );
  MXI2X1 U618 ( .A(n653), .B(n654), .S0(B[0]), .Y(n808) );
  CLKINVX1 U619 ( .A(A[1]), .Y(n766) );
  AND2X1 U620 ( .A(n717), .B(n718), .Y(n772) );
  NOR3X1 U621 ( .A(A[2]), .B(Mode[0]), .C(n751), .Y(n717) );
  CLKINVX1 U622 ( .A(n759), .Y(n656) );
  NAND3BX1 U623 ( .AN(n810), .B(n811), .C(n812), .Y(N375) );
  AND4X1 U624 ( .A(n734), .B(n718), .C(n752), .D(n658), .Y(n812) );
  OAI211X1 U625 ( .A0(n807), .A1(Mode[3]), .B0(n800), .C0(Mode[1]), .Y(n658)
         );
  CLKINVX1 U626 ( .A(n813), .Y(n807) );
  CLKINVX1 U627 ( .A(A[2]), .Y(n752) );
  CLKINVX1 U628 ( .A(A[3]), .Y(n718) );
  CLKINVX1 U629 ( .A(A[7]), .Y(n734) );
  NOR4X1 U630 ( .A(n641), .B(n642), .C(n659), .D(n650), .Y(n811) );
  CLKINVX1 U631 ( .A(n684), .Y(n650) );
  NAND3X1 U632 ( .A(n814), .B(n815), .C(Mode[1]), .Y(n684) );
  CLKINVX1 U633 ( .A(n643), .Y(n659) );
  NAND2X1 U634 ( .A(n816), .B(n815), .Y(n643) );
  NOR3X1 U635 ( .A(n813), .B(Mode[1]), .C(n800), .Y(n642) );
  NOR3X1 U636 ( .A(Mode[0]), .B(Mode[1]), .C(n813), .Y(n641) );
  NAND4BX1 U637 ( .AN(n817), .B(n792), .C(n653), .D(n682), .Y(n810) );
  NOR2X1 U638 ( .A(A[0]), .B(A[1]), .Y(n682) );
  NAND3X1 U639 ( .A(Mode[1]), .B(n814), .C(Mode[3]), .Y(n653) );
  CLKINVX1 U640 ( .A(Mode[2]), .Y(n814) );
  CLKINVX1 U641 ( .A(n798), .Y(n792) );
  NAND2X1 U642 ( .A(n791), .B(n776), .Y(n798) );
  NOR3X1 U643 ( .A(A[5]), .B(A[6]), .C(A[4]), .Y(n776) );
  CLKINVX1 U644 ( .A(n761), .Y(n791) );
  NAND3X1 U645 ( .A(n775), .B(n709), .C(n818), .Y(n761) );
  NOR3X1 U646 ( .A(A[11]), .B(A[9]), .C(A[8]), .Y(n818) );
  CLKINVX1 U647 ( .A(A[10]), .Y(n709) );
  NOR4X1 U648 ( .A(A[12]), .B(A[13]), .C(A[14]), .D(A[15]), .Y(n775) );
  NAND4X1 U649 ( .A(n654), .B(n759), .C(n751), .D(n809), .Y(n817) );
  NAND3X1 U650 ( .A(n816), .B(n800), .C(Mode[3]), .Y(n809) );
  CLKINVX1 U651 ( .A(Mode[0]), .Y(n800) );
  NAND2BX1 U652 ( .AN(Mode[1]), .B(n819), .Y(n751) );
  CLKINVX1 U653 ( .A(n801), .Y(n819) );
  NAND2X1 U654 ( .A(n820), .B(Mode[1]), .Y(n759) );
  MXI2X1 U655 ( .A(n801), .B(n813), .S0(Mode[0]), .Y(n820) );
  NAND2X1 U656 ( .A(Mode[2]), .B(n815), .Y(n813) );
  CLKINVX1 U657 ( .A(Mode[3]), .Y(n815) );
  NAND2X1 U658 ( .A(Mode[3]), .B(Mode[2]), .Y(n801) );
  NAND3X1 U659 ( .A(n816), .B(Mode[0]), .C(Mode[3]), .Y(n654) );
  NOR2X1 U660 ( .A(Mode[2]), .B(Mode[1]), .Y(n816) );
endmodule

