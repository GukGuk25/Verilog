`timescale 1ns / 1ps
module babi(clk, resetb, enterb, startb, sw, anode, cathode, led);
    input clk;
    input resetb;
    input enterb;
    input startb;
    input[4-1:0] sw;
    output [3:0] anode;
    output [6:0] cathode;
    output reg [16-1:0] led;
    
    reg [25:0] refresh;
    wire changestate;


    wire clk_div;
    //module Clock_Divider(clk, clk_div);
    Clock_Divider cd(clk, clk_div);
    
    wire dbenter, dbreset, dbstart ;
    //module debounce (pb_debounced, pb, clk);
    debounce db_enter(dbenter, enterb, clk);
    debounce db_start(dbstart, startb, clk);
    debounce db_reset(dbreset, resetb, clk);
    wire openter, opreset, opstart;
    //module onepulse (PB_debounced, CLK, PB_one_pulse);
    onepulse op_enter(dbenter, clk_div, openter);
    onepulse op_start(dbstart, clk_div, opstart);
    onepulse op_reset(dbreset, clk_div, opreset);
    
    reg[3:0] rand0, rand1, rand2, rand3, dummy0, dummy1, dummy2, dummy3;
    wire[15:0] led2;
    //module getnewdata(clk, rst_n, button, num0, num1, num2, num3);
    getnewdata RNG(clk_rand, rst_n, opreset, dummy0, dummy1, dummy2, dummy3, led2);
    always@(*)begin
        rand0 = led2[3:0];  
        rand1 = led2[7:4];
        rand2 = led2[11:8];
        rand3 = led2[15:12];
    end
    wire [6:0] c1, c2, c3, c0;
    reg [4-1:0] answer [4-1:0];
    reg [4-1:0] guess0, guess1, guess2, guess3;
    reg [16-1:0] jawab;
    reg [4-1:0] next_guess [4-1:0];
    
    parameter title = 4'd0;
    parameter guessing0 = 4'd1;
    parameter guessing1 = 4'd2;
    parameter guessing2 = 4'd3;
    parameter guessing3 = 4'd4;
    parameter check_phase = 4'd5;
    parameter decision_phase = 4'd6;
    parameter reset_input = 4'd7;
    parameter guessing4 = 4'd8;
    
    reg[4-1:0] current_state, next_state, regflag;
    reg [4-1:0] holding;
    reg current_holding;
    reg next_holding;
    
    always@(posedge clk) begin
        if(opreset) begin 
            current_state <= title;
            current_holding <= 1'b1;
            answer[0] <= rand0;
            answer[1] <= rand1;
            answer[2] <= rand2;
            answer[3] <= rand3;
        end
        else begin
         current_state <= next_state;
            current_holding <= next_holding;
//            answer[0] <=4'd8;//<= answer[0];
//            answer[1] <=4'd8;//<= answer[1];
//            answer[2] <=4'd8;//<= answer[2];
//            answer[3] <=4'd8;//<= answer[3];
            
            guess0 <= next_guess[0];
            guess1 <= next_guess[1];
            guess2 <= next_guess[2];
            guess3 <= next_guess[3];
         end
    end
    
    reg [26:0] one_second_counter;
    wire one_second_enable;
    always @(posedge clk or posedge opreset)
    begin
        if(opreset==1)
            one_second_counter <= 0;
        else begin
            if(one_second_counter>=20000000) 
                 one_second_counter <= 0;
            else
                one_second_counter <= one_second_counter + 1;
        end
    end 
    assign one_second_enable = (one_second_counter==20000000)?1:0;
   
    assign changestate = refresh[19];
    
    reg[4-1:0] total_a, total_b;
    
    
    always@(*) begin
        case(current_state)
            title: begin
                led = 16'b0;
                next_state = title;
                total_a = 4'b00; total_b=4'b00; regflag = 4'b0;
                next_guess[0] = 4'b0; next_guess[1] = 4'b0; 
                next_guess[2] = 4'b0; next_guess[3] = 4'b0;
            
                if(opstart && current_holding !=1) begin
                    next_state = guessing0;
                    next_holding = 1'b1;
                end
                next_holding = 1'b0;
            end
            guessing0: begin
                led = {answer[3],answer[2],answer[1],answer[0]};
                next_state = guessing0;
                next_guess[0] = sw;
                if(openter && one_second_enable) begin
                    next_state = guessing1;
                    holding[0] = 1'b1;
                end
                next_holding = 1'b0;
            end
            guessing1: begin
                //led = {guess0, guess1, guess2, guess3};
                led = {answer[3],answer[2],answer[1],answer[0]};
                next_state = guessing1;
                holding[0] = 1'b0;
                next_guess[1] = sw;
                if(openter && one_second_enable) begin
                    next_state = guessing2;
                    holding[1] = 1'b1;
                end
                next_holding = 1'b0;
            end
            guessing2: begin
                led = {answer[3],answer[2],answer[1],answer[0]};
                next_state = guessing2;
                next_guess[2] = sw;
                holding[0] = 1'b0;
                holding[1] = 1'b0;
                if(openter  && one_second_enable) begin
                    next_state = guessing3;
                    next_holding = 1'b1;
                    holding[2] = 1'b1;
                end
                next_holding = 1'b0;
            end
            guessing3: begin
                led = {answer[3],answer[2],answer[1],answer[0]};
                next_state = guessing3;
                next_guess[3] = sw;
                holding[0] = 1'b0;
                holding[1] = 1'b0;
                holding[2] = 1'b0;
                if(openter  &&one_second_enable) begin
                    next_state = check_phase;
                    next_holding = 1'b1;
                    holding[3] = 1'b1;
                end
                next_holding = 1'b0;
            end
            guessing4: begin
                next_state = guessing4;
                if(opstart && one_second_enable) begin
                    next_state = check_phase;
                end
            end
            check_phase: begin
            next_state = check_phase;
            if(one_second_enable) begin
                 if(answer[0] == guess0) begin total_a = total_a+1'b1; regflag[0] = 1'b1; end
                     if(answer[1] == guess1) begin total_a = total_a+1'b1; regflag[1] = 1'b1; end
                     if(answer[2] == guess2) begin total_a = total_a+1'b1; regflag[2] = 1'b1; end
                     if(answer[3] == guess3) begin total_a = total_a+1'b1; regflag[3] = 1'b1; end
                     if(!regflag[0])
                         if(guess0 == answer[0] || guess0 == answer[1] ||
                         guess0 == answer[2] || guess0 == answer[3])
                             total_b = total_b +1'b1;
                     if(!regflag[1])
                         if(guess1 == answer[0] || guess1 == answer[1] ||
                         guess1 == answer[2] || guess1 == answer[3])
                             total_b = total_b +1'b1;
                     if(!regflag[2])
                         if(guess2 == answer[0] || guess2 == answer[1] ||
                         guess2 == answer[2] || guess2 == answer[3])
                             total_b = total_b +1'b1;
                     if(!regflag[3])
                         if(guess3 == answer[0] || guess3 == answer[1] ||
                         guess3 == answer[2] || guess3 == answer[3])
                             total_b = total_b +1'b1;
                     next_state = decision_phase;
                 end else begin
                     total_a = total_a;
                     total_b = total_b;
                    next_state = decision_phase;
                end
            end
            decision_phase: begin
            led = {answer[3],answer[2],answer[1],answer[0]};
                next_state = decision_phase;
                if(total_a==4'd4 && total_b == 4'd0) begin
                    if(openter || opstart) begin
                        next_state = title;
                    end
                end
                else if(openter && one_second_enable) begin
                    next_state = reset_input;
                end
            end
            reset_input : begin
                next_state = guessing0;
//                total_a =0; total_b=0; 
                next_guess[0] = 4'b0; next_guess[1] = 4'b0; 
                next_guess[2] = 4'b0; next_guess[3] = 4'b0;
            end
        endcase
    end
    
    
    seven_segment_control go(sw, clk, current_state, anode, cathode, opreset, openter,
    guess0, guess1, guess2, guess3, total_a, total_b, selected_num
);
    
endmodule

module seven_segment_control (sw, clk, current_state, anode, cathode, reset, enter,
    guess1, guess2, guess3, guess4, total_a, total_b, selected_num
);
    input clk;
    input [4-1:0] sw;
    input [4-1:0] current_state;
    input [4-1:0] guess1, guess2, guess3, guess4;
    input [2-1:0] total_a, total_b;
    input [2-1:0] selected_num;
    input reset, enter;
    output reg [4-1:0] anode;
    output reg [7-1:0] cathode;
    
    parameter title = 4'd0;
    parameter guessing0 = 4'd1;
    parameter guessing1 = 4'd2;
    parameter guessing2 = 4'd3;
    parameter guessing3 = 4'd4;
    
    parameter check_phase = 4'd5;
    parameter decision_phase = 4'd6;
    parameter reset_input = 4'd7;
    parameter guessing4 = 4'd8;
    
    wire [4-1:0] copy_num[4-1:0];
    wire clkdiv;
    
    wire [7-1:0] copy3_ubah, copy2_ubah, copy1_ubah, copy0_ubah, swubah;
    wire [7-1:0] total_a_conv, total_b_conv;
    
    convert_to_disp digit3(guess4, copy3_ubah);
    convert_to_disp digit2(guess3, copy2_ubah);
    convert_to_disp digit1(guess2, copy1_ubah);
    convert_to_disp firstdigit(guess1, copy0_ubah);
    convert_to_disp digit0(sw, swubah);
    
    convert_to_disp tot_a({2'b00, total_a}, total_a_conv);
    convert_to_disp tot_b({2'b00, total_b}, total_b_conv);
    
    reg [25:0] refresh;
    wire [2-1:0] chooseled;
    always @(posedge clk or posedge reset)
    begin 
        if(reset==1)
            refresh <= 0;
        else
            refresh <= refresh + 1;
    end 
    assign chooseled = refresh[19:18];
    
    wire flicker;
    Flicker7 flickthis(clk, flicker);
    
    always@(*) begin
        case(current_state)
        title: begin
            if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = 7'b1001111;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = 7'b0001000; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = 7'b0010010;
            end else if(chooseled == 3) begin
                anode = 4'b1110;
                cathode = 7'b1100000; 
            end
        end
        guessing0: begin
            if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = 7'b0000001;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = 7'b0000001; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = 7'b0000001;
            end else if(chooseled == 3) begin
                anode = {4'b111, flicker};
                cathode = swubah; 
            end
        end
        guessing1: begin
            if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = 7'b0000001;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = 7'b0000001; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = copy0_ubah;
            end else if(chooseled == 3) begin
                anode = {4'b111, flicker};
                cathode = swubah; 
            end
        end 
        guessing2: begin
            if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = 7'b0000001;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = copy0_ubah; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = copy1_ubah;
            end else if(chooseled == 3) begin
                anode = {4'b111, flicker};
                cathode = swubah; 
            end
        end
        guessing3: begin
            if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = copy0_ubah;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = copy1_ubah; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = copy2_ubah;
            end else if(chooseled == 3) begin
                anode = {4'b111, flicker};
                cathode = swubah; 
            end
        end
        guessing4: begin
            if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = copy0_ubah;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = copy1_ubah; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = copy2_ubah;
            end else if(chooseled == 3) begin
                anode = {4'b111, flicker};
                cathode = copy3_ubah;
            end
        end
        decision_phase: begin
        if(chooseled == 0) begin
                anode = 4'b0111;
                cathode = total_a_conv;
            end else if(chooseled == 1) begin
                anode = 4'b1011;
                cathode = 7'b0001000; //A
            end else if(chooseled == 2) begin
                anode = 4'b1101;
                cathode = total_b_conv;
            end else if(chooseled == 3) begin
                anode = {4'b1110};
                cathode = 7'b1100000; //B
            end
        end   
        endcase
    end
    
    
endmodule


module getnewdata(clk, rst_n, button, num0, num1, num2, num3, out);
    input button;
    input clk;
    input rst_n;
    output reg [3:0] num3;
    output reg [3:0] num2;
    output reg [3:0] num1;
    output reg [3:0] num0;
    output reg [15:0] out;
    
    wire [15:0] out2;
    wire [3:0]temp0;
    wire [3:0]temp1;
    wire [3:0]temp2;
    wire [3:0]temp3;
    wire [15:0]dummy;    
    random rndm(clk, rst_n, dummy , temp3, temp2, temp1, temp0, out2);
    always@(posedge clk)begin
        if(button)begin
            num3 <= temp3;
            num2 <= temp2;
            num1 <= temp1;
            num0 <= temp0;
            out <= out2;
        end else begin
            num3 <= num3;
            num2 <= num2;
            num1 <= num1;
            num0 <= num0;
            out <= out;
        end
    end

endmodule

module shiftnumber(in4, in3, in2, in1, out4, out3, out2, out1, shift, clk);
    input [3:0] in1, in2, in3, in4;
    input shift, clk;
    output reg [3:0] out1, out2, out3, out4;
    always@(posedge clk) begin
        if (shift == 1'd1) begin
            out4 <= in3;
            out3 <= in2;
            out2 <= in1;
            out1 <= in4;
        end
    end
endmodule

module convert_to_disp(in, out);
    input [3:0] in;
    output reg [6:0] out;

    always@(*)begin
        case(in)
            4'd0: out = 7'b0000001;
            4'd1: out = 7'b1001111;
            4'd2: out = 7'b0010010;
            4'd3: out = 7'b0000110;
            4'd4: out = 7'b1001100;
            4'd5: out = 7'b0100100;
            4'd6: out = 7'b0100000;
            4'd7: out = 7'b0001111;
            4'd8: out = 7'b0000000;
            4'd9: out = 7'b0000100;
            
            4'd10: out = 7'b0001000; //A
            4'd11: out = 7'b1100000; //B
            4'd12: out = 7'b0110001; //C
            4'd13: out = 7'b1000010; //D
            4'd14: out = 7'b0110000; //E
            4'd15: out = 7'b0111000; //F
            default: out = 7'b1111111; //8
        endcase
    end
endmodule

module random(clk, rst_n, out , num3, num2, num1, num0, out2);
    input clk;
    input rst_n;
    output reg[3:0] num3;
    output reg[3:0] num2;
    output reg[3:0] num1;
    output reg[3:0] num0;
    output reg [16-1:0] out;
    output reg [15:0] out2;
    
    reg [16-1:0] num;
    reg [3:0]temp0;
    reg [3:0]temp1;
    reg [3:0]temp2;
    reg [3:0]temp3;
    always@(*)begin
        temp0 = out[3:0];
        temp1 = out[7:4];
        temp2 = out[11:8];
        temp3 = out[15:12];
        
        num0 = num[3:0];
        num1 = num[7:4];
        num2 = num[11:8];
        num3 = num[15:12];
        out2 = num;
    end

    always@(posedge clk)begin
        if(rst_n==1'd0) begin
            out <= 16'b1011110110100101;
        end else begin
        out[15:5] <= out [14:4];
        out[4] <= out[3] ^ out[15];
        out[3] <= out[2] ^ out[15];
        out[2] <= out[1] ^ out[15];
        out[1] <= out[0];
        out[0] <= out[15];
        end
        
        if(temp3 > 4'd9 || temp2 > 4'd9 || temp1 > 4'd9 || temp0 > 4'd9 || temp0 == temp1 || temp0 == temp2 || temp0 == temp3 || temp1 == temp2 || temp1 == temp3 || temp2 == temp3 ) begin
        out[15:5] <= out [14:4];
        out[4] <= out[3] ^ out[15];
        out[3] <= out[2] ^ out[15];
        out[2] <= out[1] ^ out[15];
        out[1] <= out[0];
        out[0] <= out[15];
            if(temp3 > 4'd9 || temp2 > 4'd9 || temp1 > 4'd9 || temp0 > 4'd9 || temp0 == temp1 || temp0 == temp2 || temp0 == temp3 || temp1 == temp2 || temp1 == temp3 || temp2 == temp3 ) begin
                out[15:5] <= out [14:4];
                out[4] <= out[3] ^ out[15];
                out[3] <= out[2] ^ out[15];
                out[2] <= out[1] ^ out[15];
                out[1] <= out[0];
                out[0] <= out[15];
                if(temp3 > 4'd9 || temp2 > 4'd9 || temp1 > 4'd9 || temp0 > 4'd9 || temp0 == temp1 || temp0 == temp2 || temp0 == temp3 || temp1 == temp2 || temp1 == temp3 || temp2 == temp3 ) begin
                    out[15:5] <= out [14:4];
                    out[4] <= out[3] ^ out[15];
                    out[3] <= out[2] ^ out[15];
                    out[2] <= out[1] ^ out[15];
                    out[1] <= out[0];
                    out[0] <= out[15];
                    if(temp3 > 4'd9 || temp2 > 4'd9 || temp1 > 4'd9 || temp0 > 4'd9 || temp0 == temp1 || temp0 == temp2 || temp0 == temp3 || temp1 == temp2 || temp1 == temp3 || temp2 == temp3 ) begin
                        num <= num;
                    end
                end
            end else begin
                num <= out;
            end
        end else begin
            num <= out;
        end
    end

endmodule

module randomdivider(clk, clk_div);
    input clk;
    output reg clk_div;
    
    reg[20:0] Counter;
    
    always @(posedge clk) Counter <= Counter + 1'b1;
    
    always @(*) clk_div = Counter[20]; 
    
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

module onepulse (PB_debounced, clk, PB_one_pulse);
     input PB_debounced;
     input clk;
     output PB_one_pulse;
     reg PB_one_pulse;
     reg PB_debounced_delay;
     always @(posedge clk) begin
         PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
         PB_debounced_delay <= PB_debounced;
     end
endmodule

module Clock_Divider(clk, clk_div);
    input clk;
    output reg clk_div;
    
    reg[23:0] Counter;
    
    always @(posedge clk) Counter <= Counter + 1'b1;
    
    always @(*) clk_div = Counter[23]; 
    
endmodule

module Flicker7(clk, flicker);
    input clk;
    output reg flicker;
    
    reg[27-1:0] count;
    
    always@(posedge clk) count <= count+1;
    always@(*) flicker = count[26];
endmodule