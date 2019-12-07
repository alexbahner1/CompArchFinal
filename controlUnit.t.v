// Abigail Fry, Alex Bahner, Liv Kelley
// Structure developed based on previous work (specifically Todo Team Name's 3rd Lab Control Logic Test Bench)

/*
Control logic test bench
Tests the control logic by inputting different function operators and seeing if the outcome is the same.
*/

`include "controlUnit.v"
module controlUnitTest();


    wire ADD 3'b100
    wire SUB 3'b101
    //wire MULT 3'b110
    //wire DIV 3'b111

    wire ADDToPrev 3'b000
    wire SUBToPrev 3'b001
    //wire MULTWithPrev 3'b010
    //wire DIVByPrev 3'b011

    reg [2:0] testFunct;
    reg testStorePrevControl;
    reg testSignControl;
    reg testMemControl;

controlLogic dut(.funct(funct),
                .clk(clk));

initial begin

$display("                                                                                                                        ");
$display("control logic test");
$display("                                                                                                                        ");
$display("funct | storePrevControl | signControl  |  memControl");
funct =  3'b100 ; testStorePrevControl = 1'b0; testSignControl = 1'b0; testMemControl = 1'b0; #100000
$display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
funct =  3'b101 ; testStorePrevControl = 1'b0; testSignControl = 1'b1; testMemControl = 1'b0; #100000
$display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b110 ; testStorePrevControl = 1'b0; testSignControl = 1'b0; testMemControl = 1'b0; #100000
// $display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b111 ; testStorePrevControl = 1'b0; testSignControl = 1'b1; testMemControl = 1'b0; #100000
// $display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
funct =  3'b000 ; testStorePrevControl = 1'b1; testSignControl = 1'b0; testMemControl = 1'b1; #100000
$display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
funct =  3'b001 ; testStorePrevControl = 1'b1; testSignControl = 1'b1; testMemControl = 1'b1; #100000
$display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b010 ; testStorePrevControl = 1'b1; testSignControl = 1'b0; testMemControl = 1'b1; #100000
// $display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b011 ; testStorePrevControl = 1'b1; testSignControl = 1'b1; testMemControl = 1'b1; #100000
// $display(" %b  |   %b   |  %b |  %b |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);

end

endmodule
