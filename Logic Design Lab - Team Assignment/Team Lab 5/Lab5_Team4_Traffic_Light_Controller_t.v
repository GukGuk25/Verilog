`timescale 1ns/1ps

module nitnot;
    
    reg clk=1'b1, rst_n=1'b1;
    reg lr_has_car=1'b0;
    wire [2:0] hw_light;
    wire [2:0] lr_light;
    //wire [4-1:0] current_state;
    //wire [7-1:0] seventy_more, seventy_cyc, twenty_five;
    
    parameter cyc = 5;
    always#(cyc) clk = ~clk;
    
    Traffic_Light_Controller tol_cipali (clk, rst_n, lr_has_car, hw_light, lr_light);
    
    initial begin
        @(negedge clk) rst_n = 1'b0;
        @(negedge clk) rst_n = 1'b1;
        @(negedge clk)
        @(negedge clk) lr_has_car =1'b1;
        #(500*cyc);
        @(negedge clk) lr_has_car =1'b0;
        #(50*cyc);
        @(negedge clk) lr_has_car =1'b0;
        @(negedge clk) rst_n = 1'b0;
        @(negedge clk) rst_n = 1'b1;
        #(200*cyc);
        @(negedge clk) lr_has_car =1'b1;
        #(300*cyc);
        $finish;
    end

endmodule 