`timescale 1ns/1ps

module Content_Addressable_Memory(clk, wen, ren, din, addr, dout, hit);
    input clk;
    input wen, ren;
    input [7:0] din;
    input [3:0] addr;
    output [3:0] dout;
    output hit;
    
    //16 sets of 8 bit data lines
    reg[8-1:0] dataline[16-1:0];
    reg hitout;
    reg [4-1:0] dout_out;
    
    assign dout = dout_out;
    assign hit = hitout;
    wire startreading;
    
    wire [16-1:0]valid_out;
    
    comparator_array ar_0(dataline[0], din, valid_out[0]); comparator_array ar_8 (dataline[8 ], din, valid_out[8]); 
    comparator_array ar_1(dataline[1], din, valid_out[1]); comparator_array ar_9 (dataline[9 ], din, valid_out[9]); 
    comparator_array ar_2(dataline[2], din, valid_out[2]); comparator_array ar_10(dataline[10], din, valid_out[10]); 
    comparator_array ar_3(dataline[3], din, valid_out[3]); comparator_array ar_11(dataline[11], din, valid_out[11]); 
    comparator_array ar_4(dataline[4], din, valid_out[4]); comparator_array ar_12(dataline[12], din, valid_out[12]); 
    comparator_array ar_5(dataline[5], din, valid_out[5]); comparator_array ar_13(dataline[13], din, valid_out[13]); 
    comparator_array ar_6(dataline[6], din, valid_out[6]); comparator_array ar_14(dataline[14], din, valid_out[14]); 
    comparator_array ar_7(dataline[7], din, valid_out[7]); comparator_array ar_15(dataline[15], din, valid_out[15]); 
    
    wire [4-1:0] take;
    wire found;
    wire encode_hit;
    wire [4-1:0] encode_out;
    priority_encoder_16to_4 encoder(valid_out, take, startreading, found);
    
    assign startreading = ren;
    assign encode_out = take;
    assign encode_hit = found;

    always@(posedge clk)begin
        if(startreading) begin
            if(encode_out == 4'bzzzz || found == 1'b0) begin
                dout_out <= 4'b0;
                hitout <= 1'b0;
            end else begin
                dout_out <= encode_out;
                hitout <= 1'b1;
            end
        end else begin
            hitout <= 1'b0;
            dout_out <= 4'b0;
        end
    end
    
    always@(posedge clk) begin
        if(wen== 1'b0 && ren == 1'b0) begin
           //startreading <= 1'b0;
        end else if(wen == 1'b1 && ren==1'b0) begin
            //startreading <= 1'b0;
            dataline[addr]<=din;
        end else if(wen == 1'b0 && ren == 1'b1) begin
            //startreading <= 1'b1;
         end else if(wen == 1'b1 && ren == 1'b1) begin
            //startreading <= 1'b1;
        end
    end

endmodule

module comparator_array(data, pair, valid);
    input [8-1:0] data, pair;
    output valid;
    
    assign valid = (data==pair) ? 1'b1 : 1'b0;
endmodule

module priority_encoder_16to_4(valid, y, enable, found);
  input [16-1:0] valid;
  input enable;
  output reg [4-1:0] y;
  output reg found;
  always @(*)begin
      if(enable) begin
          if(valid[0] == 1'b1) begin y = 4'd0; found = 1'b1; end
          else if(valid[1] == 1'b1) begin y = 4'd1; found = 1'b1; end
          else if(valid[2] == 1'b1) begin y = 4'd2; found = 1'b1; end
          else if(valid[3] == 1'b1)begin y = 4'd3; found = 1'b1; end
          else if(valid[4] == 1'b1)begin y = 4'd4; found = 1'b1; end
          else if(valid[5] == 1'b1)begin y = 4'd5; found = 1'b1; end
          else if(valid[6] == 1'b1)begin y = 4'd6; found = 1'b1; end
          else if(valid[7] == 1'b1)begin y = 4'd7; found = 1'b1; end
          else if(valid[8] == 1'b1)begin y = 4'd8; found = 1'b1; end
          else if(valid[9] == 1'b1)begin y = 4'd9; found = 1'b1; end
          else if(valid[10] == 1'b1)begin y = 4'd10; found = 1'b1; end
          else if(valid[11] == 1'b1)begin y = 4'd11; found = 1'b1; end
          else if(valid[12] == 1'b1)begin y = 4'd12; found = 1'b1; end
          else if(valid[13] == 1'b1)begin y = 4'd13; found = 1'b1; end
          else if(valid[14] == 1'b1)begin y = 4'd14; found = 1'b1; end
          else if(valid[15] == 1'b1)begin y = 4'd15; found = 1'b1; end
          else begin y = 4'bzzzz; found = 1'b0; end
      end else begin y = 4'bzzzz; found = 1'b0; end
  end
endmodule
