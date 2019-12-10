//------------------------------------------------------------------------
// Sequential multiplier
//------------------------------------------------------------------------

`include "shiftreg_mul.v"
`include "controlLogic_mul.v"

module multiplier
#(parameter width = 16)
(
  output [2*width-1:0]  res,   // Final result, valid when "done" is true
  output                done,  // High for one cycle when result is valid/complete
  input  [width-1:0]    A, B,  // Inputs to be multiplied
  input                 clk,   // Output transitions synchronized to posedge
  input                 start  // High for one cycle when inputs A and B are valid,
                               // initiates multiplication sequence
);


    // Intermediatry wires for LUT
    wire[1:0]  state;
    wire[1:0]  regAmode;
    wire[1:0]  regBmode;
    wire       reg2WrEn;
    wire       reset1;
    wire       reset2;
    wire[4:0]  cont;
    wire       done;

    // Initialize LUT
    controlLogic lut(.state(state),.regAmode(regAmode),.regBmode(regBmode),
    .reg2WrEn(reg2WrEn),.reset1(reset1),.reset2(reset2),.count(cont),
    .done(done),.clk(clk),.start(start));

    
    // Inititialize shift register wires, assign shift bit to 0
    wire[2*width-1:0] pOutA;
    wire[width-1:0] pOutB;
    wire sIn;
    assign sIn = 1'b0;

    // Make shift registers
    shiftregister #(.width(2*width)) shiftregA(.parallelOut(pOutA),.clk(clk),.mode(regAmode),.parallelIn({16'b0, A}),.serialIn(sIn));
    shiftregister #(.width(width))   shiftregB(.parallelOut(pOutB),.clk(clk),.mode(regBmode),.parallelIn(B),.serialIn(sIn));


    // Wires for adder functionality
    wire[2*width-1:0] toAdder;
    wire[2*width-1:0] toReg;
    wire[2*width-1:0] sum;
    wire[2*width-1:0] prevSum;

    // Make muxes
    mux2to1     #(.width(2*width)) opAmux(.out(toAdder),.address(pOutB[0]),.input0(32'b0),.input1(pOutA));
    mux2to1     #(.width(2*width)) resetRegMux(.out(toReg),.address(reset1),.input0(32'b0),.input1(sum)); //make sure it's actually reset1

    // Register for incremental sum
    register     #(.width(2*width)) sumReg(.q(prevSum),.d(toReg),.wrenable(reg2WrEn),.clk(clk));

    // Adder
    assign sum = toAdder + prevSum;

    // Set result
    assign res = prevSum;

endmodule
