// Abigail Fry, Alex Bahner, and Liv Kelley

/*
Behavioral test bench for the calculator. Just inputs binary instructions
directly into the system.
*/
`include "truncCalc.v"

module test_truncCalc();
    wire [31:0] result;
    reg [31:0] inst;
    reg clk;

    initial begin
    clk=0;
    end

    initial clk=0;
    always #200 clk = !clk;

    // // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;
    // #200 clk=1; #200 clk=0;

    // Instantiate cpu
    calc calc_inst(.clk(clk),
                  .result(result),
                  .instruction(inst));
    initial begin
    $dumpfile("trunk.vcd");
    $dumpvars();
    end
    //test case 1
    always @(posedge clk) begin
        inst = 32'b10000000000000010011111111111111;
    end

endmodule
