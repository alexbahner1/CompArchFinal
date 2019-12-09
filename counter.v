// Liv Kelley, Jamie O'Brien, and Sabrina Pereira
// Sequential Multiplier Counter Module
`include "registers_mul.v"
`include "mux.v"

/*
This counter is intended to count up to 3 to match the index of the bit of
operandB that is being checked to determine if the operation is complete.
When the counter reaches 3, the FSM will go from the COMPUTE state to the DONE
state.
*/
module counter4bit
#(parameter width = 2)
(
output[1:0]     count,
input           reset1,
input           reset2,
input           wrenable,
input           clk
);
    wire[1:0]   current;
    wire[1:0]   out;
    wire[1:0]   constant;
    wire[1:0]   sum;

    register  #(.width(width)) counterReg(.q(count),.d(sum),.wrenable(wrenable),.clk(clk));
    mux2to1   #(.width(width)) counterMux0(.out(current),.address(reset2),.input0(2'b0),.input1(count));
    mux2to1   #(.width(width)) counterMux1(.out(constant),.address(reset1),.input0(2'b0),.input1(2'b1)); //Do we still want to use this design?

    assign sum = (current + constant);

endmodule
