`timescale 1ns/1ps

module CLATB; //just like before we declare module name for testbench then just declare all input as reg and output as wire
    reg [7:0] a, b;
    reg c0;
    wire [7:0] s;
    wire c8;

   Carry_Look_Ahead_Adder_8bit CLA1(
        .a(a),
        .b(b),
        .c0(c0),
        .s(s),
        .c8(c8)
    );

    initial begin
        c0 = 1'b0;
        a = 8'd0;
        b = 8'd0;
        //repeat (2) begin
        repeat (2 ** 8) begin
            repeat (2 ** 8) begin
                repeat (2) begin
                //repeat (2 ** 8) begin
                    #1 a = a + 1'b1;
                end
                b = b + 1'b1;
            end
             c0 = c0 + 1'b1;
        end
        #1 $finish; //until now i have no idea why we need 1ns delay before finish, i just follow what google taught me
    end

endmodule
