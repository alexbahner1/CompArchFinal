// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// Sequenctial Multiplier Multiplexers

/*
Parameterized 2to1 Mux

This is a two input multiplexer. The width parameter can be changed at
instantiation to accomodate differently sized inputs and outputs. 
*/
module mux2to1
#(parameter width = 8)
(
output[width-1:0]  out,
input	     	 address,
input[width-1:0]   input0, input1
);
    wire[width-1:0] mux[1:0];	      // Create a 2D array of wires
    assign mux[0] = input0;   // Connect the sources of the array
    assign mux[1] = input1;

    assign out = mux[address];	// Connect output of array
endmodule
