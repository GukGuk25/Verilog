`timescale 1ns/1ps

module Round_Robin_FIFO_Arbiter(clk, rst_n, wen, a, b, c, d, dout, valid);
    input clk;
    input rst_n;
    input [4-1:0] wen;
    input [8-1:0] a, b, c, d;
    output [8-1:0] dout;
    output valid;

    //make wires for read enable.
    reg [4-1:0] read_enable =4'b1111, clock_count =4'b0000;
    reg [8-1:0] buffer_out;
    reg [4-1:0] printout,counter;
    wire [8-1:0] Fifo_Out_A, Fifo_Out_B, Fifo_Out_C, Fifo_Out_D;
    wire Fifo_ErrorA, Fifo_ErrorB,Fifo_ErrorC,Fifo_ErrorD; 
    reg buffer_valid;

    assign dout = buffer_out;
    assign valid = buffer_valid;

    FIFO_8 FIFO_A(clk, rst_n, wen[0], !read_enable[3]& !read_enable[2]& !read_enable[1] & !read_enable[0] &!wen[0], a,Fifo_Out_A, Fifo_ErrorA);
    FIFO_8 FIFO_B(clk, rst_n, wen[1], !read_enable[3]& !read_enable[2]& !read_enable[1] &  read_enable[0] &!wen[1], b,Fifo_Out_B, Fifo_ErrorB);
    FIFO_8 FIFO_C(clk, rst_n, wen[2], !read_enable[3]& !read_enable[2]&  read_enable[1] & !read_enable[0] &!wen[2], c,Fifo_Out_C, Fifo_ErrorC);
    FIFO_8 FIFO_D(clk, rst_n, wen[3], !read_enable[3]& !read_enable[2]&  read_enable[1] &  read_enable[0] &!wen[3], d,Fifo_Out_D, Fifo_ErrorD);

    always@(posedge clk) begin
        read_enable <= clock_count;
        printout <= read_enable;
        if(!rst_n) begin
            clock_count = 4'b0000;
            read_enable = 4'b1111;
        end
        else begin
            if(clock_count == 4'b0011) clock_count = 4'b0000;
            else clock_count <= clock_count +1;
        end
    end
    
    always @(*) begin
        if(rst_n == 1) begin
            if(clk) begin
                case(printout)
                    4'b0000: begin
                        if(wen[0] == 1 || Fifo_ErrorA ==1 || Fifo_Out_A == 8'bXXXXXXXX) begin
                            buffer_out = 0;
                            buffer_valid = 0;
                        end else begin
                            buffer_out = Fifo_Out_A;
                            buffer_valid = 1;
                        end
                    end
                    4'b0001: begin
                        if(wen[1] == 1 || Fifo_ErrorB ==1|| Fifo_Out_B == 8'bXXXXXXXX) begin
                            buffer_out = 0;
                            buffer_valid = 0;
                        end else begin
                            buffer_out =  Fifo_Out_B;
                            buffer_valid = 1;
                        end
                    end
                    4'b0010: begin
                        if(wen[2] == 1 || Fifo_ErrorC ==1|| Fifo_Out_C == 8'bXXXXXXXX) begin
                            buffer_out = 0;
                            buffer_valid = 0;
                        end else begin
                            buffer_out = Fifo_Out_C;
                            buffer_valid = 1;
                        end
                    end
                    4'b0011: begin
                        if(wen[3] == 1 || Fifo_ErrorD ==1|| Fifo_Out_D == 8'bXXXXXXXX) begin
                            buffer_out = 0;
                            buffer_valid = 0;
                        end else begin
                            buffer_out = Fifo_Out_D;
                            buffer_valid = 1;
                        end
                    end
                    default: begin
                        buffer_out =0;
                        buffer_valid = 0;
                    end 
                endcase
            end
        end else begin
            buffer_out =0;
            buffer_valid = 0;
        end
    end
endmodule


//`timescale 1ns/1ps

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
        doutbuffer <= 8'b0;
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
