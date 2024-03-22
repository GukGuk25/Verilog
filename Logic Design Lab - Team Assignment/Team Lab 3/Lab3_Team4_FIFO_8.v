`timescale 1ns/1ps

module FIFO_8(clk, rst_n, wen, ren, din, dout, error);
    input clk;
    input rst_n;
    input wen, ren;
    input [8-1:0] din;
    output [8-1:0] dout;
    output error;
    
    // 1 word 8 bits
    reg [8-1:0] fifo_data [8-1:0];
    reg [8-1:0]doutbuffer = 8'b0;
    reg errorbuffer = 8'b0;

    reg[4-1:0] read_addr=4'b0, write_addr=4'b0;
    assign dout = doutbuffer;
    assign error = errorbuffer;
    
    //assign fifo_data[0] = 8'b11111111;
    
    always@(posedge clk) begin
        if(rst_n == 0) begin
        //empty the fifo first, set dout and error to 0.
        errorbuffer <= 0;
        doutbuffer <= 0;
        fifo_data[0] <= 8'b11111111; fifo_data[1] <= 8'b11111111;
        fifo_data[2] <= 8'b11111111; fifo_data[3] <= 8'b11111111;
        fifo_data[4] <= 8'b11111111; fifo_data[5] <= 8'b11111111;
        fifo_data[6] <= 8'b11111111; fifo_data[7] <= 8'b11111111;
        read_addr <= 4'b0000; write_addr <= 4'b0000;
        end else begin
        if(ren == 1 && wen == 0) begin
            if (fifo_data[read_addr] != 8'b11111111) begin
                doutbuffer <= fifo_data[read_addr];
                fifo_data[read_addr] <= 8'b11111111;
                read_addr <= (read_addr +1) % 8;
                errorbuffer <= 1'b0;
            end else begin
                doutbuffer <= 8'bXXXXXXXX;
                errorbuffer <= 1'b1;
            end
        end else if(ren == 0 && wen == 1) begin
            if (fifo_data[write_addr]== 8'b11111111) begin
                fifo_data[write_addr] <= din;
                write_addr <= (write_addr +1) %8;
                errorbuffer <= 1'b0;
            end else begin
                doutbuffer <= 8'bXXXXXXXX;
                errorbuffer <= 1'b1;
            end
        end else if(ren == 1 && wen == 1) begin
            if (fifo_data[read_addr] != 8'b11111111) begin
                doutbuffer <= fifo_data[read_addr];
                fifo_data[read_addr] <= 8'b11111111;
                read_addr <= (read_addr +1)%8;
                errorbuffer <= 1'b0;
            end else begin
                doutbuffer <= 8'bXXXXXXXX;
                errorbuffer <= 1'b1;
            end
        end
        
        end // close the big else
    end

endmodule
