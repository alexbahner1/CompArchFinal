//------------------------------------------------------------------------
// Shift Register
//   Parameterized width (in bits)
//   Shift register has multiple behaviors based on mode signal:
//     00 - hold current state
//     01 - shift right: serialIn becomes the new MSB, LSB is dropped
//     10 - shift left:  serialIn becomes the new LSB, MSB is dropped
//     11 - parallel load: parallelIn replaces entire shift register contents
//
//   All updates to shift register state occur on the positive edge of clk
//------------------------------------------------------------------------

`include "shiftregmodes_mul.v"

module shiftregister
#(parameter width = 8) // 8 bit register
(
  output [width-1:0]  parallelOut, // 8 bit output (zero extended Op A)
  input               clk,
  input [1:0]         mode,        // from the LUT
  input [width-1:0]   parallelIn,  // 8 bit input (zero extended Op A)
  input               serialIn
);

    // Register to hold current shift register value
    // Initial value set to "width" bits of zeros using Verilog repetition operator
    reg [width-1:0]  memory={width{1'b0}};

    assign parallelOut = memory; // Store shift outputs to make the
    initial memory=0;
    always @(posedge clk) begin
        case (mode)
            `HOLD:  begin memory <= memory; end // Hold means memory stays the same
            `LEFT:  begin memory <= {memory[width-2:0], serialIn}; end  // Shift values left
            `RIGHT:  begin memory <= {serialIn, memory[width-1:1]}; end // Shift values right
            `PLOAD:  begin memory <= parallelIn; end // Set the memory to be an input
        endcase
    end
endmodule
