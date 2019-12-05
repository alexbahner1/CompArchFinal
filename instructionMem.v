// Abigail Fry, Alex Bahner, and Liv Kelley
// Inspired by Todo Team Name's decoder from Lab 3 (Liv's team)

/* Instruction Mem
Decodes inputted instructions so they can be parsed by the control logic.
*/

module instructionDecoder (
  output [15:0] immA,
  output [15:0] immB,
  output [2:0] funct,
  input [31:0] instruction // Leaving this right now, but we should probably do something
                           // more creative to represent how the user would press keys.

  );

// End is 33 thanks to indexing from 0. I think this works, but it might be worth revisiting.

  assign [2:0] funct = instruction[2:0]
  assign [15:0] immA = instruction[17:3]
  assign [15:0] immB = instruction[33:18]

  endmodule
