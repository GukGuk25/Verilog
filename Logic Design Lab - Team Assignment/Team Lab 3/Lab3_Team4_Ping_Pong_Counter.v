`timescale 1ns/1ps

module Ping_Pong_Counter (clk, rst_n, enable, direction, out);
    input clk, rst_n;
    input enable;
    output direction;
    output [4-1:0] out;
    
    reg[3:0] counter = 4'd0;
    reg dir = 1'd1;
    reg flip = 1'b0;
    reg justreset = 1'd0;
    assign direction = dir;
    assign out = counter;
    always@(posedge clk) begin
        if (rst_n == 1'b0) begin
            counter <= 4'd0;
            dir <= 1'd1;
            //justreset <= 1'd1;
        end else begin
        
            if ((enable == 1'b1) && (justreset == 1'd0)) begin
                if (dir == 1'd1) begin
                    if  (flip == 1'b1) begin
                        counter <= counter - 4'd1;
                        dir <= 1'b0;
                        flip <= 1'b0;
                    end else begin
                        counter <= counter + 4'd1;
                    end
                    
                    if (counter == 4'b1110) begin
                        //dir <= 1'd0;
                        flip <= 1'b1;
                    end
                end else begin
                    if (flip == 1'b1) begin
                        counter <= counter + 4'd1;
                        dir <= 1'b1;
                        flip <= 1'b0;
                    end else begin
                        counter <= counter - 4'd1;
                    end
                    if (counter == 4'b0001) begin
                        //dir <= 1'd1;
                        flip <= 1'b1;
                    end

                end
            end else begin
                counter <= counter;
                dir <= dir;
                justreset <= 1'd0;
            end
        end
    
    end
endmodule
