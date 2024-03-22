`timescale 1ns/1ps

module fpga_ping_pong(clk, min, max, flip_button, rst_button, enable, cathode, anode);
    input clk;
    input [4-1:0] min, max;  //min, max, rst_n, enable, flip is all for the ping pong
    input rst_button, enable, flip_button;
    output [3:0] anode; // set 1 to turn on.
    output [6:0] cathode; // set 1 to shut down

    //reg clk =0; //clk is for the ping pong
    wire flip, rst_n, hold_rst;

    wire debounce_rst_out;
    wire debounce_flip_out;
    wire direction;
    wire [4-1:0] out;
    wire [40:0] sac;
    wire clk_div3, clk_div6, clk_div9, clk_div12, clk_div15, clk_div17, clk_div20, clk_div23, clk_div26;
    // parameter cyc = 10;
    // always#(cyc/2)clk = !clk;
    
    debounce debouncing_rst(debounce_rst_out, rst_button, clk);
    onepulse onepulse_rst(debounce_rst_out, clk, hold_rst);
    not not1(rst_n, hold_rst);

    debounce debouncing_flip(debounce_flip_out, flip_button, clk);
    onepulse onepulse_flip(debounce_flip_out, clk_div3, flip);
    //module Clock_Divider (clk, rst_n, sel, clk1_2, clk1_4, clk1_8, clk1_3, dclk);
    Clock_Divider divide2_3 (clk, rst_n, 2'b11, sac[0], sac[1], sac[2], sac[3], clk_div3);

    //get the ping-pong
    Parameterized_Ping_Pong_Counter ping_pong(
        .clk(clk_div3),
        .rst_n(rst_n),
        .enable(enable),
        .flip(flip),
        .max(max),
        .min(min),
        .direction(direction),
        .out(out)
    );
    //work with the out (to display value)
    // work with the direction (to show direction)
    //display out at the anode 3, anode 2,
    //display the direction at anode 1 and anode 0.
    set_display display(out, min, max, direction, clk, hold_rst, cathode, anode);


endmodule

module set_display(out, min, max, direction, clk, rst_n, cathode, anode);
    input [4-1:0] out;
    input [4-1:0] min;
    input [4-1:0] max;
    input direction;
    input clk;
    input rst_n;
    output reg [6:0] cathode;
    output reg [3:0] anode;

    reg[19:0] LED_Refresh;
    wire [2-1:0] choose_LED;

    wire [7-1:0] digit1, digit2;
    reg [4-1:0]LED_NUM, show_num;

    always@(posedge clk or posedge rst_n) begin
        if(rst_n == 1) begin
            LED_Refresh <=0;
        end
        else begin
            LED_Refresh <= LED_Refresh + 1;
        end
    end

    always @(posedge clk or posedge rst_n)begin
        if(rst_n==1) begin
            show_num <= min;
        end
        else begin
            show_num <= out;
        end
    end
    initial show_num <= min;
    change change1(show_num, digit1, digit2);
    //convert number into the output we need.


    assign choose_LED = LED_Refresh[19:18];

    always@(*) begin
        case(choose_LED)
        2'b00: begin
            anode = 4'b0111; //activate left most LED.
            cathode = digit1;
        end
        2'b01: begin
            anode = 4'b1011;
            cathode = digit2;
        end
        2'b10: begin
            anode = 4'b1101;
            if(direction) cathode = 7'b0011101;
            else cathode = 7'b1100011; // kalau true, CDEG mati ABCDEFG
        end
        2'b11: begin
            anode = 4'b1110;
            if(direction) cathode = 7'b0011101;
            else cathode = 7'b1100011; // kalau true, CDEG mati ABCDEFG
        end
        endcase
    end

    //now how to choose the value of which anode, and which cathode.
endmodule

module change(in,out1,out2);
    input[3:0] in;
    output reg[6:0] out1;
    output reg[6:0] out2;
    always@(*)begin
        case(in) 
            4'd0: begin
                out1 = 7'b0000001;
                out2 = 7'b0000001;
            end
            4'd1:begin
                out1 = 7'b0000001;
                out2 = 7'b1001111;
            end
            4'd2:begin
                out1 = 7'b0000001;
                out2 = 7'b0010010;
            end
            4'd3:begin
                out1 = 7'b0000001;
                out2 = 7'b0000110;
            end
            4'd4:begin
                out1 = 7'b0000001;
                out2 = 7'b1001100;
            end
            4'd5:begin
                out1 = 7'b0000001;
                out2 = 7'b0100100;
            end
            4'd6:begin
                out1 = 7'b0000001;
                out2 = 7'b0100000;
            end
            4'd7:begin
                out1 = 7'b0000001;
                out2 = 7'b0001111;
            end
            4'd8:begin
                out1 = 7'b0000001;
                out2 = 7'b0000000;
            end
            4'd9:begin
                out1 = 7'b0000001;
                out2 = 7'b0000100;
            end
            4'd10:begin
                out1 = 7'b1001111;
                out2 = 7'b0000001;
            end
            4'd11:begin
                out1 = 7'b1001111;
                out2 = 7'b1001111;
            end
            4'd12:begin
                out1 = 7'b1001111;
                out2 = 7'b0010010;
            end
            4'd13:begin
                out1 = 7'b1001111;
                out2 = 7'b0000110;
            end
            4'd14:begin
                out1 = 7'b1001111;
                out2 = 7'b1001100;
            end
            4'd15: begin
                out1 = 7'b1001111;
                out2 = 7'b0100100;
            end
            default: begin
                out1 = 7'b0000001;
                out2 = 7'b0000001;    
            end
        endcase
    end
endmodule


module debounce (pb_debounced, pb, clk);
    output pb_debounced; // signal of a pushbutton after being debounced
    input pb; // signal from a pushbutton
    input clk;

    reg [3:0] DFF; // use shift_reg to filter pushbutton bounce
    
    always @(posedge clk)begin
            DFF[3:1] <= DFF[2:0];
            DFF[0] <= pb;
    end
    
    assign pb_debounced = ((DFF == 4'b1111) ? 1'b1 : 1'b0);
endmodule

module onepulse (PB_debounced, CLK, PB_one_pulse);
    input PB_debounced;
    input CLK;
    output reg PB_one_pulse;
    reg PB_debounced_delay;
    always @(posedge CLK) begin
        PB_one_pulse = PB_debounced & (! PB_debounced_delay);
        PB_debounced_delay = PB_debounced;
    end
endmodule

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
    initial counter <= min;
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

module Clock_Divider (clk, rst_n, sel, clk1_2, clk1_4, clk1_8, clk1_3, dclk);
    input clk, rst_n;
    input [2-1:0] sel;
    output clk1_2;
    output clk1_4;
    output clk1_8;
    output clk1_3;
    output dclk;
    
    reg[30:0] counter = 4'd0;
    reg clk2 = 1'b0, clk4= 1'b0, clk8= 1'b0, clk3= 1'b0;
    
    assign clk1_2 = clk2;    
    assign clk1_3 = clk3;
    assign clk1_4 = clk4;
    assign clk1_8 = clk8;
    assign dclk = sel[1] ? (sel[0] ? clk1_8: clk1_4) : (sel[0]? clk1_2 : clk1_3);
    
    always @(posedge clk) begin
        if (rst_n==1'b0) begin //set condition when rst_n is 0 then we need to rest all to 0
            clk2 <= 1'b1;
            clk4 <= 1'b1;
            clk8 <= 1'b1;
            clk3 <= 1'b1;
            counter <= 4'b0;
            end
      
        else begin 
            counter = counter + 4'b1;
            clk2 <= (counter% (2**25)) ? 1'b0 : 1'b1;
            clk3 <= (counter% (2**25)) ? 1'b0 : 1'b1;
            clk4 <= (counter% (2**25)) ? 1'b0 : 1'b1;
            clk8 <= (counter% (2**25)) ? 1'b0 : 1'b1; 
            end
    end
    
//    always @(*) begin
//        case(sel)
//            2'b00 : dclk = clk3;
//            2'b01 : dclk = clk1_2;
//            2'b10 : dclk = clk1_4;
//            2'b11 : dclk = clk1_8;
//            default : dclk = 4'd0;
//        endcase
//    end
endmodule
