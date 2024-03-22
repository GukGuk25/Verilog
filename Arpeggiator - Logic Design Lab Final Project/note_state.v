module KeyBoardInputToTone(a,s,d,f,g,h,j,k, w,e,t,y,u, clk, speed, tone, just, dir , bawah, tengah, high, transposed); 
    input a,s,d,f,g,h,j,k, w,e,t,y,u, dir, transposed;
    input clk, speed, bawah, tengah, high;
    output reg [13-1:0] just;
    // reg a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on,
    output reg [47-1:0] tone;

    reg [47-1:0] C4;
    
    parameter base_bawah = 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001;
    parameter base_tengah = 46'b000_000_0000_0000_0000_0000_0000_0000_0010_0000_0000_0000;
    parameter base_atas = 46'b000_000_0000_0000_0000_0010_0000_0000_0000_0000_0000_0000;

    parameter base_bawah_G = 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_1000_0000;
    parameter base_tengah_G = 46'b000_000_0000_0000_0000_0000_0001_0000_0000_0000_0000_0000;
    parameter base_atas_G = 46'b000_000_0000_0001_0000_0000_0000_0000_0000_0000_0000_0000;
    
    parameter NoTone= 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;

    always@(posedge clk)begin
        if(transposed) begin
            if(bawah && !tengah && !high) C4 <= base_bawah_G;
            else if(!bawah && tengah && !high) C4 <= base_tengah_G;
            else if(!bawah && !tengah && high) C4 <= base_atas_G;
            else C4 <= base_tengah_G;
        end else begin
            if(bawah && !tengah && !high) C4 <= base_bawah;
            else if(!bawah && tengah && !high) C4 <= base_tengah;
            else if(!bawah && !tengah && high) C4 <= base_atas;
            else C4 <= base_tengah;
        end
    end
    
    reg [4-1:0] state, nextstate;
    always@(posedge clk) begin
        if(speed) begin state <= nextstate; end
        else begin state <= state; end
    end
    //a,s,d,f,g,h,j,k, w,e,t,y,u
    //a,w,s,e,d,f,t,g,y,h,u,j,k
    parameter press_a = 4'd0; parameter press_f = 4'd5; parameter press_u = 4'd10;
    parameter press_w = 4'd1; parameter press_t = 4'd6; parameter press_j = 4'd11;
    parameter press_s = 4'd2; parameter press_g = 4'd7; parameter press_k = 4'd12;
    parameter press_e = 4'd3; parameter press_y = 4'd8;
    parameter press_d = 4'd4; parameter press_h = 4'd9;
    //a,w,s,e,d,f,t,g,y,h,u,j,k

    always@(*) begin
        if(dir) begin
            case (state)
                press_a : begin
                    if(a) tone = C4; else tone = NoTone;
                    if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else nextstate = press_a;  
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_w : begin
                    if(w) tone = C4<<1; else tone = NoTone;
                    if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else nextstate = press_w;  
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_s : begin
                    if(s) tone = C4<<2; else tone = NoTone;
                    if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else nextstate = press_s;  
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_e : begin
                    if(e) tone = C4<<3; else tone = NoTone;
                    if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else nextstate = press_e;  
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_d : begin
                    if(d) tone = C4<<4; else tone = NoTone;
                    if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else nextstate = press_d;  
                end
                
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_f : begin
                    if(f) tone = C4<<5; else tone = NoTone;
                    if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else nextstate = press_f;  
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_t : begin
                    if(t) tone = C4<<6; else tone = NoTone;
                    if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else nextstate = press_t;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_g : begin
                    if(g) tone = C4<<7; else tone = NoTone;
                    if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else nextstate = press_g;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_y : begin
                    if(y) tone = C4<<8; else tone = NoTone;
                    if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else nextstate = press_y; 
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_h : begin
                    if(h) tone = C4<<9; else tone = NoTone;
                    if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin 
                        nextstate = press_y;
                    end else nextstate = press_h; 
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_u : begin
                    if(u) tone = C4<<10; else tone = NoTone;
                    if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin 
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h; 
                    end else nextstate = press_u;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_j : begin
                    if(j) tone = C4<<11; else tone = NoTone;
                    if (k) begin
                        nextstate = press_k;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin 
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h; 
                    end else if (u) begin
                        nextstate = press_u;
                    end else nextstate = press_j;
                end
                
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_k : begin
                    if(k) tone = C4<<12; else tone = NoTone;
                    if (a) begin
                        nextstate = press_a;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin 
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h; 
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else nextstate = press_k;
                end
                default: begin
                    nextstate = press_a;
                    tone = NoTone;
                end
            endcase
        end else begin
            case(state)
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_a : begin
                    if(a) tone = C4; else tone = NoTone;
                    //write it in reverse order
                    if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else nextstate = press_a;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_k: begin
                    if(k) tone = C4 << 12; else tone = NoTone;
                    if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else nextstate = press_k;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_j: begin
                    if(j) tone = C4 << 11; else tone = NoTone;
                    if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else nextstate = press_j;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_u: begin
                    if(u) tone = C4 << 10; else tone = NoTone;
                    if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else nextstate = press_u;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k

                press_h: begin
                    if(h) tone = C4 << 9; else tone = NoTone;
                    if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else nextstate = press_h;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_y: begin
                    if(y) tone = C4 << 8; else tone = NoTone;
                    if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else nextstate = press_y;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_g: begin
                    if(g) tone = C4 << 7; else tone = NoTone;
                    if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else nextstate = press_g;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_t: begin
                    if(t) tone = C4 << 6; else tone = NoTone;
                    if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else nextstate = press_t;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_f: begin
                    if(f) tone = C4 << 5; else tone = NoTone;
                    if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else nextstate = press_f;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_d: begin
                    if(d) tone = C4 << 4; else tone = NoTone;
                    if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else nextstate = press_d;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_e: begin
                    if(e) tone = C4 << 3; else tone = NoTone;
                    if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else nextstate = press_e;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_s: begin
                    if(s) tone = C4 << 2; else tone = NoTone;
                    if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else nextstate = press_s;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_w: begin
                    if(w) tone = C4 << 1; else tone = NoTone;
                    if (a) begin
                        nextstate = press_a;
                    end else if (k) begin
                        nextstate = press_k;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else nextstate = press_w;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                default: begin
                    nextstate = press_a;
                    tone = NoTone;
                end
            endcase
        end
    end
