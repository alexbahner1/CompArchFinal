// Abigail Fry, Alex Bahner, and Liv Kelley
// Test bench based on Todo Team Name's decode test bench from Lab 3 (Liv's team)

/*
Test Bench for the Instruction Memory
*/

`include "instructionMem.v"
module instructionMemTest();
    wire [15:0] immB, immA;
    wire [2:0] funct;
    reg [34:0] instruction;

    reg [15:0] testImmB;
    reg [15:0] testImmA;
    reg [2:0] testFunct;


instructionDecoder dut(.immB(immB),
                       .immA(immA),
                       .funct(funct),
                       .instruction(instruction));


initial begin

$display("                                                                                                                        ");
$display("instruction memory test");
$display("                                                                                                                        ");
$display("           instruction                | funct |immA|immB|");
instruction = 35'b11100000000000000001111111111111111; testFunct = 3'b111; testImmA = 16'b0000000000000000; testImmB = 16'b1111111111111111; #100000
$display(" %b  |   %b   |  %b |  %b |", instruction, funct == testFunct, immA == testImmA, immB == testImmB);
end

endmodule
