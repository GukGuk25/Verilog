`timescale 1ns/1ps

module FIFO_TestBench;
    reg clk = 0;
    reg rst_n = 1'b0;
    reg wen = 1'b0;
    reg ren = 1'b0;
    reg [8-1:0] din = 8'd0;

    // use register for inputs

    wire [8-1:0] dout;
    wire error;
    //use wire for outputs.


    // specify duration of a clock cycle.
    parameter cyc = 10;
    
    // generate clock.
    always#(cyc/2) clk = !clk;
    
    FIFO_8 fifo_queue(clk, rst_n, wen, ren, din, dout, error);
    
    // uncommment and add "+access+r" to your nverilog command to dump fsdb waveform on NTHUCAD
    // initial begin
    //     $fsdbDumpfile("Memory.fsdb");
    //     $fsdbDumpvars;
    // end
    
    initial begin
        @(negedge clk)
            rst_n = 1'b1; // error at first
            din = 8'd0;
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) // start writing data num 0
            din = 8'd1;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //1
            din = 8'd2;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //2
            din = 8'd3;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //3
            din = 8'd4;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //4
            din = 8'd5;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //5
            din = 8'd6;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //6
            din = 8'd7;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //7
            din = 8'd8;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // should already be full, now start reading. read 0
            din = 8'd255;
            ren = 1'b1;
            wen = 1'b0;
        
        @(negedge clk) // re_input data.
            din = 8'd9;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // input fail
            din = 8'd255;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // read data 0
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) // read data 1
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) // read data 2
            ren = 1'b1;
            wen = 1'b1;

        @(negedge clk) // read data 3
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) // ren wen, error, read data 4
            ren = 1'b1;
            wen = 1'b1;

        @(negedge clk) // read data 5
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) //last input data before rst //write data
            din = 8'd10;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk)//read data 6
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) //read data 7
            ren = 1'b1;
            wen = 1'b1;

        @(negedge clk) // read data 0
            ren = 1'b1;
            wen = 1'b0;


        @(negedge clk)
    
        // restart the FIFO
        @(negedge clk) // reset the whole shit
            din = 1'b0;
            rst_n = 1'b0;
            ren = 1'b0;
            wen = 1'b1;
        
    
        // after restarting, round 2.
        @(negedge clk)
            rst_n = 1'b1;
            din = 8'd0;
            ren = 1'b1;
            wen = 1'b0;
        
        @(negedge clk) //data 0
            din = 8'd1;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //data 1
            din = 8'd2;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //data 2
            din = 8'd3;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //data 3
            din = 8'd4;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //data 4
            din = 8'd5;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) //data 5
            din = 8'd6;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk)//data 6
            din = 8'd7;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk)//data 7
            din = 8'd8;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // trying to write at full
            din = 8'd255;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // read 0
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) // write at position 0
            din = 8'd9;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // read 1
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) //read 2
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) //read 3
            ren = 1'b1;
            wen = 1'b1;

        @(negedge clk) //read 4
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) //read 5
            ren = 1'b1;
            wen = 1'b1;

        @(negedge clk) // read 6
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) // write at position 1
            din = 8'd10;
            ren = 1'b0;
            wen = 1'b1;

        @(negedge clk) // read 7
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk) //read 0
            ren = 1'b1;
            wen = 1'b1;

        @(negedge clk) //read 1
            ren = 1'b1;
            wen = 1'b0;

        @(negedge clk)
        $finish;
    end
    
endmodule
