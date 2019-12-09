// Single-bit register with enable
//   Positive edge triggered
`timescale 1 ns / 1 ps

//First a register, not made for 8 bits
module register
(
output reg	q,//input
input		d,//output
input		wrenable,//enable line
input		clk
);

    always @(posedge clk) begin //starts at posedge clock
        if(wrenable) begin//check if enables
            q <= d;//if enabled save the bit
        end
    end

endmodule

module register8bit//making the above register able to handle 8 bits
(
  output [7:0] q,//input, this time a bus so 8 bits
  input  [7:0] d,//output, can handle 8 bits, so is a bus
  input  wrenable,//enable line
  input  clk
);

  generate
  genvar i;
  for (i=0; i<8; i=i+1) begin//for loop that runs 8 times, one for each bit, saves bits in designated slot in bus
      register regSuzie (.d(d[i]),.wrenable(wrenable),.clk(clk),.q(q[i]));//call above register module to save each bit at noted index
  end
  endgenerate

endmodule
