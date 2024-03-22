`timescale 1ns/1ps

module Parameterized_Ping_Pong_Counter (clk, rst_n, enable, flip, max, min, direction, out);
    input clk, rst_n;
    input enable;
    input flip;
    input [4-1:0] max;
    input [4-1:0] min;
    output direction;
    output [4-1:0] out;
    
    
    reg[3:0] counter = 4'd0;
    reg dir = 1'd1;
//    wire flips = flip;
//    reg flipss = 1'd0;
//    reg justreset = 1'b0;
    assign direction = dir;
    assign out = counter;

//    always@(*)begin
//        if ((flip == 1'd1) && (flips == 1'd0 )) begin
//            flipss = 1'd1;
//        end else begin
//            flipss = 1'd0;
//        end
//    end
    
    always@(posedge clk) begin        
        if (rst_n == 1'b0) begin
            counter <= min;
            dir <= 1'd1;
            //justreset <= 1'd1;
   
        end else begin
//            if (flipss == 1'd1) begin
//                flips <= 1'd1;
//                flipss <= 1'd0;
//            end else flipss <= 1'd0;
            
            if ( (enable == 1'd1) && (min<max) && (min<=out) && (out<=max) && (min!=max) ) begin
                if (dir == 1'd1) begin
                    if  (flip == 1'b1) begin
                        counter <= counter - 4'd1;
                        dir <= 1'b0;
//                        flips <= 1'b0;
                    end else begin
                        if (counter < max) begin
                            counter <= counter + 4'd1;
                        end else begin
                            if (counter  == max) begin
                                //dir <= 1'd0;
    //                            flips <= 1'b1;
                                counter <= counter - 4'd1;
                                dir <= 1'b0;
    //                            flips <= 1'b0;
                            end else begin
                                
                            end
                        end
                    end
                    

                end else begin
                    if (flip == 1'b1) begin
                        counter <= counter + 4'd1;
                        dir <= 1'b1;
//                        flips <= 1'b0;
                    end else begin 
                        if (counter > min) begin
                            counter <= counter - 4'd1;
                        end else begin
                            if (counter  == min) begin
                                //dir <= 1'd1;
    //                            flips <= 1'b1;
                                counter <= counter + 4'd1;
                                dir <= 1'b1;
    //                            flips <= 1'b0;
                            end else begin
                                
                            end
                        end
                    end
                    


                end
            end else begin
                counter <= counter;
                dir <= dir;
//                justreset <= 1'd0;
            end
        end
    
    end

endmodule


//module Ping_Pong_Counter (clk, rst_n, enable, direction, out); V2
//    input clk, rst_n;
//    input enable;
//    output direction;
//    output [4-1:0] out;
    
//    reg[3:0] counter = 4'd0;
//    reg dir = 1'd1;
//    reg flip = 1'b0;
//    reg prevbounce = 1'b0;
//    assign direction = dir;
//    assign out = counter;
//    always@(posedge clk) begin
//        if (rst_n == 1'b0) begin
//            counter <= 4'd0;
//            dir <= 1'd1;
//        end else begin
        
//            if (enable == 1'b1) begin
//                if (dir == 1'd1) begin
//                    if  (flip == 1'b1) begin
//                        counter <= counter - 4'd1;
//                        dir <= 1'b0;
//                        flip <= 1'b0;
//                    end else begin
//                        counter <= counter + 4'd1;
//                    end
                    
//                    if (counter == 4'b1110) begin
//                        //dir <= 1'd0;
//                        flip <= 1'b1;
//                    end
//                end else begin
//                    if (flip == 1'b1) begin
//                        counter <= counter + 4'd1;
//                        dir <= 1'b1;
//                        flip <= 1'b0;
//                    end else begin
//                        counter <= counter - 4'd1;
//                    end
//                    if (counter == 4'b0001) begin
//                        //dir <= 1'd1;
//                        flip <= 1'b1;
//                    end

//                end
//            end else begin
//                counter <= counter;
//                dir <= dir;
//            end
//        end
    
//    end
//endmodule

//module Ping_Pong_Counter (clk, rst_n, enable, direction, out); V1
//    input clk, rst_n;
//    input enable;
//    output direction;
//    output [4-1:0] out;
    
//    reg[3:0] counter = 4'd0;
//    reg dir = 1'd1;
    
//    assign direction = dir;
//    assign out = counter;
//    always@(posedge clk) begin
//        if (rst_n == 1'b0) begin
//            counter <= 4'd0;
//        end else begin
//            if (enable == 1'b1) begin
//                if (dir == 1'd1) begin
//                    counter <= counter + 4'd1;
//                    if (counter == 4'b1110) begin
//                        dir <= 1'd0;
//                    end
//                end else begin
//                    counter <= counter - 4'd1;
//                    if (counter == 4'b0001) begin
//                        dir <= 1'd1;
//                    end
//                end
//            end
//        end
    
//    end
    
//endmodule
