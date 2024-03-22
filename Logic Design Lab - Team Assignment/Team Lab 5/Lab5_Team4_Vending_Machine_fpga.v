`timescale 1ns/1ps 

module topmodule(PS2_DATA, PS2_CLK, clk, rstbutt, in5butt, in10butt, in50butt, cancelbutt, anode, cathode, a, s, d, f, b1, b2, b3,b4);
    inout wire PS2_DATA;
	inout wire PS2_CLK;
    input clk;
    input rstbutt; 
    input in5butt;
    input in10butt;
    input in50butt;
    input cancelbutt;
    output [3:0] anode;
    output [6:0] cathode;
    
    //keyboard stuffs
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire key_valid;
    output a,s,d,f,b1,b2,b3,b4;
    assign ak = (key_down[9'b0_0001_1100]) ? 1'b1 : 1'b0;
	assign sk = (key_down[9'b0_0001_1011]) ? 1'b1 : 1'b0;
	assign dk = (key_down[9'b0_0010_0011]) ? 1'b1 : 1'b0;
    assign fk = (key_down[9'b0_0010_1011]) ? 1'b1 : 1'b0;    
	assign b1 = (key_down[9'b0_0001_0110]) ? 1'b1 : 1'b0;
	assign b2 = (key_down[9'b0_0001_1110]) ? 1'b1 : 1'b0;
    assign b3 = (key_down[9'b0_0010_0110]) ? 1'b1 : 1'b0;  
    assign b4 = (key_down[9'b0_0101_1010]) ? 1'b1 : 1'b0;  
    
    //we hate button so we debug with keyboard first then fix the annoying button XD
    wire b1k,b2k,b3k,b4k;
    assign b1k = (key_down[9'b0_0001_0110]) ? 1'b1 : 1'b0; //1
	assign b2k = (key_down[9'b0_0001_1110]) ? 1'b1 : 1'b0; //2
    assign b3k = (key_down[9'b0_0010_0110]) ? 1'b1 : 1'b0; //3
    assign b4k = (key_down[9'b0_0101_1010]) ? 1'b1 : 1'b0; //enter
    //we hate button so we debug with keyboard first then fix the annoying button XD
    
    
    KeyboardDecoder kbdecoder0(
        .key_down(key_down),
        .last_change(last_change),
        .key_valid(key_valid),
        .PS2_DATA(PS2_DATA),
        .PS2_CLK(PS2_CLK),
        .rst(rst),
        .clk(clk)
    );
    
    //2^7 = 128
    reg [6:0]bal;
    reg [6:0]nextbal;
    
    
    wire pdrst, pb5, pd10, pd50, pbcancel;
    //button stuff
    wire clk_div;
    Clock_Divider cd(clk, clk_div);
    //module debounce (pb_debounced, pb, clk);
    debounce db0(pbrst, rstbutt, clk);
    debounce db1(pb5, in5butt, clk);
    debounce db2(pb10, in10butt, clk);
    debounce db3(pb50, in50butt, clk);
    debounce db4(pbcancel, cancelbutt, clk);
    wire oprst, op5, op10, op50, opcancel;
    //module onepulse (op, butt, clk);
    onepulse op0(oprst, pbrst, clk_div);
    onepulse op1(op5, pb5, clk_div);
    onepulse op2(op10, pb10, clk_div);
    onepulse op3(op50, pb50, clk_div);
    onepulse op4(opcancel, pbcancel, clk_div);
    
    

    anodecathode disp0(bal, clk, anode, cathode);
    
    //module divider100(clk, out);
    wire clk100, clk50, clktest;
    divider100 div100(clk, clk100);
    divider50 div50(clk, clk50);
    dividertest test(clk, clktest);
    reg [2:0]per5;
    reg fin;
    
//    always@(*)begin
//        if (fin ==1'd1) begin
//            per5 = 3'd5;
//        end else begin
//            per5 = 3'd0;
//            nextbal = 7'd0;
//        end
//    end
    always @(posedge clktest) begin
        if (fin ==1'd1) begin
            per5 = 3'd5;
            nextbal = bal;
        end else begin
            per5 = 3'd0;
            nextbal = 7'd0;
        end
        if (bal == 7'd0) fin = 1'd0;
        
        if(op5)begin
            if(bal > 7'd95) begin
                nextbal = bal;
            end else begin
                nextbal = bal + 7'd5;
            end
        end
        else if(op10)begin
            if(bal > 7'd90) begin
                nextbal = bal;
            end else begin 
                nextbal = bal + 7'd10;
            end
        end
        else if(op50)begin
            if(bal > 7'd50) begin
                nextbal = bal;
            end else begin 
                nextbal = bal + 7'd50;
            end
        end 
        else if(ak)begin //cofee80
            if(bal < 7'd80) begin 
                nextbal = bal;
            end else begin
                if (bal - 7'd80 == 7'd0) begin nextbal = 0; fin = 1'd0; end
                else begin
                    nextbal <= bal - 7'd80;
                    fin <= 1'd1;
                end
            end
        end
        else if(sk)begin //coke30
            if(bal < 7'd30) begin 
                nextbal = bal;
            end else begin 
                if (bal - 7'd30 == 7'd0) begin nextbal = 0; fin = 1'd0; end
                else begin
                    nextbal <= bal - 7'd30;
                    fin <= 1'd1;
                end
            end
        end
        else if(dk)begin //ollong25
            if(bal < 7'd25) begin
                nextbal = bal;
            end else begin 
                if (bal - 7'd25 == 7'd0) begin nextbal = 0; fin = 1'd0; end
                else begin
                    nextbal <= bal - 7'd25;
                    fin <= 1'd1;
                end
            end
        end 
        else if(fk)begin //water 20
            if(bal < 7'd20) begin
                nextbal = bal;
            end else begin 
            if (bal - 7'd20 == 7'd0) begin nextbal = 0; fin = 1'd0; end
                else begin
                    nextbal <= bal - 7'd20;
                    fin <= 1'd1;
                end
            end
        end 
        else if (opcancel) begin
            fin = 1'd1;
        end
        else begin   
            if (bal == 7'd0) begin
                fin = 1'd0;
            end else begin
                if (bal-per5 == 7'd0) begin
                    nextbal = 7'd0;
                end else nextbal = bal - per5;        
            end
        end
    end
    
    
    
    always @(posedge clk_div)begin
        if(oprst)begin
            bal <= 7'd0;
//            nextbal <= 7'd0;
        end
        else begin
            bal <= nextbal;

        end
    end
    
endmodule

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
module dividertest(clk, out);
    input clk;
    output reg out;
    
    reg [30:0]cnt;
    
    always @(posedge clk)begin
        if(cnt == 30'd1_000_000)begin
            cnt <= 30'd0;
            out <= 1'd1;
        end
        else begin
            cnt <= cnt + 1'b1;
            out <= 1'd0;
        end
    end
endmodule
module anodecathode(bal, clk, anode, cathode);
    input [7:0] bal;
    input clk;
    output reg [3:0] anode;
    output [6:0] cathode;
    
    reg[3:0] digit;
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
                else digit = 4'd1;
            end
            2'b11:begin
                anode = 4'b0111;
                digit = 4'd10;
            end
            default:begin
                anode = 4'b1111;
                digit = 4'd10;
            end
        endcase

    end
endmodule

module getcathode(digit, cathode);
    input [3:0] digit;
    output reg [6:0] cathode;
    always@(*) begin        
        case(digit)
            4'd0: cathode = 7'b0000001;
            4'd1: cathode = 7'b1001111;
            4'd2: cathode = 7'b0010010;
            4'd3: cathode = 7'b0000110;
            4'd4: cathode = 7'b1001100;
            4'd5: cathode = 7'b0100100;
            4'd6: cathode = 7'b0100000;
            4'd7: cathode = 7'b0001111;
            4'd8: cathode = 7'b0000000;
            4'd9: cathode = 7'b0000100;
            default: cathode = 7'b1111111;
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

module Clock_Divider(clk, clk_div);
    input clk;
    output reg clk_div;
    
    reg[23:0] Counter;
    
    always @(posedge clk) Counter <= Counter + 1'b1;
    
    always @(*) clk_div = Counter[23]; 
    
endmodule

module onepulse (op, butt, clk);
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

//Missing KeyboardDecoder because in Dicsussion no 79315 it says we only need to submit code that we write on our own