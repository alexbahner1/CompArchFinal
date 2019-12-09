// Abigail Fry, Alex Bahner, Liv Kelley
// Structure developed based on previous work (specifically Todo Team Name's 3rd Lab Control Logic)

// TODO: We need to think about how the multiplication/division would happen.
//       We also have to consider whether there will be a mux and inverter controlling
//       whether things get subtracted or if we just input a negative #

// Define opcodes

`define ADD 3'b100
`define SUB 3'b101
//`define MULT 3'b110
//`define DIV 3'b111

`define ADDToPrev 3'b000
`define SUBToPrev 3'b001
//`define MULTWithPrev 3'b010
//`define DIVByPrev 3'b011

/*
Control logic: LUT
*/

module controlLogic
(
output reg signControl, //0 means add, 1 means subtract
output reg storePrevControl,  //mux
output reg memControl,
output reg op_in,
input [2:0] funct,
input clk
);

always @* begin
  case(funct)
  `ADD:   begin    storePrevControl=1'b0; signControl=1'b0; memControl = 1'b0; op_in = 1'b0; end
  `SUB:   begin    storePrevControl=1'b0; signControl=1'b1; memControl = 1'b0; op_in = 1'b0; end
  //`MULT: begin storePrevControl = 1'b0 ; signControl = 1'b0 ; memControl = 1'b0; end
  //`DIV: begin storePrevControl = 1'b0 ; signControl = 1'b1 ; memControl = 1'b0; end

  `ADDToPrev:   begin   storePrevControl=1'b1; signControl=1'b0 ; memControl = 1'b1; op_in = 1'b0; end
  `SUBToPrev:   begin   storePrevControl=1'b1; signControl=1'b1 ; memControl = 1'b1; op_in = 1'b0; end
  //`MULTWithPrev: begin storePrevControl =  1'b1; signControl = 1'b0 ; memControl = 1'b1; end
  //`DIVByPrev: begin storePrevControl =  1'b1; signControl = 1'b1 ; memControl = 1'b1; end
  endcase
  end
 endmodule
