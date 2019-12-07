//------------------------------------------------------------------------------
// Sign exted 16-bits to 32
//------------------------------------------------------------------------------


`timescale 1 ns / 1 ps

module signextend(

input [13:0] sign_in,
output [31:0] sign_out
  );

generate
genvar i;
for (i=14; i<32; i=i+1) begin
    assign sign_out[i] = sign_in[13];
end
endgenerate

assign sign_out[15:0] = sign_in[13:0];

endmodule
