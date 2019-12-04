`include "signExtend.v"


module test_signExtend();
  reg [15:0] sign_in;
  wire [31:0] sign_out;

  signextend se (.sign_in(sign_in),.sign_out(sign_out));

  initial begin

  sign_in=16'b0111001110111000; #10000
  $display("Sign Extend");
  $display("sign in, sign out");
  $display("%b      | %b       ", sign_in,sign_out);

  end
  endmodule
