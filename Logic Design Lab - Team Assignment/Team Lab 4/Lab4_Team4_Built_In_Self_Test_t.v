`timescale 1ns/1ps

module Built_In_Self_Test_t;
    reg clk;
    reg rst_n;
    reg scan_en;
    wire scan_in;
    wire scan_out;
    
    parameter cyc = 10;
    always#(cyc/2)clk = !clk;
    
    Built_In_Self_Test BIST(
                            clk, 
                            rst_n, 
                            scan_en, 
                            scan_in, 
                            scan_out
    );
    initial begin
        clk = 1'b1;
        rst_n = 1'b0;
        rst_n <= 1'd0;
        scan_en <=1'd0;
        #(cyc*2)
        @(negedge clk) begin
            rst_n <= 1'd1;
            scan_en <= 1'd1;
        end
        
        //1st gonna be 1011 x 1101 since that is the one in initial of MTO
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(posedge clk) scan_en = 1'b0;
        @(posedge clk) scan_en = 1'b1;     
        
        
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        
        //2nd gonna be the next data from MTO 
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(negedge clk)
        @(posedge clk) scan_en = 1'b0;
        @(posedge clk) scan_en = 1'b1;     
        //all data in SCD gonna be from MTO
        #(cyc*10) $finish;
    end
endmodule
