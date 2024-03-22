`timescale 1ns / 1ps
`define SDFFILE "./ALU.sdf"

module tb();
	parameter n = 16;
	parameter m = 4;
	parameter delay = 5;

	reg [n - 1: 0] A, B;
	reg Cin;
	reg [m - 1: 0] Mode;

	wire [n - 1: 0] Y;
	wire Cout;
	wire Overflow;

	ALU alu(A, B, Cin, Mode, Y, Cout, Overflow);

	reg [n - 1: 0] test;
	initial begin
		`ifdef SDF
			$sdf_annotate(`SDFFILE, alu);
		`endif
	end

	integer i;
	always begin
		#delay
		if(Cout === 1'bx || Cout === 1'bz || Overflow === 1'bx || Overflow === 1'bz)begin
			$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
			$display("There's x or z value in Cout or Overflow, please check it.");
			$finish;
		end
		for(i = 0; i < 16; i = i + 1)begin
			if(Y[i] === 1'bx || Y[i] === 1'bz)begin
				$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
				$display("There's x or z value in Y, please check it.");
				$finish;
			end
		end
	end

	initial begin
		//----------testcase - 0

		A = 16'b0000110001011010;
		B = 16'd0;
		Cin = 1'b0;
		Mode = 4'd0;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'b0001100010110100)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 1

		A = 16'b1010001101101001;
		B = 16'd0;
		Cin = 1'b0;
		Mode = 4'd1;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'b0100011011010010)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 2

		A = 16'b1010001101101001;
		B = 16'd0;
		Cin = 1'b0;
		Mode = 4'd2;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'b0101000110110100)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 3

		A = 16'b1010100011101001;
		B = 16'd0;
		Cin = 1'b0;
		Mode = 4'd3;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'b1101010001110100)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 4

		A = 16'b1010100011101001;
		B = 16'b0011001100111111;
		Cin = 1'b0;
		Mode = 4'd6;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != (A & B))begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 5

		A = 16'b1010001110001100;
		B = 16'b0011001100111001;
		Cin = 1'b0;
		Mode = 4'd7;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != (A | B))begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 6

		A = 16'b1010000001111010;
		B = 16'd0;
		Cin = 1'b0;
		Mode = 4'd8;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != ~A)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 7

		A = 16'b1010000001111010;
		B = 16'b0100111100000000;
		Cin = 1'b0;
		Mode = 4'd9;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != (A ^ B))begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 8

		A = 16'b1010010101011010;
		B = 16'b0100111111111000;
		Cin = 1'b0;
		Mode = 4'd10;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != ~(A ^ B))begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 9

		A = 16'b0100111000011111;
		B = 16'b1111100010100011;
		Cin = 1'b0;
		Mode = 4'd11;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != ~(A | B))begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 10

		A = 16'b0100011000110101;
		B = 16'b1111100010100011;
		Cin = 1'b0;
		Mode = 4'd12;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != {{15{1'b0}}, 1'b1} << A[3: 0])begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 11

		A = 16'b0111111101000111;
		B = 16'b1100000001111101;
		Cin = 1'b0;
		Mode = 4'd13;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != A)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 12

		A = 16'b0111111101000111;
		B = 16'b1100000001111101;
		Cin = 1'b0;
		Mode = 4'd14;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != B)begin
			$display("You got wrong answer.");
			$finish;
		end

		//----------testcase - 13

		A = 16'b0111111101000111;
		B = 16'b1100000001111101;
		Cin = 1'b0;
		Mode = 4'd15;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd14)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		$display();$display();
		//----------testcase - 14
		
		A = 16'd1084;
		B = 16'd985;
		Cin = 1'b0;
		Mode = 4'd4;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd2069 || Cout != 0 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 15
		A = 16'd123;
		B = 16'd320;
		Cin = 1'b1;
		Mode = 4'd4;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd444 || Cout != 0 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 16
		A = 16'd7826;
		B = 16'd51846;
		Cin = 1'b0;
		Mode = 4'd4;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd59672 || Cout != 0 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------testcase - 17
		A = 16'd30183;
		B = 16'd36525;
		Cin = 1'b1;
		Mode = 4'd4;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd1173 || Cout != 1 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay
		
		//----------testcase - 18
		A = 16'd13468;
		B = 16'd20440;
		Cin = 1'b0;
		Mode = 4'd4;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd33908 || Cout != 0 || Overflow != 1)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay
		
		//----------testcase - 19
		A = 16'd49916;
		B = 16'd49357;
		Cin = 1'b0;
		Mode = 4'd4;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd33737 || Cout != 1 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay
		
		//----------testcase - 20
		A = 16'd3964;
		B = 16'd34114;
		Cin = 1'b0;
		Mode = 4'd5;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd35386 || Cout != 0 || Overflow != 1)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay
		
		//----------testcase - 21
		A = 16'd8427;
		B = 16'd20744;
		Cin = 1'b0;
		Mode = 4'd5;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd53219 || Cout != 0 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay
		
		//----------testcase - 22
		A = 16'd25413;
		B = 16'd13301;
		Cin = 1'b0;
		Mode = 4'd5;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd12112 || Cout != 1 || Overflow != 0)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay
		
		//----------testcase - 23
		A = 16'd51271;
		B = 16'd23442;
		Cin = 1'b0;
		Mode = 4'd5;

		#delay

		$display("Mode: %d, A: (%b, %d), B: (%b, %d), Cin: %b, Y: (%b, %d), Cout: %b, Overflow: %b", Mode, A, $signed(A), B, $signed(B), Cin, Y, $signed(Y), Cout, Overflow);
		if(Y != 16'd27829 || Cout != 1 || Overflow != 1)begin
			$display("You got wrong answer.");
			$finish;
		end

		#delay

		//----------Finish
		$display("Congratulation!!");
		$finish;
	end
endmodule
