module kevin_G(in,out);
	input [3:0]in;
	output out;

	wire nota,notb,notc,notd;
	wire and0,and1,and2,and3,and4;
	wire or0;

	not n1(nota,in[3]);
	not n2(notb,in[2]);
	not n3(notc,in[1]);
	not n4(notd,in[0]);

	and a0(and0,in[3],in[1],notd);
	and a1(and1,nota,in[2],in[1]);
	and a2(and2,nota,notc,in[0]);
	and a3(and3,notb,notc,in[0]);
	and a4(and4,in[3],in[2],notd);

	or o0(out,and0,and1,and2,and3,and4);
endmodule


module kevin_D(in,out);
	input [3:0]in;
	output out;
	assign out=(in[3]&in[1]&!in[0]) | (!in[3]&in[2]&in[1]) | (!in[3]&!in[1]&in[0]) | (!in[2]&!in[1]&in[0]) | (in[3]&in[2]&!in[0]);
endmodule


module kevin_B(in,out);
	input [3:0]in;
	output out;
	reg out;
	
	always@(*)begin
		case(in)
			1,5,6,7,9,10,12,14: begin
				out=1'b1;
			end
			default: begin
				out=1'b0;
			end
		endcase
	end


endmodule
