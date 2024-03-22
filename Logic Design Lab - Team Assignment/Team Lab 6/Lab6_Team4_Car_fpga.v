`timescale 1ns/1ps

module debounce (pb_debounced, pb, clk);
    output pb_debounced; 
    input pb;
    input clk;
    reg [4:0] DFF;
    
    always @(posedge clk) begin
        DFF[4:1] <= DFF[3:0];
        DFF[0] <= pb; 
    end
    assign pb_debounced = (&(DFF)); 
endmodule

module onepulse (PB_debounced, clk, PB_one_pulse);
    input PB_debounced;
    input clk;
    output reg PB_one_pulse;
    reg PB_debounced_delay;

    always @(posedge clk) begin
        PB_one_pulse <= PB_debounced & (! PB_debounced_delay);
        PB_debounced_delay <= PB_debounced;
    end 
endmodule

module Top(
    input clk,
    input rst,
    input echo,
    input left_signal,
    input right_signal,
    input mid_signal,
    output trig,
    output left_motor,
    output reg [1:0]left,
    output right_motor,
    output reg [1:0]right,
    output detect_ultra
);

    wire Rst_n, rst_pb, stop;
    wire [2-1:0] get_pwm_out;
    wire[3-1:0] state, nextstate;
    reg [3-1:0] check;
    debounce d0(rst_pb, rst, clk);
    onepulse d1(rst_pb, clk, Rst_n);

    motor A(
        .clk(clk),
        .rst(rst_n),
        .mode(state),
        .pwm(get_pwm_out)
    );
    
//    assign left_motor = get_pwm_out[1];
//    assign right_motor = get_pwm_out[0];
//    ini kalau mau nyambung keanya tapi gak jelas jg
    
    wire [2-1:0] invertPWM;
    assign invertPWM[1] = !get_pwm_out[1];
    assign invertPWM[0] = !get_pwm_out[0];

    assign left_motor = invertPWM[1]; //ini buat enable motor kiri
    assign right_motor = invertPWM[0]; //ini enable motor kanan
    //ini yang kita pake karena enablenya kita cabut.

    sonic_top B(
        .clk(clk), 
        .rst(rst_n), 
        .Echo(echo), 
        .Trig(trig),
        .stop(stop)
    );
    
    tracker_sensor C(
        .clk(clk), 
        .reset(rst_n), 
        .left_signal(left_signal), 
        .right_signal(right_signal),
        .mid_signal(mid_signal), 
        .state(state)
       );
    
    always@(*) begin
        check = state;
    end
    //assign check = state;
    parameter MotorOff_Mati_Dead = 2'b00;
    parameter MotorMajuTakGentar = 2'b10;
    parameter MotorMundurKabur = 2'b01;   
    
    parameter Halt = 3'b000;
    parameter Straight = 3'b001;
    parameter TurnLeft = 3'b010;
    parameter TurnRight = 3'b011;
    parameter HardRight_KanannnAbisss = 3'b100;
    parameter HardLeft_KiriiiAbisss = 3'b101;
    parameter Baaaack = 3'b110;
    
    assign detect_ultra = stop;
    
    always @(*) begin
        // [TO-DO]
        // bikin motornya tau
        // supaya bisa belok atau engga
        // caranya tentuin motor nya maju mundur, misalnya
        // kalau mau belok kiri, berarti kanan maju, tapi ini entah kenapa keputer gak ngerti dah.
        if(stop) begin
            left = MotorOff_Mati_Dead;
            right = MotorOff_Mati_Dead;
            //detect object, so we want to stop
        end
        else begin
            //no object detected, lets go
            case(check)
                Baaaack: begin
                    left = MotorMundurKabur;
                    right = MotorMundurKabur;
                    //move both backwards
                end
                Straight: begin
                    left = MotorMajuTakGentar;
                    right = MotorMajuTakGentar;
                    //move both forward
                end
                TurnLeft: begin
                    right = MotorOff_Mati_Dead;//MotorMundurKabur;//MotorOff_Mati_Dead; // cek
                    left = MotorMajuTakGentar;//MotorOff_Mati_Dead;
                    //why is this working?
                    //kalau satu forward satu backward, gesekan terlalu banyak
                    // mobil jadi jittery jadi matiin aja
                end
                TurnRight: begin
                    right = MotorMajuTakGentar; //MotorOff_Mati_Dead;
                    left = MotorOff_Mati_Dead;//MotorMundurKabur;//MotorOff_Mati_Dead;// ward; //MotorMajuTakGentar;
                    //why are the controls switched wtf
                    //gak perlu backward, mobil jadi jittery lambat, trs malah jadi belok.
                end
                HardRight_KanannnAbisss: begin
                    right= MotorMajuTakGentar;
                    left = MotorMajuTakGentar;
                    //not longer used, useless
                end
                HardLeft_KiriiiAbisss: begin
                    right = MotorMundurKabur;
                    left = MotorMundurKabur;
                    //not longer used, useless
                end
                default: begin
                    left = MotorMajuTakGentar;
                    right = MotorMajuTakGentar;                
                end
                endcase
        end
    end

endmodule


module tracker_sensor(clk, reset, left_signal, right_signal, mid_signal, state);
    input clk;
    input reset;
    input left_signal, right_signal, mid_signal;
    output reg [2:0] state;
    reg [2:0] nextstate;
    
    parameter Halt = 3'b000;
    parameter Straight = 3'b001;
    parameter TurnLeft = 3'b010;
    parameter TurnRight = 3'b011;
    parameter HardRight_KanannnAbisss = 3'b100;
    parameter HardLeft_KiriiiAbisss = 3'b101;
    parameter Baaaack = 3'b110;
    
    always@(posedge clk) begin
        if(reset) begin
            state <= Straight;
        end else begin
            state <= nextstate;
        end
    end
    
    always@(*) begin
        if(left_signal && mid_signal && right_signal ) begin
            nextstate = Straight;
        end else if(!left_signal && mid_signal && right_signal ) begin
            nextstate = TurnRight;//TurnLeft;
        end else if(left_signal && mid_signal && !right_signal ) begin
            nextstate = TurnLeft;//TurnRight;
        end else if(left_signal && !mid_signal &&  !right_signal ) begin
            nextstate = TurnLeft;//TurnRight;
        end else if (!left_signal && !mid_signal && right_signal ) begin
            nextstate = TurnRight;//TurnLeft;
        end else if (!left_signal && !mid_signal && !right_signal ) begin
            nextstate = Baaaack;
        end else begin
            nextstate = Straight;
        end
    end
//    always@(posedge clk) begin
//        if(reset) begin
//            state <= Halt;
//        end else begin
//            state <= nextstate;
//        end
//    end
    
//    always@(*) begin
//        if(left_signal) begin
//            nextstate = TurnLeft;
//        end else if(right_signal) begin
//            nextstate = TurnRight;
//        end else if(mid_signal) begin
//            nextstate = Straight;
//        end
//        else begin
//            nextstate = Straight;
//        end
//    end
    
    // [TO-DO] Receive three signals and make your own policy.
    // Hint: You can use output state to change your action.

endmodule


module motor(
    input clk,
    input rst,
    input [2:0]mode,
    output [1:0]pwm
);

    reg [9:0]next_left_motor, next_right_motor;
    reg [9:0]left_motor, right_motor;
    wire left_pwm, right_pwm;

    motor_pwm m0(clk, rst, left_motor, left_pwm);
    motor_pwm m1(clk, rst, right_motor, right_pwm);
    
    parameter Halt = 3'b000;
    parameter Straight = 3'b001;
    parameter TurnLeft = 3'b010;
    parameter TurnRight = 3'b011;
    parameter HardRight_KanannnAbisss = 3'b100;
    parameter HardLeft_KiriiiAbisss = 3'b101;
    parameter Baaaack = 3'b110;
    
    always@(posedge clk)begin
        if(rst)begin
            left_motor <= 10'd0;
            right_motor <= 10'd0;
        end else begin
            left_motor <= next_left_motor;
            right_motor <= next_right_motor;
        end
    end
    
    // [TO-DO] take the right speed for different situation
    // Note: halt just set 0
    // kalau angkanya makin gede, makin cepet karena kita ngegedein duty nya
    // kalau terlalu kecil, gak bisa gerak karena terlalu lemah
    always@(*) begin
        case(mode)
            Halt: begin
                next_left_motor = 10'd0;
                next_right_motor = 10'd0;
                //matiin aja gak usah gerak
            end
            Baaaack: begin
                next_left_motor = 10'd300;
                next_right_motor = 10'd300;   
                //kasih gerak mundur dikit aja, karena kita gakmau  dia mundur sampe
                //kelempar keluar dari track         
            end
            Straight: begin
                next_left_motor = 10'd1000;
                next_right_motor = 10'd1000;
                //kebut semaksimum mungkin supaya dapet tinggi speednya
            end
            TurnLeft: begin
                next_left_motor = 10'd750;
                next_right_motor = 10'd750; //lemah
                //belok kiri.
            end
            TurnRight: begin
                next_left_motor = 10'd750; //lemah
                next_right_motor = 10'd750;
                //belok kanan, ubah ke 750 aja
               
            end
            default: begin
                next_left_motor = 10'd1000;
                next_right_motor = 10'd1000;
                //default case itu berarti dia lurus
                // jadi ngikutin aja                
            end
        endcase
    end

    assign pwm = {left_pwm, right_pwm};
endmodule

module motor_pwm (
    input clk,
    input reset,
    input [9:0]duty,
	output pmod_1 //PWM
);
        
    PWM_gen pwm_0 ( 
        .clk(clk), 
        .reset(reset), 
        .freq(32'd25000),
        .duty(duty), 
        .PWM(pmod_1)
    );

endmodule

//generte PWM by input frequency & duty
module PWM_gen (
    input wire clk,
    input wire reset,
	input [31:0] freq,
    input [9:0] duty,
    output reg PWM
);
    wire [31:0] count_max = 32'd100_000_000 / freq;
    wire [31:0] count_duty = count_max * duty / 32'd1024;
    reg [31:0] count;
        
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            count <= 32'b0;
            PWM <= 1'b0;
        end else if (count < count_max) begin
            count <= count + 32'd1;
            if(count < count_duty)
                PWM <= 1'b1;
            else
                PWM <= 1'b0;
        end else begin
            count <= 32'b0;
            PWM <= 1'b0;
        end
    end
endmodule

module sonic_top(clk, rst, Echo, Trig, stop);
	input clk, rst, Echo;
	output Trig, stop;

	wire[19:0] dis;
	wire[19:0] d;
    wire clk1M;
	wire clk_2_17;

    div clk1(clk ,clk1M);
	TrigSignal u1(.clk(clk), .rst(rst), .trig(Trig));
	PosCounter u2(.clk(clk1M), .rst(rst), .echo(Echo), .distance_count(dis));
	
	reg stopgo;
	assign stop = (dis < 20'd4000) ? 1'b1 : 1'b0;;//stopgo;
	//assign stop = 1'b0;
	
//    always@(*) begin
//        if(dis < 20'd4000) stopgo = 1'b1;
//        else stopgo = 1'b0;	
//	end

    // [TO-DO] calculate the right distance to trig stop(triggered when the distance is lower than 40 cm)
    // Hint: using "dis"
 
endmodule

module PosCounter(clk, rst, echo, distance_count); 
    input clk, rst, echo;
    output[19:0] distance_count;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01; 
    parameter S2 = 2'b10;
    
    wire start, finish;
    reg[1:0] curr_state, next_state;
    reg echo_reg1, echo_reg2;
    reg[19:0] count, next_count, distance_register, next_distance;
    wire[19:0] distance_count; 

    always@(posedge clk) begin
        if(rst) begin
            echo_reg1 <= 1'b0;
            echo_reg2 <= 1'b0;
            count <= 20'b0;
            distance_register <= 20'b0;
            curr_state <= S0;
        end
        else begin
            echo_reg1 <= echo;   
            echo_reg2 <= echo_reg1; 
            count <= next_count;
            distance_register <= next_distance;
            curr_state <= next_state;
        end
    end

    always @(*) begin
        case(curr_state)
            S0: begin
                next_distance = distance_register;
                if (start) begin
                    next_state = S1;
                    next_count = count;
                end else begin
                    next_state = curr_state;
                    next_count = 20'b0;
                end 
            end
            S1: begin
                next_distance = distance_register;
                if (finish) begin
                    next_state = S2;
                    next_count = count;
                end else begin
                    next_state = curr_state;
                    next_count = (count > 20'd600_000) ? count : count + 1'b1;
                end 
            end
            S2: begin
                next_distance = count;
                next_count = 20'b0;
                next_state = S0;
            end
            default: begin
                next_distance = 20'b0;
                next_count = 20'b0;
                next_state = S0;
            end
        endcase
    end

    assign distance_count = distance_register * 20'd100 / 20'd58; 
    assign start = echo_reg1 & ~echo_reg2;  
    assign finish = ~echo_reg1 & echo_reg2; 
endmodule

module TrigSignal(clk, rst, trig);
    input clk, rst;
    output trig;

    reg trig, next_trig;
    reg[23:0] count, next_count;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            count <= 24'b0;
            trig <= 1'b0;
        end
        else begin
            count <= next_count;
            trig <= next_trig;
        end
    end

    always @(*) begin
        next_trig = trig;
        next_count = count + 1'b1;
        if(count == 24'd999)
            next_trig = 1'b0;
        else if(count == 24'd9999999) begin
            next_trig = 1'b1;
            next_count = 24'd0;
        end
    end
endmodule

module div(clk ,out_clk);
    input clk;
    output out_clk;
    reg out_clk;
    reg [6:0]cnt;
    
    always @(posedge clk) begin   
        if(cnt < 7'd50) begin
            cnt <= cnt + 1'b1;
            out_clk <= 1'b1;
        end 
        else if(cnt < 7'd100) begin
	        cnt <= cnt + 1'b1;
	        out_clk <= 1'b0;
        end
        else if(cnt == 7'd100) begin
            cnt <= 7'b0;
            out_clk <= 1'b1;
        end
        else begin 
            cnt <= 7'b0;
            out_clk <= 1'b1;
        end
    end
endmodule
