/*Test Bench for adder/subtractor component from adder32.v file. Test cases were chosen to include various carryout and overflows*/

//declare timing, import file
`timescale 1 ns / 1 ps
`include "adder32.v"

//declare module, and variables needed to run the Adder/Subtractor
module testFullAdder();
    reg [31:0] a;
    reg [31:0] b;
    reg carryin;
    wire [31:0] sum;
    wire overflow;
    wire carryout;
    wire [31:0] bin;
//call the adder/subtractor
    FullAdder32bit adder (.sum(sum),.carryout(carryout),.overflow(overflow),.a(a),.b(b),.subtract(carryin));

    initial begin

    // $dumpfile("adder-signals.vcd");
    // $dumpvars();
    // $display(a,b,carryin,sum,carryout);

    #1000

    // ========================== ADDER ======================================== test cases
    $display(" Adder");
    carryin=0; a=32'b11111111111111111111111111111111; b=32'b11111111111111111111111111111111; #10000
    $display(" %b | %b | %b   | %b | %b    | %b   |", a,b,carryin,sum,carryout,overflow, " 1        | 0");
    carryin=0; a=32'b10101010101010101010101010101010; b=32'b10101010101010101010101010101010; #10000
    $display(" %b | %b | %b   | %b | %b    | %b   |", a,b,carryin,sum,carryout,overflow, " 1        | 1");
    carryin=0; a=32'b01010101010101010101010101010101; b=32'b01010101010101010101010101010101; #10000
    $display(" %b | %b | %b   | %b | %b    | %b   |", a,b,carryin,sum,carryout,overflow, " 0        | 1");
    carryin=0; a=32'b00100010001000100010001000100010; b=32'b10101010101010101010101010101010; #10000
    $display(" %b | %b | %b   | %b | %b    | %b   |", a,b,carryin,sum,carryout,overflow, " 0        | 0");

    end
endmodule
