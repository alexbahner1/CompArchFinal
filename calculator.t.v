
`include "calculator.v"


//------------------------------------------------------------------------
// Simple Calculator testbench sequence
//------------------------------------------------------------------------

module cpu_test ();

  reg clk0; // slow multiplier clock
  reg clk1; // fast multiplier clock
  reg reset;

  // Clock generation
  initial clk0=0;
  always #100 clk0 = !clk0;
  initial clk1=0;
  always #5 clk1 = !clk1;

  calc calc_inst(.clk(clk0));

  reg [1023:0] mem_text_fn = "test/adding.text.hex";
  reg [1023:0] mem_data_fn;
  reg [1023:0] dump_fn = "HelpUs.vcd";
  reg init_data = 0;

  initial begin
    // assign clk = 1'b0;
    // assign clk = 1'b1;
  ///  assign reset = 1'b1;
    #100;
    //assign reset = 1'b0;
    // assign clk = 1'b0;
  end

  // initial begin
endmodule
