`timescale 1ns/1ps

module topmodule(bawah, tengah, high, mode, dir_switch, pmod_1, pmod_2, pmod_4, PS2_DATA, PS2_CLK, clk, a, s, d, f, g, h, j, k, w, e, t, y, u
    ,anode,cathode, transpose);
    inout wire PS2_DATA;
	inout wire PS2_CLK;
	input clk;
    input dir_switch;
    input mode, bawah, tengah, high, transpose;

	
	//audio output just need to set pmod_1
    output pmod_1; //ain
	output pmod_2; //gain
	output pmod_4; //turn off
    output [3:0] anode;
    output [6:0] cathode;
	
    assign pmod_2 = 1'd1; //no gain
    // assign pmod_4 = 1'd1; //on

	//keyboard stuffs
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    
    
	//to test keyboard
	output a, s, d, f, g, h, j, k;
    output w, e, t, y, u;
    //	assign a = (key_down[9'b0_0001_1100]) ? 1'b1 : 1'b0; //1C
    //	assign s = (key_down[9'b0_0001_1011]) ? 1'b1 : 1'b0; //1B
    //    assign d = (key_down[9'b0_0010_0011]) ? 1'b1 : 1'b0; //23
    //    assign f = (key_down[9'b0_0010_1011]) ? 1'b1 : 1'b0; //2B
    //	assign g = (key_down[9'b0_0011_0100]) ? 1'b1 : 1'b0; //34
    //	assign h = (key_down[9'b0_0011_0011]) ? 1'b1 : 1'b0; //33
    //    assign j = (key_down[9'b0_0011_1011]) ? 1'b1 : 1'b0; //3B
    //    assign k = (key_down[9'b0_0100_0010]) ? 1'b1 : 1'b0; //42
    
    //    assign w = (key_down[9'b0_0001_1101]) ? 1'b1 : 1'b0; //1D
    //	assign e = (key_down[9'b0_0010_0100]) ? 1'b1 : 1'b0; //24
    //	assign t = (key_down[9'b0_0010_1100]) ? 1'b1 : 1'b0; //2C
    //    assign y = (key_down[9'b0_0011_0101]) ? 1'b1 : 1'b0; //35
    //    assign u = (key_down[9'b0_0011_1100]) ? 1'b1 : 1'b0; //3C
        //get signal when keyboard pressed
    
    wire wa, ws, wd, wf, wg, wh, wj, wk;
    wire ww, we, wt, wy, wu;
	assign wa = (key_down[9'b0_0001_1100]) ? 1'b1 : 1'b0; //1C
	assign ws = (key_down[9'b0_0001_1011]) ? 1'b1 : 1'b0; //1B
    assign wd = (key_down[9'b0_0010_0011]) ? 1'b1 : 1'b0; //23
    assign wf = (key_down[9'b0_0010_1011]) ? 1'b1 : 1'b0; //2B
	assign wg = (key_down[9'b0_0011_0100]) ? 1'b1 : 1'b0; //34
	assign wh = (key_down[9'b0_0011_0011]) ? 1'b1 : 1'b0; //33
    assign wj = (key_down[9'b0_0011_1011]) ? 1'b1 : 1'b0; //3B
    assign wk = (key_down[9'b0_0100_0010]) ? 1'b1 : 1'b0; //42

    assign ww = (key_down[9'b0_0001_1101]) ? 1'b1 : 1'b0; //1D
	assign we = (key_down[9'b0_0010_0100]) ? 1'b1 : 1'b0; //24
	assign wt = (key_down[9'b0_0010_1100]) ? 1'b1 : 1'b0; //2C
    assign wy = (key_down[9'b0_0011_0101]) ? 1'b1 : 1'b0; //35
    assign wu = (key_down[9'b0_0011_1100]) ? 1'b1 : 1'b0; //3C
    

    reg finalspeed;
    wire w1,w2,w3,w4,w5,w6,w7,w8;
    //1 0_0001_0110 .
//2 0_0001_1110 .
//3 0_0010_0110 .
//4 0_0010_0101.
//5 0_0010_1110
//6 0_0011_0110
//7 0_0011_1101
//8 0_0011_1110
    assign w1 = (key_down[9'b0_0001_0110]) ? 1'b1: 1'b0;
    assign w2 = (key_down[9'b0_0001_1110]) ? 1'b1: 1'b0;
    assign w3 = (key_down[9'b0_0010_0110]) ? 1'b1: 1'b0;
    assign w4 = (key_down[9'b0_0010_0101]) ? 1'b1: 1'b0;
    assign w5 = (key_down[9'b0_0010_1110]) ? 1'b1: 1'b0;
    assign w6 = (key_down[9'b0_0011_0110]) ? 1'b1: 1'b0;
    assign w7 = (key_down[9'b0_0011_1101]) ? 1'b1: 1'b0;
    assign w8 = (key_down[9'b0_0011_1110]) ? 1'b1: 1'b0;

    wire chosenspeed;
    allclock allspeeds(clk, chosenspeed, w1,w2,w3,w4,w5,w6,w7,w8);

    wire bpm120, bpm60, bpm180;

    divider60 enampuluh(clk, bpm60);
    divider120 seratusduapuluh(clk, bpm120);
    divider180 seratusdelapanpuluh(clk, bpm180);

    KeyboardDecoder kbdecoder0(
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    ); 
    
    wire [47-1:0] getTone; wire [31:0]freq; wire[13-1:0] just;
    wire [47-1:0] getTone2; wire[13-1:0] just2;
    //KeyBoardInputToTone(a,s,d,f,g,h,j,k, w,e,t,y,u, tone);



    // PWM_gen clock(clk, enterk, freq, 10'd512, pmod_1); 
    KeyBoardInputToTone translator(wa,ws,wd,wf,wg,wh,wj,wk, ww,we,wt,wy,wu, clk, chosenspeed, getTone, just, dir_switch, bawah, tengah, high, transpose);
    KeyBoardInputToTonetoingtoing bolakbalik(wa,ws,wd,wf,wg,wh,wj,wk, ww,we,wt,wy,wu, clk, chosenspeed, getTone2, just2, dir_switch
     ,bawah, tengah, high, transpose);
    
    //assign {a,s,d,f,g,h,j,k,w,e,t,y,u} = just;
    assign a = (key_down[9'b0_0001_1100]) ? 1'b1 : 1'b0; //1C
	assign s = (key_down[9'b0_0001_1011]) ? 1'b1 : 1'b0; //1B
    assign d = (key_down[9'b0_0010_0011]) ? 1'b1 : 1'b0; //23
    assign f = (key_down[9'b0_0010_1011]) ? 1'b1 : 1'b0; //2B
	assign g = (key_down[9'b0_0011_0100]) ? 1'b1 : 1'b0; //34
	assign h = (key_down[9'b0_0011_0011]) ? 1'b1 : 1'b0; //33
    assign j = (key_down[9'b0_0011_1011]) ? 1'b1 : 1'b0; //3B
    assign k = (key_down[9'b0_0100_0010]) ? 1'b1 : 1'b0; //42

    assign w = (key_down[9'b0_0001_1101]) ? 1'b1 : 1'b0; //1D
	assign e = (key_down[9'b0_0010_0100]) ? 1'b1 : 1'b0; //24
	assign t = (key_down[9'b0_0010_1100]) ? 1'b1 : 1'b0; //2C
    assign y = (key_down[9'b0_0011_0101]) ? 1'b1 : 1'b0; //35
    assign u = (key_down[9'b0_0011_1100]) ? 1'b1 : 1'b0; //3C

    reg [47-1:0] chosentone;
    wire [47-1:0] finaltone;
    always@(*) begin
        if(mode) chosentone = getTone;
        else chosentone = getTone2;
    end

    assign finaltone = chosentone;
    
    AudioDecoder audiodecoder0(finaltone, freq);

    wire [32-1:0] audio_out;
    //KarplusStrong filter(clk, reset, freq, decay, 1'b1, audio_out);
    //KarplusStrong filter(clk, dir_switch, freq, 1'b1, 1'b1, audio_out);
    assign pmod_4 = (finaltone == 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000)
    ? 1'd0 : 1'd1;//(freq == 31'd0) ? 1'd0 : 1'd1;
   PWM_gen pmwgen0(clk, enterk, freq, 10'd512, pmod_1);
   // PWM_gen pmwgen0(clk, enterk, audio_out, 10'd512, pmod_1);

    anodecathode sevensegment(freq, clk, anode, cathode);

endmodule

module allclock(clk,out,w1,w2,w3,w4,w5,w6,w7,w8);
    input clk, w1,w2,w3,w4,w5,w6,w7,w8;
    output out;

    reg tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8;
    reg [8-1:0]curstate;

    reg [30:0] choose_time;
    reg [30:0] chosen;

    always @(posedge clk) begin
        // state <= nextstate.
        curstate <= {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8};
        chosen <= choose_time;
    end

    always@(*) begin
        //nextstate, output
        case({w1,w2,w3,w4,w5,w6,w7,w8})
            8'b1000_0000: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b1000_0000;
            8'b0100_0000: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0100_0000;
            8'b0010_0000: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0010_0000;
            8'b0001_0000: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0001_0000;
            8'b0000_1000: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0000_1000;
            8'b0000_0100: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0000_0100;
            8'b0000_0010: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0000_0010;
            8'b0000_0001: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = 8'b0000_0001;
            default: {tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8} = curstate;//{tw1,tw2,tw3,tw4,tw5,tw6,tw7,tw8};
        endcase
        case(curstate)
            8'b1000_0000: choose_time = 30'd50_000_000;
            8'b0100_0000: choose_time = 30'd25_000_000;
            8'b0010_0000: choose_time = 30'd16_675_000;
            8'b0001_0000: choose_time = 30'd12_500_000;
            8'b0000_1000: choose_time = 30'd10_000_000;
            8'b0000_0100: choose_time = 30'd8_333_333;
            8'b0000_0010: choose_time = 30'd7_150_000;
            8'b0000_0001: choose_time = 30'd6_250_000;
            default: choose_time = 30'd16_675_000;
        endcase
    end

    divider_custom go(clk, out, chosen,w1,w2,w3,w4,w5,w6,w7,w8);

endmodule

module divider_custom(clk, out, chosen,w1,w2,w3,w4,w5,w6,w7,w8);
    input clk ,w1,w2,w3,w4,w5,w6,w7,w8;
    output reg out;
    
    input [30:0] chosen;
    reg [30:0]cnt;
    
    
    always @(posedge clk)begin
        if(w1 || w2 ||  w3 || w4 || w5 || w6 || w7 || w8) begin
            cnt<=30'd0;
            out<=1'd0;
        end else begin
            if(cnt == chosen)begin
            //if(cnt == 30'd200_000_000)begin
                cnt <= 30'd0;
                out <= 1'd1;
            end
            else begin
                cnt <= cnt + 1'b1;
                out <= 1'd0;
            end
        end
    end
endmodule


// //100MHz so 100 000 000/s so 100 000 000 cyc = 1 sec
module divider30(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd50_000_000)begin
        //if(cnt == 30'd200_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

module divider60(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd25_000_000)begin
        //if(cnt == 30'd100_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

module divider90(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd16_675_000)begin
        //if(cnt == 30'd66_700_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

//100MHz so 100 000 000/s so 50 000 000 cyc = 0.5 sec
module divider120(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd12_500_000)begin
        //if(cnt == 30'd50_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

module divider150(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd10_000_000)begin
        //if(cnt == 30'd40_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

module divider180(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd8_333_333)begin
        //if(cnt == 30'd33_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

module divider210(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd7_150_000)begin
        //if(cnt == 30'd028_600_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

//100MHz so 100 000 000/s so 25 000 000 cyc = 0.25 sec
module divider240(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd6_250_000)begin
        //if(cnt == 30'd25_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule

module PWM_gen (
    input wire clk,
    input wire reset,
	input [31:0] freq,
    input [9:0] duty,
    output reg PWM
);

    wire [31:0] count_max = 100_000_000 / freq;
    wire [31:0] count_duty = count_max * duty / 1024;
    reg [31:0] count;
        
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 0;
            PWM <= 0;
        end else if (count < count_max) begin
            count <= count + 1;
            if(count < count_duty)
                PWM <= 1;
            else
                PWM <= 0;
        end else begin
            count <= 0;
            PWM <= 0;
        end
    end
    
endmodule

module OnePulse (op, butt, clk);
    output op;
    input butt;
    input clk;
    reg signal_delay;
    reg op;
    
    always @(posedge clk) begin
        if (butt == 1'b1 & signal_delay == 1'b0) begin
            op <= 1'b1;
        end else begin 
            op <= 1'b0;
        end
        signal_delay <= butt;
        
    end
endmodule



module KeyboardDecoder(
    output reg [511:0] key_down,
    output wire [8:0] last_change,
    output reg key_valid,
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    input wire rst,
    input wire clk
    );
    
    parameter [1:0] INIT			= 2'b00;
    parameter [1:0] WAIT_FOR_SIGNAL = 2'b01;
    parameter [1:0] GET_SIGNAL_DOWN = 2'b10;
    parameter [1:0] WAIT_RELEASE    = 2'b11;
    
    parameter [7:0] IS_INIT			= 8'hAA;
    parameter [7:0] IS_EXTEND		= 8'hE0;
    parameter [7:0] IS_BREAK		= 8'hF0;
    
    reg [9:0] key, next_key;		// key = {been_extend, been_break, key_in}
    reg [1:0] state, next_state;
    reg been_ready, been_extend, been_break;
    reg next_been_ready, next_been_extend, next_been_break;
    
    wire [7:0] key_in;
    wire is_extend;
    wire is_break;
    wire valid;
    wire err;
    
    wire [511:0] key_decode = 1 << last_change;
    assign last_change = {key[9], key[7:0]};
    
    KeyboardCtrl_0 inst (
        .key_in(key_in),
        .is_extend(is_extend),
        .is_break(is_break),
        .valid(valid),
        .err(err),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    
    OnePulse op (
        .op(pulse_been_ready),
        .butt(been_ready),
        .clk(clk)
    );
    
    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            state <= INIT;
            been_ready  <= 1'b0;
            been_extend <= 1'b0;
            been_break  <= 1'b0;
            key <= 10'b0_0_0000_0000;
        end else begin
            state <= next_state;
            been_ready  <= next_been_ready;
            been_extend <= next_been_extend;
            been_break  <= next_been_break;
            key <= next_key;
        end
    end
    
    always @ (*) begin
        case (state)
            INIT:            next_state = (key_in == IS_INIT) ? WAIT_FOR_SIGNAL : INIT;
            WAIT_FOR_SIGNAL: next_state = (valid == 1'b0) ? WAIT_FOR_SIGNAL : GET_SIGNAL_DOWN;
            GET_SIGNAL_DOWN: next_state = WAIT_RELEASE;
            WAIT_RELEASE:    next_state = (valid == 1'b1) ? WAIT_RELEASE : WAIT_FOR_SIGNAL;
            default:         next_state = INIT;
        endcase
    end
    always @ (*) begin
        next_been_ready = been_ready;
        case (state)
            INIT:            next_been_ready = (key_in == IS_INIT) ? 1'b0 : next_been_ready;
            WAIT_FOR_SIGNAL: next_been_ready = (valid == 1'b0) ? 1'b0 : next_been_ready;
            GET_SIGNAL_DOWN: next_been_ready = 1'b1;
            WAIT_RELEASE:    next_been_ready = next_been_ready;
            default:         next_been_ready = 1'b0;
        endcase
    end
    always @ (*) begin
        next_been_extend = (is_extend) ? 1'b1 : been_extend;
        case (state)
            INIT:            next_been_extend = (key_in == IS_INIT) ? 1'b0 : next_been_extend;
            WAIT_FOR_SIGNAL: next_been_extend = next_been_extend;
            GET_SIGNAL_DOWN: next_been_extend = next_been_extend;
            WAIT_RELEASE:    next_been_extend = (valid == 1'b1) ? next_been_extend : 1'b0;
            default:         next_been_extend = 1'b0;
        endcase
    end
    always @ (*) begin
        next_been_break = (is_break) ? 1'b1 : been_break;
        case (state)
            INIT:            next_been_break = (key_in == IS_INIT) ? 1'b0 : next_been_break;
            WAIT_FOR_SIGNAL: next_been_break = next_been_break;
            GET_SIGNAL_DOWN: next_been_break = next_been_break;
            WAIT_RELEASE:    next_been_break = (valid == 1'b1) ? next_been_break : 1'b0;
            default:         next_been_break = 1'b0;
        endcase
    end
    always @ (*) begin
        next_key = key;
        case (state)
            INIT:            next_key = (key_in == IS_INIT) ? 10'b0_0_0000_0000 : next_key;
            WAIT_FOR_SIGNAL: next_key = next_key;
            GET_SIGNAL_DOWN: next_key = {been_extend, been_break, key_in};
            WAIT_RELEASE:    next_key = next_key;
            default:         next_key = 10'b0_0_0000_0000;
        endcase
    end

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            key_valid <= 1'b0;
            key_down <= 511'b0;
        end else if (key_decode[last_change] && pulse_been_ready) begin
            key_valid <= 1'b1;
            if (key[8] == 0) begin
                key_down <= key_down | key_decode;
            end else begin
                key_down <= key_down & (~key_decode);
            end
        end else begin
            key_valid <= 1'b0;
            key_down <= key_down;
        end
    end

endmodule



module AudioDecoder (tone, freq);    
	input [47-1:0] tone;
	output reg [32-1:0] freq;
    always @(*) begin
        case (tone)
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001: freq = 32'd131; //c3
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0010: freq = 32'd139; //C#
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0100: freq = 32'd147; //D
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_1000: freq = 32'd156; //D#
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0001_0000: freq = 32'd165; //E
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0010_0000: freq = 32'd175; //F
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0100_0000: freq = 32'd185; //F#
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_1000_0000: freq = 32'd196; //G
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0001_0000_0000: freq = 32'd208; //G#
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0010_0000_0000: freq = 32'd220; //A
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_0100_0000_0000: freq = 32'd233; //A#
            46'b000_000_0000_0000_0000_0000_0000_0000_0000_1000_0000_0000: freq = 32'd247; //B
            46'b000_000_0000_0000_0000_0000_0000_0000_0001_0000_0000_0000: freq = 32'd261; //c4

            46'b000_000_0000_0000_0000_0000_0000_0000_0010_0000_0000_0000: freq = 32'd262; //c4
            46'b000_000_0000_0000_0000_0000_0000_0000_0100_0000_0000_0000: freq = 32'd277; //C#
            46'b000_000_0000_0000_0000_0000_0000_0000_1000_0000_0000_0000: freq = 32'd293; //D
            46'b000_000_0000_0000_0000_0000_0000_0001_0000_0000_0000_0000: freq = 32'd311; //D#
            46'b000_000_0000_0000_0000_0000_0000_0010_0000_0000_0000_0000: freq = 32'd329; //E
            46'b000_000_0000_0000_0000_0000_0000_0100_0000_0000_0000_0000: freq = 32'd349; //F
            46'b000_000_0000_0000_0000_0000_0000_1000_0000_0000_0000_0000: freq = 32'd370; //F#
            46'b000_000_0000_0000_0000_0000_0001_0000_0000_0000_0000_0000: freq = 32'd392; //G
            46'b000_000_0000_0000_0000_0000_0010_0000_0000_0000_0000_0000: freq = 32'd415; //G#
            46'b000_000_0000_0000_0000_0000_0100_0000_0000_0000_0000_0000: freq = 32'd440; //A
            46'b000_000_0000_0000_0000_0000_1000_0000_0000_0000_0000_0000: freq = 32'd466; //A#
            46'b000_000_0000_0000_0000_0001_0000_0000_0000_0000_0000_0000: freq = 32'd494; //B

            46'b000_000_0000_0000_0000_0010_0000_0000_0000_0000_0000_0000: freq = 32'd523; //C5
            46'b000_000_0000_0000_0000_0100_0000_0000_0000_0000_0000_0000: freq = 32'd554; //C#
            46'b000_000_0000_0000_0000_1000_0000_0000_0000_0000_0000_0000: freq = 32'd587; //D
            46'b000_000_0000_0000_0001_0000_0000_0000_0000_0000_0000_0000: freq = 32'd622; //D#
            46'b000_000_0000_0000_0010_0000_0000_0000_0000_0000_0000_0000: freq = 32'd659; //E
            46'b000_000_0000_0000_0100_0000_0000_0000_0000_0000_0000_0000: freq = 32'd698; //F
            46'b000_000_0000_0000_1000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd740; //F#
            46'b000_000_0000_0001_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd784; //G
            46'b000_000_0000_0010_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd831; //G#
            46'b000_000_0000_0100_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd880; //A
            46'b000_000_0000_1000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd932; //A#
            46'b000_000_0001_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd988; //B
            46'b000_000_0010_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1047; //C6
            // 43'b000_0100_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 1047;

            46'b000_000_0100_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1108; //C#
            46'b000_000_1000_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1175; //D
            46'b000_001_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1245; //D#
            46'b000_010_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1319; //E
            46'b000_100_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1397; //F
            46'b001_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1480; //F#
            46'b010_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000: freq = 32'd1567; //G
            // 43'b000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001: freq = 32'd261; // C4
            // 43'b000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0010: freq = 32'd277; // C#
            // 43'b000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0100: freq = 32'd293; // D
            // 29'b0_0000_0000_0000_0000_0000_0000_1000: freq = 32'd311; // Eb
            // 29'b0_0000_0000_0000_0000_0000_0001_0000: freq = 32'd329; // E
            // 29'b0_0000_0000_0000_0000_0000_0010_0000: freq = 32'd349; // F
            // 29'b0_0000_0000_0000_0000_0000_0100_0000: freq = 32'd370; // F sharp
            // 29'b0_0000_0000_0000_0000_0000_1000_0000: freq = 32'd392; // G
            // 29'b0_0000_0000_0000_0000_0001_0000_0000: freq = 32'd415; // G sharp
            // 29'b0_0000_0000_0000_0000_0010_0000_0000: freq = 32'd440; // A
            // 29'b0_0000_0000_0000_0000_0100_0000_0000: freq = 32'd466; // A#
            // 29'b0_0000_0000_0000_0000_1000_0000_0000: freq = 32'd494; // B
            // 29'b0_0000_0000_0000_0001_0000_0000_0000: freq = 32'd523; // C5
            
            // 29'b0_0000_0000_0000_0010_0000_0000_0000: freq = 32'd554; //C#
            // 29'b0_0000_0000_0000_0100_0000_0000_0000: freq = 32'd587; //D
            // 29'b0_0000_0000_0000_1000_0000_0000_0000: freq = 32'd622; //Eb
            // 29'b0_0000_0000_0001_0000_0000_0000_0000: freq = 32'd659; //E
            // 29'b0_0000_0000_0010_0000_0000_0000_0000: freq = 32'd698; //F
            // 29'b0_0000_0000_0100_0000_0000_0000_0000: freq = 32'd740; //F#
            // 29'b0_0000_0000_1000_0000_0000_0000_0000: freq = 32'd784; //G
            // 29'b0_0000_0001_0000_0000_0000_0000_0000: freq = 32'd831; //G#
            // 29'b0_0000_0010_0000_0000_0000_0000_0000: freq = 32'd880; //A
            // 29'b0_0000_0100_0000_0000_0000_0000_0000: freq = 32'd932; //A#
            // 29'b0_0000_1000_0000_0000_0000_0000_0000: freq = 32'd988; // B
            // 29'b0_0001_0000_0000_0000_0000_0000_0000: freq = 32'd1047; //C6
            
            // 29'b1_0000_0000_0000_0000_0000_0000_0000: freq = 32'd493 << 4;
                       
            default : freq = 32'd18500;	//Do-dummy
        endcase
    end
endmodule

module dispclk(clk, out);
    input clk;
    output reg [1:0]out;

    reg [30:0]cnt;

    always @(posedge clk)begin
        cnt <= cnt + 1'b1;
        out <= cnt[18:17];

    end
endmodule

module anodecathode(bal, clk, anode, cathode);
    input [31:0] bal;
    input clk;
    output reg [3:0] anode;
    output [6:0] cathode;
    
    reg[31:0] digit;
    getcathode gc0(digit, cathode);
    
    wire [1:0] clkdisp;
    dispclk clk1(clk, clkdisp);    
    always @(*) begin
        case(clkdisp)
            2'b00:begin
                anode = 4'b1110;
                digit = ((bal % 100) % 10);
            end
            2'b01:begin
                anode = 4'b1101;
                if(bal < 10) digit = 4'd10;
                else digit = (bal % 100) / 10;
            end
            2'b10:begin
                anode = 4'b1011;
                if(bal < 100) digit = 4'd10;
                else digit =(bal % 1000) / 100;
            end
            2'b11:begin
                anode = 4'b0111;
                if(bal < 1000) digit = 4'd10;
                else digit = (bal % 10000) / 1000;
            end
            default:begin
                anode = 4'b1111;
                digit = 4'd10;
            end
        endcase

    end
endmodule

module getcathode(digit, cathode);
    input [31:0] digit;
    output reg [6:0] cathode;
    always@(*) begin        
        case(digit)
            32'd0: cathode = 7'b0000001;
            32'd1: cathode = 7'b1001111;
            32'd2: cathode = 7'b0010010;
            32'd3: cathode = 7'b0000110;
            32'd4: cathode = 7'b1001100;
            32'd5: cathode = 7'b0100100;
            32'd6: cathode = 7'b0100000;
            32'd7: cathode = 7'b0001111;
            32'd8: cathode = 7'b0000000;
            32'd9: cathode = 7'b0000100;
            default: cathode = 7'b1111111;
        endcase
    end
endmodule