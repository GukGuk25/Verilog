`timescale 1ns/1ps

module Traffic_Light_Controller (clk, rst_n, lr_has_car, hw_light, lr_light);
input clk, rst_n;
input lr_has_car;
output [2:0] hw_light;
output [2:0] lr_light;

parameter high_gr = 4'd0, high_yl = 4'd1, high_red_lr_rdy = 4'd2;
parameter low_gr = 4'd3, low_yl = 4'd4, low_red_high_rdy = 4'd5;

reg[4-1:0] current_state; 
reg [4-1:0] next_state;

reg[7-1:0] seventy_more, seventy_cyc, twenty_five; 
reg [7-1:0] waitone;

always@(posedge clk) begin
    if(!rst_n) begin
        current_state <= high_gr;
    end else begin
        current_state <= next_state;
    end
end

always@(posedge clk) begin
    if(!rst_n) begin
        seventy_more <= 1;
        twenty_five <= 1; seventy_cyc <= 1;
        waitone <=1;
    end else begin
        case(current_state)
            high_gr: begin
                if(seventy_more < 70)  //butuh dicek lagi nanti.
                    seventy_more <= seventy_more + 1;
                else seventy_more <= 7'b1111111;
                twenty_five <= 1; seventy_cyc <= 1;
                waitone <=1;
            end
            high_yl: begin
                twenty_five <= twenty_five + 1;
                seventy_more <= 1; seventy_cyc <= 1;
                waitone <=1;
            end
            high_red_lr_rdy: begin
                twenty_five <= 1;
                seventy_more <= 1; seventy_cyc <= 1;
                waitone <=1;
            end
            low_gr: begin
                seventy_cyc <= seventy_cyc + 1;
                twenty_five <= 1; seventy_more <= 1;
                waitone <=1;            
            end
            low_yl: begin
                twenty_five <= twenty_five + 1;
                seventy_more <= 1; seventy_cyc <= 1;
                waitone <=1;        
            end
            low_red_high_rdy: begin
                twenty_five <= 1;
                seventy_more <= 1; seventy_cyc <= 1;
                waitone <=1;
            end
            default: begin
                seventy_more <= 1;
                twenty_five <= 1; seventy_cyc <= 1;
                waitone <=1;
            end
        endcase
    end
end

reg [2:0] lr_out, hw_out;
assign hw_light = hw_out;
assign lr_light = lr_out;


parameter lampu_hijau_hejo_3bit  =3'b100;
parameter lampu_kuning_koneng_3bit =3'b010;
parameter lampu_merah_bereum_3bit  = 3'b001;

always@(*) begin
    //red = ; yellow = ; green = ;
    case(current_state)
        high_gr: begin
            hw_out = lampu_hijau_hejo_3bit;
            lr_out = lampu_merah_bereum_3bit;
        end
        high_yl: begin
            hw_out = lampu_kuning_koneng_3bit;
            lr_out = lampu_merah_bereum_3bit;
        end
        high_red_lr_rdy: begin
            hw_out = lampu_merah_bereum_3bit;
            lr_out = lampu_merah_bereum_3bit;
        end
        low_gr: begin
            hw_out = lampu_merah_bereum_3bit;
            lr_out = lampu_hijau_hejo_3bit;
        end
        low_yl: begin
            hw_out = lampu_merah_bereum_3bit;
            lr_out = lampu_kuning_koneng_3bit;
        end
        low_red_high_rdy: begin
            hw_out = lampu_merah_bereum_3bit;
            lr_out = lampu_merah_bereum_3bit;
        end
    endcase
end

//counter harus dimundurin 1 soalnya kita ngitung dari 0, bukan dari 1.
//kalau ngitung dari 1, itungnya pas sampe yg diinginkan

always@(*) begin
    case(current_state)
        high_gr: begin
            if(lr_has_car == 1) begin
                if(seventy_more >=7'd70) begin     //kalau mau ngikutin sample dikasih  ubah ke 2, kalau ngitung dari 0 set 69 (semua ini settingan itung dr 0)
                    next_state = high_yl;
                end else next_state = high_gr;
            end else next_state = high_gr;
        end
        high_yl: begin
            if(twenty_five == 7'd25) begin       //kalau mau ngikutin sample dikasih  ubah ke 1, kalau ngitung dari 0 set 24
                next_state = high_red_lr_rdy;
            end else begin
                next_state = high_yl;
            end
        end
        high_red_lr_rdy: begin
            next_state = low_gr;
        end
        low_gr: begin
            if(seventy_cyc == 7'd70) begin          //kalau mau ngikutin sample dikasih  ubah ke 2, kalau ngitung dari 0 set 69
                next_state = low_yl;
            end else begin
                next_state = low_gr;
            end
        end
        low_yl: begin
            if(twenty_five == 7'd25) begin       //kalau mau ngikutin sample dikasih  ubah ke 1, kalau ngitung dari 0 set 24
                next_state = low_red_high_rdy;
            end else begin
                next_state = low_yl;
            end
        end
        low_red_high_rdy: begin
            next_state = high_gr;
        end
    endcase
end

endmodule
