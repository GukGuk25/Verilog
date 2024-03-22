`timescale 1ns/1ps

module TestingPurpose;
    reg [4-1:0] rs=4'b0000, rt=4'b0000;
    reg [3-1:0] sel=3'b000;
    wire [4-1:0] rd;
    

    Decode_And_Execute make(
        .rs(rs),
        .rt(rt),
        .sel(sel),
        .rd(rd)
    );
    initial begin
        repeat (2**3)begin
            #1 sel = sel + 3'b001;
            repeat (2**4)begin
                #1 rs = rs + 4'b0001;
                repeat (2**4) begin
                    #1 rt = rt + 4'b0001;
                end
            end
        end
        #1 $finish;
    end

endmodule
