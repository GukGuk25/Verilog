`timescale 1ns/1ps

module Scan_Chain_Design_t;
    reg clk;
    reg rst_n;
    reg scan_in;
    reg scan_en;
    wire scan_out;
    
    parameter cyc = 10;
    always#(cyc/2)clk = !clk;
    
    Scan_Chain_Design chain(
                        clk, 
                        rst_n, 
                        scan_in, 
                        scan_en, 
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
            scan_in <= 1'd0;
        end
        #(cyc*1)
        //A 0101 x 0101 = 0001 1001 => 10011000
        @(negedge clk) begin
            scan_in <= 1'd1;
        end
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end    
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end   
        #(cyc*1)
        
        //B
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end   
        
        //make thing go out
        
        @(negedge clk) begin
            scan_en <= 1'd0;
        end
        #(cyc*1)
        @(negedge clk) begin
            scan_en <= 1'd1;
            //#(cyc*8)   
            //rst_n <= 1'd0;
        end
        #(cyc*8)    
        
        
        
       
        //A 1111 x 1111 = 11100001 => 10000111
        @(negedge clk) begin
            scan_in <= 1'd1;
        end
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end    
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        
        //B
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        
        //make thing go out
        
        @(negedge clk) begin
            scan_en <= 1'd0;
        end
        #(cyc*1)
        @(negedge clk) begin
            scan_en <= 1'd1;
            //#(cyc*8)   
            //rst_n <= 1'd0;
        end
        #(cyc*8)
        
        
        
        //A 0000 x 1111 = 00000000 => 00000000
        @(negedge clk) begin
            scan_in <= 1'd0;
        end
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end    
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd0;
        end   
        #(cyc*1)
        
        //B
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        #(cyc*1)
        @(negedge clk) begin
            scan_in <= 1'd1;
        end   
        
        //make thing go out
        
        @(negedge clk) begin
            scan_en <= 1'd0;
        end
        #(cyc*1)
        @(negedge clk) begin
            scan_en <= 1'd1;
            //#(cyc*8)   
            //rst_n <= 1'd0;
        end
        #(cyc*8)
        $finish;
        
    end
endmodule
