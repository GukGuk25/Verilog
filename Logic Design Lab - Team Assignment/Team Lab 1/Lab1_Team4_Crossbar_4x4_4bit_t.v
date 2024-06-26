`timescale 1ns / 1ps

module Crossbar_4x4_4bit_t;
    reg[3:0] in1 = 4'b0000; //declare all input first and just choose random num so we can see the changes
    reg[3:0] in2 = 4'b0010;
    reg[3:0] in3 = 4'b0100;
    reg[3:0] in4 = 4'b1000;
    reg[4:0] control = 5'b0;
    wire[3:0] out1, out2, out3, out4;
    
    Crossbar_4x4_4bit C_1(
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .out4(out4),
        .control(control)
    );
    
    initial begin
        repeat(50) begin //just random number to make it long so we can see more combination
            #1 control = control + 5'b1; // changes control in1 in2 in3 in4 periodicly
            #1 in1 = in1 + 4'b1;
            #1 in2 = in2 + 4'b1;
            #1 in3 = in3 + 4'b1;
            #1 in4 = in4 + 4'b1;
        end
        #1 $finish;
    end

endmodule
