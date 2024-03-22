module CLA_4bit(A, B, Cin, S, Cout);

	input [3: 0] A, B;
	input Cin;
	
	output [3: 0] S;
	output Cout;

	wire [3:0] G,P,C;
	
  	assign G = A&B;

  	assign P = A^B;

  	assign C[0] = Cin;
  	assign C[1] = G[0] | (P[0]&C[0]);
  	assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&C[0]);
  	assign C[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&C[0]);

  	assign Cout = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&C[0]);
  	assign S = P^C;

endmodule


module Adder_16bit(A, B, Cin, S, Cout);

	input [15: 0] A, B;
	input Cin;
	
	output [15: 0] S;
	output Cout;
	
	wire C4, C8, C12;
//  wire [3: 0] S0_3, S4_7, S8_11, S12_15;
	
//	assign S = {S0_3,S4_7,S8_11,S12_15};
	
	CLA_4bit cla0( .A(A[3:0])   , .B(B[3:0])   , .Cin(Cin) , .S(S[3:0])   , .Cout(C4));
	CLA_4bit cla1( .A(A[7:4])   , .B(B[7:4])   , .Cin(C4)  , .S(S[7:4])   , .Cout(C8));
	CLA_4bit cla2( .A(A[11:8])  , .B(B[11:8])  , .Cin(C8)  , .S(S[11:8])  , .Cout(C12));
	CLA_4bit cla3( .A(A[15:12]) , .B(B[15:12]) , .Cin(C12) , .S(S[15:12]) , .Cout(Cout));
endmodule

module ALU(A, B, Cin, Mode, Y, Cout, Overflow);
	
	input [15: 0] A, B;
	input Cin;
	input [3: 0] Mode;	
	
	output reg [15: 0] Y;
	output reg Cout = 1'b0;
	output reg Overflow = 1'b0;


	wire[15:0] Yout4,Yout5,Yout5t;
	wire Cout4,Cout5,Cout5t;
	Adder_16bit adder1 (A,B,Cin,Yout4,Cout4);
	
	Adder_16bit adder2 (16'd1,~B,Cin,Yout5t,Cout5t); // for second complement
	Adder_16bit adder3 (Yout5t,A,Cout5t,Yout5,Cout5);
	
// FOR CASE 12 //
	wire [15:0]dec = 1'b1 << A[3:0];	
// FOR CASE 12 //
	
// OVERFLOW SEARCH 4 //
	wire af = A[15];
	wire bf = B[15];
	wire yf = Yout4[15];
//	if (af>=0) wire over4;
// OVERFLOW SEARCH 4 //

// OVERFLOW SEARCH 5 //
	wire yff  = Yout5[15];
// OVERFLOW SEARCH 5 //

//	wire Atem = A[3:0];	
//	wire Lside0 = {(16-1-Atem){1'b0}};
//	wire Rside0 = {Atem{1'b0}};
//	if (Cout == 1'b1)begin
//		Overflow = '1;
//	end

	always@(*)begin
		case(Mode)

			4'd0: begin
			Y = A << 1'b1;
			Cout = 1'b0;
			Overflow = 1'b0;
			end

			4'd1: begin
//				if (A[15]==1'b1) begin
					Y = A <<<  1'b1;
//					Y[0] = 1'b1;
//				end else begin
//					Y = A <<< 1'b1;
//				end
			end

			4'd2: begin
			Y = A >> 1'b1;
			end

			4'd3: begin
    	    	if (A[0]==1'b1) begin			
					Y = A >>> 1'b1;
					Y[15] = 1'b1;
				end else begin
					Y = A >>> 1'b1;
				end
			end

			4'd4: begin
			Y = Yout4;
			Cout = Cout4;
                 casex({af,bf,yf})
                     3'b110 : Overflow = 1;
					 3'b001 : Overflow = 1;
					 default : Overflow = 0;
                 endcase
			
//			Overflow = Cout4;
//			if (af == bf != yf4) Overflow = 1;
//			else Overflow = 0;
//			if (af<0 && bf<0 && yf4>=0) Overflow = 1;
//	 		Adder_16bit(A,B,Cin,Y,Cout)
//			Y = A + B;
//			Y = Yout4;
			end

			4'd5: begin
			Y = Yout5;
			Cout = Cout5;
            Overflow = 0;
                casex({af,bf,yff})
                     3'b011 : Overflow = 1;
                     3'b100 : Overflow = 1;
//					 3'b001 : begin Overflow = 1; Y = Yout5t; end
					 default : Overflow = 0;
                 endcase

//			Adder_16bit(!A,B,Cin,Y,Cout);
//			Y = B - A;
//			Y = Yout5;
			end

			4'd6: begin
			Y = A & B;
			end

			4'd7: begin
			Y = A | B;
			end

			4'd8: begin
			Y = ~A;
			end

			4'd9: begin
			Y = A ^ B;
			end

			4'd10: begin
			Y = ~(A ^ B);
			end

			4'd11: begin
			Y = ~(A | B);
	  		end

			4'd12: begin	 	
			Y = dec;
	//		Y = Decoder(A[3:0]);
	//			reg [15:0]Y;
//				always@(A)begin
//					case(A)
//						3'b000: begin Y=16'b0000000000000001; end
//						3'b001: begin Y=16'b0000000000000010; end
//						3'b010: begin Y=16'b0000000000000100; end
//						3'b011: begin Y=16'b0000000000001000; end
//						3'b100: begin Y=16'b0000000000010000; end
//						3'b101: begin Y=16'b0000000000100000; end
//						3'b110: begin Y=16'b0000000001000000; end
//						3'b111: begin Y=16'b0000000010000000; end
//					endcase
//				end
			end	

			4'd13: begin
			Y = A;
			end

			4'd14: begin
			Y = B;
			end

			4'd15: begin
//			Y = {12'd0, find_first(A)};
				casex(A)
					16'b1xxxxxxxxxxxxxxx : Y = 4'd15;
					16'b01xxxxxxxxxxxxxx : Y = 4'd14;
					16'b001xxxxxxxxxxxxx : Y = 4'd13;
					16'b0001xxxxxxxxxxxx : Y = 4'd12;
					16'b00001xxxxxxxxxxx : Y = 4'd11;
					16'b000001xxxxxxxxxx : Y = 4'd10;
					16'b0000001xxxxxxxxx : Y = 4'd9;
					16'b00000001xxxxxxxx : Y = 4'd8;
					16'b000000001xxxxxxx : Y = 4'd7;
					16'b0000000001xxxxxx : Y = 4'd6;
					16'b00000000001xxxxx : Y = 4'd5;
					16'b000000000001xxxx : Y = 4'd4;
					16'b0000000000001xxx : Y = 4'd3;
					16'b00000000000001xx : Y = 4'd2;
					16'b000000000000001x : Y = 4'd1;
					16'b0000000000000001 : Y = 4'd0;
				endcase 

			end

			default:begin
			Y = 16'd0;
			end

		endcase
	end
	
endmodule















