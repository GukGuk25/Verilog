module PAT(clk, reset, data, flag);
	
	input clk, reset, data;
//	output reg flag = 1'b0;
	output flag;
	parameter Sa=4'd0, Sb=4'd1, Sc=4'd2, Sd=4'd3, Se=4'd4, Sf=4'd5, Sg=4'd6, Sh=4'd7, Si=4'd8;
	reg [3:0] cur, next;

// CHECK	
//	assign flag = next == SA ? 1 : 0 ;
	assign flag = cur == Si ? 1 : 0 ;
//	if (cur === Si) 
//		assign flag = 1;
//	else 
//		assign flag = 0;
//	assign flag = cur == SH ? (next == SI ? 1:0) : 0;
//	assign flag = cur == SI ? 1:0;
// CHECK

// RESET CHECK
	always@( posedge clk ) begin
		if (reset)
			cur <= Sa;
		else 
			cur <= next;
	end
// RESET CHECK

	always@( cur, data ) begin
		case (cur)
			Sa : begin
				if (data) next = Sa;
				else next = Sb;
			end 
			Sb : begin
				if(data) next = Sa;
				else next = Sc;
			end
			Sc : begin
				if(data) next = Sd;
				else next = Sc;
			end
			Sd : begin
				if (data) next = Se;
				else next = Sb;
			end
			Se : begin
				if (data) next = Sa;
				else next = Sf;
			end
			Sf : begin
				if (data) next = Sg;
				else next = Sc;
			end
			Sg : begin
				if (data) next = Sh;
				else next = Sb;
			end
			Sh : begin
				if (data) next = Si;
				else next = Sf;
			end
			Si : begin
//				next = SA;
				if (data) next = Sa;
				else next = Sb;
				end
			default : begin
				next = Sa;
				end
		endcase
	end
// CHECK
//  assign flag = cur == next ? 1:0;
//	assign flag = (flags == t) ? 1:0;
//  assign flag = (cur==SH) ? (next==SA)?1:0 : 0 ;
// CHECK

endmodule
