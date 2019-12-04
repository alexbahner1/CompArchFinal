module mux2way32b(//this module is a 2 way 8 bit mux
  output [31:0] out,//initialize the 8 bit output
  input address,
  input [31:0] input0, input1//each of the two inputs are 8 bits
  );

  wire [31:0] mux [31:0];

  assign mux[0] = input0; //assign input 0 to mux[0]
  assign mux[1] = input1;//assign input 1 to mux[1]
  assign out = mux[address];//return the input for the given address

endmodule
