// Abigail Fry, Alex Bahner, and Liv Kelley
// Inspired by Todo Team Name's decoder from Lab 3 (Liv's team)

/* Instruction Mem
Decodes inputted instructions so they can be parsed by the control logic.
*/

module instructionDecoder (

  output [15:0] immB, immA,
  output [2:0] funct,
  input [34:0] instruction // Leaving this right now, but we should probably do something
                           // more creative to represent how the user would press keys.
  );

// End is 34 thanks to indexing from 0. I think this works, but it might be worth revisiting.

  assign immB = instruction[15:0];  // instruction[19:34] ??? Why isn't it this -- Check with Ben
  assign immA = instruction[34:16]; // instruction[3:18] ??? Why isn't it this -- Check with Ben
  assign funct = instruction[2:0];


  endmodule
