`timescale 1ns/1ps

module Ripple_Carry_Adder_t; //just like before we declare module name for testbench then just declare all input as reg and output as wire
    reg [7:0] a, b;
    reg cin;
    wire [7:0] sum;
    wire cout;
    
    Ripple_Carry_Adder RCA_1(
        .a(a),
        .b(b),
        .cin(cin),
        .cout(cout),
        .sum(sum)
    );
    
    initial begin
        cin = 1'b0;
        a = 8'd0;
        b = 8'd0;
        //repeat (2) begin
        repeat (2 ** 8) begin
            repeat (2 ** 8) begin
                repeat (2) begin
                //repeat (2 ** 8) begin
                    //#1 cin = cin + 1'b1;
                    #1 a = a + 1'b1;
                end
                b = b + 1'b1;
            end
            //a = a + 1'b1;
             cin = cin + 1'b1;
        end
        #1 $finish; //until now i have no idea why we need 1ns delay before finish, i just follow what google taught me
    end

endmodule
