`timescale 1ns / 1ps

module Dmux_1x4_4bit_t;
    reg [3:0] in = 4'b0; //input and set starting value
    reg [1:0] sel = 2'b0; //input selection and set starting value
    wire [3:0] a, b, c, d; //output
    
    Dmux_1x4_4bit D_1(
        .in(in),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel)
    );
    
    initial begin
        repeat (4) begin //run 4 times cuz its 1x4 demux so we need to test it 4 time, once every selection
            #1 sel = sel + 2'b1; //increase the selection by 1
            in = 4'b0; //set the in back to 0
            repeat (9) begin //run 9 times cuz there are 10 number
                #1 in = in + 4'b1; //change the input so we can see if the output follows the input
            end
        end
        #1 $finish;
    end
    
endmodule
