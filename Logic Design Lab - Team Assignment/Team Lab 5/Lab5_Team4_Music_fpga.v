`timescale 1ns/1ps

module topmodule(pmod_1, pmod_2, pmod_4, PS2_DATA, PS2_CLK, clk, enter, w, s, r, speed);
    inout wire PS2_DATA;
	inout wire PS2_CLK;
	input clk;
	
	//audio output just need to set pmod_1
    output pmod_1; //ain
	output pmod_2; //gain
	output pmod_4; //turn off
	
    assign pmod_2 = 1'd1; //no gain
    assign pmod_4 = 1'd1; //on

	//keyboard stuffs
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    
    
	//to test keyboard
	output enter;
	output w;
	output s;
	output r;
    assign enter = (key_down[16'b0_0101_1010]) ? 1'b1 : 1'b0;
	assign w = (key_down[9'b0_0001_1101]) ? 1'b1 : 1'b0;
	assign s = (key_down[9'b0_0001_1011]) ? 1'b1 : 1'b0;
    assign r = (key_down[9'b0_0010_1101]) ? 1'b1 : 1'b0;
    
    //get signal when keyboard pressed
    wire enterk;
    wire wk;
    wire sk;
    wire rk;
    assign enterk = (key_down[16'b0_0101_1010]) ? 1'b1 : 1'b0;
	assign wk = (key_down[9'b0_0001_1101]) ? 1'b1 : 1'b0;
	assign sk = (key_down[9'b0_0001_1011]) ? 1'b1 : 1'b0;
    assign rk = (key_down[9'b0_0010_1101]) ? 1'b1 : 1'b0;
    
//    wire opek;
//    OnePulse openter(opek, rk, clk);
    
    KeyboardDecoder kbdecoder0(
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    
    wire cyc100;
    wire cyc50;
    divider100 div100(clk, cyc100); // every 1 sec
    divider50 div50(clk, cyc50); // every  0.5 sec
    
    
    reg [28:0]tone;
    reg [28:0]nexttone;
    wire [31:0]freq;
    AudioDecoder audiodecoder0(tone, freq);
    PWM_gen pmwgen0(clk, enterk, freq, 10'd512, pmod_1);
    
    reg dir; //if 1 then 0000...00001 to 01000....000 vice versa
    reg nextdir;
    output reg speed; // 0 = slow 0.5ps 1 = fast 1ps
    reg nextspeed;
    
    always@(*) begin
        if(wk == 1'b1) nextdir = 1;
        else if(sk ==1'b1) nextdir = 0;
        else nextdir = dir;
    end
    
//    always@(*) begin
//        if(enterk==1'd1) begin
//            speed = 1'd1;
//        end else begin
//            if(rk == 1'd1) speed = ~speed;
//            else speed = speed;
//        end
//    end
    always@(*) begin
//        if(enterk == 1'd1) begin
//            nextspeed = 1'd1;
//        end else begin
            if(rk == 1'd1 && cyc50 ==1'd1) nextspeed = ~speed;
            else nextspeed = speed;
//        end
    end
    
    always@(*)begin
        if (dir == 1'd1) begin
            if (tone == 29'b1_0000_0000_0000_0000_0000_0000_0000) begin
                nexttone = tone;
            end else begin
                if (speed == 1'd1) begin
                    if (cyc100 == 1'd1) begin
                        nexttone = tone << 1;
                    end else begin
                        nexttone = tone;
                    end
                end else begin
                    if(cyc50 == 1'd1) begin 
                        nexttone = tone << 1;
                    end else begin
                        nexttone = tone;
                    end
                end
            end
        end else begin
             if (tone == 29'b0_0000_0000_0000_0000_0000_0000_0001) begin
                nexttone = tone;
            end else begin
                if (speed == 1'd1) begin
                    if (cyc100 == 1'd1) begin
                        nexttone = tone >> 1;
                    end else begin
                        nexttone = tone;
                    end
                end else begin
                    if(cyc50 == 1'd1) begin 
                        nexttone = tone >> 1;
                    end else begin
                        nexttone = tone;
                    end
                end
            end
         end       
        
//        if (enterk == 1'd1) begin
//            nexttone <= 29'b0_0000_0000_0000_0000_0000_0000_0001;
//            nextdir <= 1'd1;
//            nextspeed <= 1'd1;
//        end 
//        if (rk == 1'd1) begin
//            nextspeed <= speed + 1'd1;
//        end else begin
//            nextspeed <= speed;
//        end
    end
    
    always@(posedge clk)begin
        if (enterk == 1'd1) begin
            tone <= 29'b0_0000_0000_0000_0000_0000_0000_0001;
            dir <= 1'd1;
            speed <= 1'd1;
            //nextspeed <= 1'd1;
        end else begin
            tone <= nexttone;
            dir <= nextdir;
//            speed <= speed;
            speed <= nextspeed;
//            if (rk == 1'd1) begin
//                nextspeed <= speed + 1'd1;
//                speed <= speed + 1'd1;
//            end else begin
//                speed <= nextspeed;
//            end
        end

    end
    
    

endmodule

//100MHz so 100 000 000/s so 100 000 000 cyc = 1 sec
module divider100(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd100_000_000)begin
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
module divider50(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd50_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule


module AudioDecoder (tone, freq);    
	input [28:0] tone;
	output reg [31:0] freq;
    always @(*) begin
        case (tone)
        
            29'b0_0000_0000_0000_0000_0000_0000_0001: freq = 32'd261;
            29'b0_0000_0000_0000_0000_0000_0000_0010: freq = 32'd293;
            29'b0_0000_0000_0000_0000_0000_0000_0100: freq = 32'd329;
            29'b0_0000_0000_0000_0000_0000_0000_1000: freq = 32'd349;
            29'b0_0000_0000_0000_0000_0000_0001_0000: freq = 32'd391;
            29'b0_0000_0000_0000_0000_0000_0010_0000: freq = 32'd440;
            29'b0_0000_0000_0000_0000_0000_0100_0000: freq = 32'd493;
            
            29'b0_0000_0000_0000_0000_0000_1000_0000: freq = 32'd261 << 1;
            29'b0_0000_0000_0000_0000_0001_0000_0000: freq = 32'd293 << 1;
            29'b0_0000_0000_0000_0000_0010_0000_0000: freq = 32'd329 << 1;
            29'b0_0000_0000_0000_0000_0100_0000_0000: freq = 32'd349 << 1;
            29'b0_0000_0000_0000_0000_1000_0000_0000: freq = 32'd391 << 1;
            29'b0_0000_0000_0000_0001_0000_0000_0000: freq = 32'd440 << 1;
            29'b0_0000_0000_0000_0010_0000_0000_0000: freq = 32'd493 << 1;
            
            29'b0_0000_0000_0000_0100_0000_0000_0000: freq = 32'd261 << 2;
            29'b0_0000_0000_0000_1000_0000_0000_0000: freq = 32'd293 << 2;
            29'b0_0000_0000_0001_0000_0000_0000_0000: freq = 32'd329 << 2;
            29'b0_0000_0000_0010_0000_0000_0000_0000: freq = 32'd349 << 2;
            29'b0_0000_0000_0100_0000_0000_0000_0000: freq = 32'd391 << 2;
            29'b0_0000_0000_1000_0000_0000_0000_0000: freq = 32'd440 << 2;
            29'b0_0000_0001_0000_0000_0000_0000_0000: freq = 32'd493 << 2;
            
            29'b0_0000_0010_0000_0000_0000_0000_0000: freq = 32'd261 << 3;
            29'b0_0000_0100_0000_0000_0000_0000_0000: freq = 32'd293 << 3;
            29'b0_0000_1000_0000_0000_0000_0000_0000: freq = 32'd329 << 3;
            29'b0_0001_0000_0000_0000_0000_0000_0000: freq = 32'd349 << 3;
            29'b0_0010_0000_0000_0000_0000_0000_0000: freq = 32'd391 << 3;
            29'b0_0100_0000_0000_0000_0000_0000_0000: freq = 32'd440 << 3;
            29'b0_1000_0000_0000_0000_0000_0000_0000: freq = 32'd493 << 3;
            
            29'b1_0000_0000_0000_0000_0000_0000_0000: freq = 32'd493 << 4;
                       
            default : freq = 32'd262;	//Do-dummy
        endcase
    end
endmodule

//MISSIONG PWM_gen OnePulse and KeyboardDecoder because in Dicsussion no 79315 it says we only need to submit code that we write on our own