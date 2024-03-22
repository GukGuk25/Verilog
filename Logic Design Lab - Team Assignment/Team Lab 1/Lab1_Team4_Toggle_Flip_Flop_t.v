`timescale 1ns / 1ps

module Toggle_Flip_Flop_t; //INPUT MUST BE REG AND OUTPUT MUST BE WIRE
    reg t = 1'b0; //declare the t as the toggle
    reg rst_n = 1'b0; //declare reset
    reg clk = 1'b0; //declare clock
    wire q; //declare output
    
    always begin
        #1 clk = 1'b1; //after 1ns clk become 1
        #1 clk = 1'b0; //after 1ns clk become 0
     end
    
    Toggle_Flip_Flop TFF_1(
        .clk(clk),
        .q(q),
        .t(t),
        .rst_n(rst_n)
        
    );
    
    always begin
        @(negedge clk) begin 
            #5 rst_n = 1'b1; //after 5 ns rst_n become 1
            #5 t = 1'b1; //after 5ns t become 1
            #5 rst_n = 1'b0; //after 5ns rst_n become 0
            #5 t = 1'b0; // afrer 5ns t become 0
        end
    end
endmodule
