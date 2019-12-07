
// Abigail Fry, Alex Bahner, and Liv Kelley
// Inspired by Todo Team Name's decoder from Lab 3 (Liv's team)

/* Instruction Mem
Decodes inputted instructions so they can be parsed by the control logic.
*/

module instructionDecoder (

  output [13:0] immB, immA,
  output [2:0] funct,
  input [31:0] instruction // Leaving this right now, but we should probably do something
                           // more creative to represent how the user would press keys.
  );

  assign immB = instruction[13:0];
  assign immA = instruction[27:14];
  assign funct = instruction[30:28];


  endmodule
