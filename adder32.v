/*File includes module for a 1 bit stuctural adder and a 32-bit strucutral adder*/

// define gate delays based on # of inputs and inverters
`define XOR2 xor #30
`define AND2 and #30
`define OR2 or #30

`timescale 1 ns / 1 ps

//1-bit adder takes inputs a,b, and carryin
//returns sum and  carryout
module structuralFullAdder
(
    output sum,
    output carryout,
    input a,
    input b,
    input carryin
);
    wire xorab;
    wire xorcab;
    wire andab;
    wire andcxor;

    `XOR2 xorgate0(xorab,a,b);
    `XOR2 xorgate1(sum,xorab,carryin);
    `AND2 andgate0(andcxor,xorab,carryin);
    `AND2 andgate1(andab,a,b);
    `OR2 orgate(carryout,andab,andcxor);

endmodule

//Module for 32-bit mux, takes 32-bit inputs of a,b, 1-bit subtract signal, returns overflow, carryout and 32-bit sum
//NOTE: Our adder will not work if we want to do addition with a carryin- it will thinkthat means subtraction b/c way we programmed this.
module FullAdder32bit
(
  output [31:0] sum,
  output carryout,
  output overflow,
  input [31:0] a,
  input [31:0] b,
  input subtract
  );

  wire [30:0] cout;
  wire [31:0] bin;

  // define b inverted for subtraction
  generate
  genvar j;
  for (j=0; j < 32; j=j+1) begin
    `XOR2 xorgate(bin[j],subtract,b[j]);
  end
  endgenerate

  /*define 32-bit adder composed of 1-bit adders
  * (define first adder by itself because it has unique carryin)
  */
  structuralFullAdder adder0 (sum[0],cout[0],a[0],bin[0],subtract);
  generate
  genvar i;
  for (i=1; i < 31; i=i+1) begin
    structuralFullAdder adder (sum[i],cout[i],a[i],bin[i],cout[i-1]);
  end
  endgenerate
  // define last adder by itself because it has unique carryout
  structuralFullAdder adder31 (sum[31],carryout,a[31],bin[31],cout[30]);

  // calculate overflow
  `XOR2 xorgate1 (overflow,carryout,cout[30]);

  endmodule
