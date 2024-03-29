// Abigail Fry, Alex Bahner, Liv Kelley
// Structure developed based on previous work (specifically Todo Team Name's 3rd Lab Control Logic Test Bench)

/*
Control logic test bench
Tests the control logic by inputting different function operators and seeing if the outcome is the same.
*/

`include "controlUnit.v"

`define ADD 3'b100
`define SUB 3'b101
//wire MULT 3'b110
//wire DIV 3'b111

`define ADDToPrev 3'b000
`define SUBToPrev 3'b001
//wire MULTWithPrev 3'b010
//wire DIVByPrev 3'b011

module controlUnitTest();

    wire signControl;
    wire storePrevControl;
    wire memControl;
    reg [2:0] funct;


    reg testSignControl;
    reg testStorePrevControl;
    reg testMemControl;

controlLogic dut(.signControl(signControl),
                 .storePrevControl(storePrevControl),
                 .memControl(memControl),
                 .funct(funct),
                .clk(clk));

initial begin

$display("                                                                                                                        ");
$display("control logic test");
$display("                                                                                                                        ");
$display("funct | storePrevControl | signControl  |  memControl  |");
funct =  3'b100 ; testStorePrevControl = 1'b0; testSignControl = 1'b0; testMemControl = 1'b0; #100000
$display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
funct =  3'b101 ; testStorePrevControl = 1'b0; testSignControl = 1'b1; testMemControl = 1'b0; #100000
$display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b110 ; testStorePrevControl = 1'b0; testSignControl = 1'b0; testMemControl = 1'b0; #100000
// $display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b111 ; testStorePrevControl = 1'b0; testSignControl = 1'b1; testMemControl = 1'b0; #100000
// $display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
funct =  3'b000 ; testStorePrevControl = 1'b1; testSignControl = 1'b0; testMemControl = 1'b1; #100000
$display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
funct =  3'b001 ; testStorePrevControl = 1'b1; testSignControl = 1'b1; testMemControl = 1'b1; #100000
$display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b010 ; testStorePrevControl = 1'b1; testSignControl = 1'b0; testMemControl = 1'b1; #100000
// $display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);
// funct =  3'b011 ; testStorePrevControl = 1'b1; testSignControl = 1'b1; testMemControl = 1'b1; #100000
// $display(" %b  |        %b         |      %b       |       %b      |", funct, storePrevControl == testStorePrevControl, signControl == testSignControl, memControl == testMemControl);

end

endmodule
