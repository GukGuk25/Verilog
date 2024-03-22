/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Fri May 28 15:35:55 2021
/////////////////////////////////////////////////////////////


module PAT ( clk, reset, data, flag );
  input clk, reset, data;
  output flag;
  wire   N13, N14, N15, N16, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n17, n18, n19;
  wire   [3:0] cur;

  DFFQX1 \cur_reg[2]  ( .D(N15), .CK(clk), .Q(cur[2]) );
  DFFQX1 \cur_reg[1]  ( .D(N14), .CK(clk), .Q(cur[1]) );
  DFFQX1 \cur_reg[0]  ( .D(N13), .CK(clk), .Q(cur[0]) );
  DFFQX1 \cur_reg[3]  ( .D(N16), .CK(clk), .Q(cur[3]) );
  XNOR2X1 U27 ( .A(n5), .B(n4), .Y(n11) );
  OAI22XL U28 ( .A0(n4), .A1(n5), .B0(n11), .B1(n3), .Y(n8) );
  NAND3X1 U29 ( .A(n1), .B(n7), .C(n11), .Y(n12) );
  AND4X1 U30 ( .A(n10), .B(n1), .C(n8), .D(n9), .Y(N16) );
  CLKINVX1 U31 ( .A(n15), .Y(n2) );
  NOR3X1 U32 ( .A(n1), .B(n8), .C(n9), .Y(flag) );
  CLKINVX1 U33 ( .A(n10), .Y(n6) );
  XNOR2X1 U34 ( .A(cur[2]), .B(n11), .Y(n9) );
  NOR4X1 U35 ( .A(n3), .B(n4), .C(cur[0]), .D(cur[3]), .Y(n15) );
  CLKINVX1 U36 ( .A(cur[2]), .Y(n3) );
  CLKINVX1 U37 ( .A(cur[3]), .Y(n1) );
  CLKINVX1 U38 ( .A(cur[1]), .Y(n4) );
  CLKINVX1 U39 ( .A(cur[0]), .Y(n5) );
  OAI32X1 U40 ( .A0(n12), .A1(reset), .A2(n3), .B0(n13), .B1(n6), .Y(N15) );
  AOI31X1 U41 ( .A0(n14), .A1(n1), .A2(cur[0]), .B0(n15), .Y(n13) );
  XNOR2X1 U42 ( .A(n3), .B(cur[1]), .Y(n14) );
  OAI32X1 U43 ( .A0(n16), .A1(reset), .A2(cur[3]), .B0(n6), .B1(n2), .Y(N14)
         );
  AOI33X1 U44 ( .A0(n17), .A1(n4), .A2(cur[0]), .B0(n5), .B1(n3), .B2(cur[1]), 
        .Y(n16) );
  NAND2X1 U45 ( .A(data), .B(n3), .Y(n17) );
  AOI31X1 U46 ( .A0(n2), .A1(n12), .A2(n18), .B0(reset), .Y(N13) );
  NAND3X1 U47 ( .A(n5), .B(n3), .C(n19), .Y(n18) );
  OAI32X1 U48 ( .A0(n7), .A1(cur[3]), .A2(n4), .B0(data), .B1(cur[1]), .Y(n19)
         );
  NOR2X1 U49 ( .A(reset), .B(n7), .Y(n10) );
  CLKINVX1 U50 ( .A(data), .Y(n7) );
endmodule

