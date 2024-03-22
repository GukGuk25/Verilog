`timescale 1ns/1ps

module Simple_Crossbar_2x2_4bit_t;
    reg[3:0] in1 = 4'b0; //declare input as reg and set the val to 0
    reg[3:0] in2 = 4'b0; //declare 2nd input as reg and set the val to 0
    reg control = 1'b0; //set the control to be 0
    wire[3:0] out1, out2; // set the output as wire
    
    Crossbar_2x2_4bit C_1(
        .in1(in1),
        .in2(in2),        
        .control(control),
        .out1(out1),
        .out2(out2)
    );
    
    initial begin
        repeat (2) begin //we repeat 2 times cuz there are 2 value of control, when its 0 and when its 1
            control = control + 1'b1; //increse the control by 1
            in1 = 4'b0; //set the in1 as 0
            repeat (9) begin //repeat 9 times cuz there are 9 number
                #2 in1 = in1 + 4'b1; //every 2ns increase by 1
                in2 = 4'b0; // set in2 as 0
                repeat (9) begin //repeat 9 times so it will be easy to see the wave form cuz in2 will be 9 times more dense than in1
                    #2 in2 = in2 + 4'b1; //increase in2 by 1
                end
            end
        end
        #1 $finish;
    end
endmodule
