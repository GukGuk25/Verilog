`timescale 1ns/1ps

module Exhausted_Testing(a, b, cin, error, done);
    output [4-1:0] a, b;
    output cin;
    output error;
    output done;
    
    // input signal to the test instance.
    reg [4-1:0] a = 4'b0000;
    reg [4-1:0] b = 4'b0000;
    reg cin = 1'b0;
    // initial value for the done and error indicator: not done, no error
    reg done = 1'b0;
    reg error = 1'b0;
    
    
    
    //reg d = 1'b0;
    //reg e = 1'b0;
    
    // output from the test instance.
    wire [4-1:0] sum;
    wire cout;
    
    // instantiate the test instance.
    Ripple_Carry_Adder rca(
        .a (a), 
        .b (b), 
        .cin (cin),
        .cout (cout),
        .sum (sum)
    );
    
    // correct output
    wire[3:0] tsum;
    wire tcout;
    
    Ripple_Carry_Adder1 rca_true( //we use this to be used as a comparation with the test adder
        .a (a), 
        .b (b), 
        .cin (cin),
        .cout (tcout),
        .sum (tsum)
    );
    
    wire correct, notcorrect;
    compare c_1(
        .correct(correct),
        .notcorrect(notcorrect),
        .cout(cout),
        .sum(sum),
        .tcout(tcout),
        .tsum(tsum)
    );
    
   // nand_not1 e_1(error, e);
   //assi d_1(done, d);
    
    
    initial begin
        repeat (2 ** 4) begin
            repeat (2 ** 4) begin
                repeat (2) begin
                    cin = cin + 1'b1;
                    #1 //e = correct;
                    error = notcorrect;
                    #4;
                end
                b = b + 4'b1;
            end
            a = a + 4'b1;
        end
         //d = 1'b1;
        done = 1'b1;
        #5 done = 1'b0;
        //#5 $finish;
        
        
        // design you test pattern here.
        // Remember to set the input pattern to the test instance every 5 nanasecond
        // Check the output and set the `error` signal accordingly 1 nanosecond after new input is set.
        // Also set the done signal to 1'b1 5 nanoseconds after the test is finished.
        // Example:
        // setting the input
        // a = 4'b0000;
        // b = 4'b0000;
        // cin = 1'b0;
        // check the output
        // #1
        // check_output;
        // #4
        // setting another input
        // a = 4'b0001;
        // b = 4'b0000;
        // cin = 1'b0;
        //.....
        // #4
        // The last input pattern
        // a = 4'b1111;
        // b = 4'b1111;
        // cin = 1'b1;
        // #1
        // check_output;
        // #4
        // setting the done signal
        // done = 1'b1;
    end
    
endmodule

module assi(out,a);
    input a;
    output out;
    wire temp;
    
    nand_not1 not_1(temp, a);
    nand_not1 not_2(out, temp);
endmodule

module compare(correct, notcorrect, cout, sum, tcout, tsum);
    input cout, tcout;
    input[3:0] sum, tsum;
    output correct, notcorrect;
    wire xnor1, xnor2, xnor3, xnor4, xnor5;
    nand_xnor1 xnor_1(xnor1, cout, tcout);
    nand_xnor1 xnor_2(xnor2, sum[3], tsum[3]);
    nand_xnor1 xnor_3(xnor3, sum[2], tsum[2]);
    nand_xnor1 xnor_4(xnor4, sum[1], tsum[1]);
    nand_xnor1 xnor_5(xnor5, sum[0], tsum[0]);
    
    wire and1, and2, and3;
    nand_and1 and_1(and1, xnor1, xnor2);
    nand_and1 and_2(and2, xnor3, xnor4);
    nand_and1 and_3(and3, xnor5, and1);
    nand_and1 and_out(correct, and3, and2);
    nand_not1 not_out(notcorrect, correct);
endmodule

module Ripple_Carry_Adder1(a, b, cin, cout, sum);
    input [3:0] a, b;
    input cin;
    output cout;
    output [3:0] sum;
    wire cin1, cin2, cin3, cin4, cin5, cin6, cin7;
    
    Full_Adder1 adder_0(a[0], b[0], cin, cin1, sum[0]);
    Full_Adder1 adder_1(a[1], b[1], cin1, cin2, sum[1]);
    Full_Adder1 adder_2(a[2], b[2], cin2, cin3, sum[2]);
    Full_Adder1 adder_3(a[3], b[3], cin3, cout, sum[3]);
endmodule

module Full_Adder1 (a, b, cin, cout, sum);
    input a, b, cin;
    output cout, sum;
    wire majo1, majo2, ncin, nmajo1;
    
    Majority1 majo_1(a, b, cin, cout);
    nand_not1 not_1(ncin, cin);
    Majority1 majo_2(a, b, ncin, majo2);
    nand_not1 not_2(nmajo1, cout);
    Majority1 majo_3(nmajo1, cin, majo2, sum);
    
    
endmodule

module Majority1(a, b, c, out);
    input a, b, c;
    output out;
    wire and1, and2, and3, or1;
    
    nand_and1 and_1(and1, a, b);
    nand_and1 and_2(and2, a, c);
    nand_and1 and_3(and3, b, c);
    nand_or1 or_1(or1, and1, and2);
    nand_or1 or_2(out, or1, and3);
endmodule

module nand_and1 (out, a, b);
    input a, b;
    output out;
    wire nand1;
    
    nand nand_1(nand1, a, b);
    nand nand_2(out, nand1, nand1);
    
endmodule

module nand_or1 (out, a, b);
    input a, b;
    output out;
    wire nanda, nandb;
    
    nand nand_a(nanda, a, a);
    nand nand_b(nandb, b, b);
    nand nand_out(out, nanda, nandb);
    
endmodule

module nand_nor1 (out, a, b);
    input a, b;
    output out;
    wire nanda, nandb, nand1;
    
    nand nand_a(nanda, a, a);
    nand nand_b(nandb, b, b);
    nand nand_1(nand1, nanda, nandb);
    nand nand_2(out, nand1, nand1);
    

endmodule

module nand_xor1 (out, a, b);
    input a, b;
    output out;
    wire nand1, nand2, nand3;
    nand nand_1(nand1, a, b);
    nand nand_2(nand2, nand1, a);
    nand nand_3(nand3, nand1, b);
    nand nand_4(out, nand2, nand3);

endmodule

module nand_xnor1 (out, a, b);
    input a, b;
    output out;
    wire nand1, nanda, nandb, nand2;
    
    nand nand_1(nand1, a, b);
    nand nand_a(nanda, a, a);
    nand nand_b(nandb, b, b);
    nand nand_2(nand2, nanda, nandb);
    nand nand_3(out, nand1, nand2);
    
endmodule

module nand_not1 (out, a);
    input a;
    output out;
    
    nand nand_1(out, a, a);
    
endmodule
