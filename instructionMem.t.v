// Abigail Fry, Alex Bahner, and Liv Kelley
// Test bench based on Todo Team Name's decode test bench from Lab 3 (Liv's team)

/*
Test Bench for the Instruction Memory
*/

`include "instructionMem.v"
module instructionMemTest ();
    wire [2:0] funct;
    wire [15:0] immA;
    wire [15:0] immB;
    reg [31:0] instruction;

    reg [2:0] testFunct;
    reg [15:0] testImmA;
    reg [15:0] testImmB;


instructionMem(.funct(funct),
               .immA(immA),
               .immB(immB));


intial begin

$display("                                                                                                                        ");
$display("instruction memory test");
$display("                                                                                                                        ");
$display("           instruction            |funct|   immediateA    |    immediateB   |");
instruction = 32'b111000000000000000111111111111111; testfunct = 3'b111; testImmA = 15'b000000000000000; testImmB = 15'b111111111111111; #100000
$display(" %b | %b  |     %b      |     %b      |", instruction, funct == testfunct, immA == testImmA, immB == testimmB);
end

endmodule