endmodule


module KeyBoardInputToTonetoingtoing(a,s,d,f,g,h,j,k, w,e,t,y,u, clk, speed, tone, just, reset, bawah, tengah, high, transposed); 
    input a,s,d,f,g,h,j,k, w,e,t,y,u,reset, transposed;
    input clk, speed, bawah, tengah, high;
    output reg [13-1:0] just;
    // reg a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on, a_on, s_on,
    output reg [47-1:0] tone;

    reg [47-1:0] C4;
    parameter base_bawah = 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0001;
    parameter base_tengah = 46'b000_000_0000_0000_0000_0000_0000_0000_0010_0000_0000_0000;
    parameter base_atas = 46'b000_000_0000_0000_0000_0010_0000_0000_0000_0000_0000_0000;

    parameter base_bawah_G = 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_1000_0000;
    parameter base_tengah_G = 46'b000_000_0000_0000_0000_0000_0001_0000_0000_0000_0000_0000;
    parameter base_atas_G = 46'b000_000_0000_0001_0000_0000_0000_0000_0000_0000_0000_0000;
    
    parameter NoTone= 46'b000_000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;

    always@(posedge clk)begin
        if(transposed) begin
            if(bawah && !tengah && !high) C4 <= base_bawah_G;
            else if(!bawah && tengah && !high) C4 <= base_tengah_G;
            else if(!bawah && !tengah && high) C4 <= base_atas_G;
            else C4 <= base_tengah_G;
        end else begin
            if(bawah && !tengah && !high) C4 <= base_bawah;
            else if(!bawah && tengah && !high) C4 <= base_tengah;
            else if(!bawah && !tengah && high) C4 <= base_atas;
            else C4 <= base_tengah;
        end
    end
    
    
    reg dir, nextdir;
    reg [4-1:0] state, nextstate;
    always@(posedge clk) begin
        if(clk) begin
            dir <= nextdir;
        end else begin
            dir <= dir;
        end
        if(speed) begin state <= nextstate; end
        else begin state <= state;end
    end
    //a,s,d,f,g,h,j,k, w,e,t,y,u
    //a,w,s,e,d,f,t,g,y,h,u,j,k
    parameter press_a = 4'd0; parameter press_f = 4'd5; parameter press_u = 4'd10;
    parameter press_w = 4'd1; parameter press_t = 4'd6; parameter press_j = 4'd11;
    parameter press_s = 4'd2; parameter press_g = 4'd7; parameter press_k = 4'd12;
    parameter press_e = 4'd3; parameter press_y = 4'd8;
    parameter press_d = 4'd4; parameter press_h = 4'd9;
    //a,w,s,e,d,f,t,g,y,h,u,j,k

    // reg nextdir;

    always@(*) begin
        if(reset)begin
            nextdir = 1'd1;
        end else begin
            nextdir = dir;
        end

        //a,w,s,e,d,f,t,g,y,h,u,j,k

        if(dir) begin
            case (state)
                press_a : begin
                    if(a) tone = C4; else tone = NoTone;
                    if (w) begin
                        nextstate = press_w;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (a) begin
                    //     nextstate = press_a;
                    end else nextdir = 1'd0;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_w : begin
                    if(w) tone = C4<<1; else tone = NoTone;
                    if (s) begin
                        nextstate = press_s;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (w) begin
                    //     nextstate = press_w;
                    end else nextdir = 1'd0;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_s : begin
                    if(s) tone = C4<<2; else tone = NoTone;
                    if (e) begin
                        nextstate = press_e;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (s) begin
                    //     nextstate = press_s;
                    end else nextdir = 1'd0;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_e : begin
                    if(e) tone = C4<<3; else tone = NoTone;
                    if (d) begin
                        nextstate = press_d;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (e) begin
                    //     nextstate = press_e;
                    end else nextdir = 1'd0;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_d : begin
                    if(d) tone = C4<<4; else tone = NoTone;
                    if (f) begin
                        nextstate = press_f;
                    end else if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (d) begin
                    //     nextstate = press_d;
                    end else nextdir = 1'd0;
                end
                
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_f : begin
                    if(f) tone = C4<<5; else tone = NoTone;
                    if (t) begin
                        nextstate = press_t;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (f) begin
                    //     nextstate = press_f;
                    end else nextdir = 1'd0;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_t : begin
                    if(t) tone = C4<<6; else tone = NoTone;
                    if (g) begin
                        nextstate = press_g;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (t) begin
                    //     nextstate = press_t;
                    end else nextdir = 1'd0;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_g : begin
                    if(g) tone = C4<<7; else tone = NoTone;
                    if (y) begin
                        nextstate = press_y;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (g) begin
                    //     nextstate = press_g;
                    end else nextdir = 1'd0;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_y : begin
                    if(y) tone = C4<<8; else tone = NoTone;
                    if (h) begin
                        nextstate = press_h;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (y) begin
                    //     nextstate = press_y;
                    end else nextdir = 1'd0;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_h : begin
                    if(h) tone = C4<<9; else tone = NoTone;
                    if (u) begin
                        nextstate = press_u;
                    end else if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (h) begin
                    //     nextstate = press_h;
                    end else nextdir = 1'd0;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_u : begin
                    if(u) tone = C4<<10; else tone = NoTone;
                    if (j) begin
                        nextstate = press_j;
                    end else if (k) begin
                        nextstate = press_k;
                    // end else if (u) begin
                    //     nextstate = press_u;
                    end else nextdir = 1'd0;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_j : begin
                    if(j) tone = C4<<11; else tone = NoTone;
                    if (k) begin
                        nextstate = press_k;
                    // end else if (j) begin
                    //     nextstate = press_j;
                    end else nextdir = 1'd0;
                end
                
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_k : begin
                    if(k) tone = C4<<12; else tone = NoTone;
                    nextdir = 1'd0;
                end
                default: begin
                    nextstate = press_a;
                    tone = NoTone;
                    nextdir = 1'd0;
                end
            endcase


