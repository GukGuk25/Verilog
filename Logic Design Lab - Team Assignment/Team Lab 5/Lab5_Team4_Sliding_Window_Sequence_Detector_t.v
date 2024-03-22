`timescale 1ns/1ps

module window_slider_checker;
    reg clk=1'b1, rst_n=1'b0, in=1'b0;
    wire dec;
    //wire [7-1:0] current_state;
    
    Sliding_Window_Sequence_Detector slideee(clk, rst_n, in, dec);
    
    parameter cyc = 5;
    always #(cyc) clk = ~clk;
    
    initial begin
        @(negedge clk) rst_n = 1'b0;
        @(negedge clk) rst_n = 1'b1;
//        Kalau ngaco menurut ppt.
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;                
        @(negedge clk) in = 1'b1; //pattern should be found.
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;        
//        Ini kalau casenya bisa match atau sesuai patternnya
        @(negedge clk) rst_n = 1'b0;
        @(negedge clk) rst_n = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) rst_n = 1'b0;
        @(negedge clk) rst_n = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;


        @(negedge clk) rst_n = 1'b0;
        @(negedge clk) rst_n = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b1;
        @(negedge clk) in = 1'b0;
        @(negedge clk) in = 1'b0;
        
        @(negedge clk) $finish;
    end
    
endmodule