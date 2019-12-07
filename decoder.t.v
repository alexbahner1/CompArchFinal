// Abigail Fry, Alex Bahner, and Liv Kelley
// Test bench based on Todo Team Name's decode test bench from Lab 3 (Liv's team)

/*
Test Bench for the Instruction Memory
*/

`include "decoder.v"
module instructionMemTest();
    wire [13:0] immB, immA;
    wire [2:0] funct;
    reg [31:0] instruction;

    reg [13:0] testImmB;
    reg [13:0] testImmA;
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
instruction = 32'b01110000000000000011111111111111; testFunct = 3'b111; testImmA = 14'b00000000000000; testImmB = 14'b11111111111111; #100000
$display("  %b    |   %b   |  %b |  %b |", instruction, funct == testFunct, immA == testImmA, immB == testImmB);
end

endmodule