// garis suci =================================================================
// garis suci =================================================================
// garis suci =================================================================
// garis suci =================================================================
// garis suci =================================================================



        end else begin
            case(state)
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_a : begin
                    if(a) tone = C4; else tone = NoTone;
                    nextdir = 1'd1;
                end
                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_k: begin
                    if(k) tone = C4 << 12; else tone = NoTone;
                    if (j) begin
                        nextstate = press_j;
                    end else if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (k) begin
                    //     nextstate = press_k;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_j: begin
                    if(j) tone = C4 << 11; else tone = NoTone;
                    if (u) begin
                        nextstate = press_u;
                    end else if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (j) begin
                    //     nextstate = press_j;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_u: begin
                    if(u) tone = C4 << 10; else tone = NoTone;
                    if (h) begin
                        nextstate = press_h;
                    end else if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (u) begin
                    //     nextstate = press_u;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k

                press_h: begin
                    if(h) tone = C4 << 9; else tone = NoTone;
                    if (y) begin
                        nextstate = press_y;
                    end else if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (h) begin
                    //     nextstate = press_h;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_y: begin
                    if(y) tone = C4 << 8; else tone = NoTone;
                    if (g) begin
                        nextstate = press_g;
                    end else if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (y) begin
                    //     nextstate = press_y;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_g: begin
                    if(g) tone = C4 << 7; else tone = NoTone;
                    if (t) begin 
                        nextstate = press_t;
                    end else if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (g) begin
                    //     nextstate = press_g;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_t: begin
                    if(t) tone = C4 << 6; else tone = NoTone;
                    if (f) begin
                        nextstate = press_f;
                    end else if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (t) begin
                    //     nextstate = press_t;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_f: begin
                    if(f) tone = C4 << 5; else tone = NoTone;
                    if (d) begin
                        nextstate = press_d;
                    end else if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (f) begin
                    //     nextstate = press_f;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_d: begin
                    if(d) tone = C4 << 4; else tone = NoTone;
                    if (e) begin
                        nextstate = press_e;
                    end else if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (d) begin
                    //     nextstate = press_d;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_e: begin
                    if(e) tone = C4 << 3; else tone = NoTone;
                    if (s) begin
                        nextstate = press_s;
                    end else if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (e) begin
                    //     nextstate = press_e;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_s: begin
                    if(s) tone = C4 << 2; else tone = NoTone;
                    if (w) begin
                        nextstate = press_w;
                    end else if (a) begin
                        nextstate = press_a;
                    // end else if (s) begin
                    //     nextstate = press_s;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                press_w: begin
                    if(w) tone = C4 << 1; else tone = NoTone;
                    if (a) begin
                        nextstate = press_a;
                    // end else if (w) begin
                    //     nextstate = press_w;
                    end else nextdir = 1'd1;
                end

                //a,w,s,e,d,f,t,g,y,h,u,j,k
                default: begin
                    nextstate = press_a;
                    tone = NoTone;
                    nextdir = 1'd1;
                end
            endcase
        end
    end
endmodule