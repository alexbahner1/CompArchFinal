`include "multiplier.v"
//`include "registers.v"
//`include "counter.v"
module test();

    wire unsigned [31:0]  res;   // Final result, valid when "done" is true
    wire                done;  // High for one cycle when result is valid/complete
    reg unsigned [15:0]  A, B; // Inputs to be multiplied
    reg                 clk;   // Output transitions synchronized to posedge
    reg                 start;

    // Initialize modules
    multiplier dut(.res(res),.done(done),.A(A),.B(B),.clk(clk),.start(start));

    initial clk = 0;
    always #5 clk=!clk;

    initial begin



    // #5 Clk=1; #5 Clk=0;	// Generate single clock pulse

    $dumpfile("multiplier.vcd");
    $dumpvars();


    $display("Multiplier test");
    $display("   A  |   B  |  Result  |   Expected   | Res==Exp | Done");

    A = 16'b0000000110000001; B = 16'b1111111111111111; start = 1'b1; #10 start=1'b0; #1000
    $display(" %b | %b | %b |   ",A,B,res);
    // A = 16'b0000110000000001; B = 16'b1111111111111111; start = 1'b1; #10 start=1'b0; #1000
    // $display(" %b | %b | %b |   ",A,B,res);
    // A = 4'b100111; B = 4'b1111; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'b0101; B = 4'b1010; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'b0; B = 4'd13; start = 1'b1;#10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    //
    // A = 4'b0101; B = 4'b0; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd1; B = 4'd1; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd2; B = 4'd3; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd4; B = 4'd10; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd3; B = 4'd8; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd7; B = 4'd6; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd2; B = 4'd2; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);
    // A = 4'd10; B = 4'd15; start = 1'b1; #10 start=1'b0; #100
    // $display(" %b | %b | %b |   %b   |    %b     |  %b",A,B,res,{4'b0,A}*{4'b0,B},res==A*B,done);



    $finish();





    // start = 1; clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);
    // start = 0; clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);
    // clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);
    // clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);
    // clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);
    // clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);
    // clk = 0; #5 clk = 1; #100000
    // $display("   %b    |  %b   |   %b  |   %b   |   %b   |  %b   |  %b %b ",start,state,count,regAmode,regBmode,reg2WrEn,reset1,reset2);

    end
    /*initial begin
    $display("counter test");
    $display(" count ");
    reset1 = 0; reset2=1; wrenable = 1; clk = 0; #5 clk =1; #100
    $display(" %b", count);
    reset1=1; clk = 0; #5 clk =1; #100
    $display(" %b", count);
    end*/
endmodule
