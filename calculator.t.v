//


`include "calculator.v"


//------------------------------------------------------------------------
// Simple Calculator testbench sequence
//------------------------------------------------------------------------

module cpu_test ();

  reg clk0; // slow module clock
  reg clk1; // fast multiplier clock
  reg reset;

  // Clock generation
  initial clk0=0;
  always #200 clk0 = !clk0;
  initial clk1=0;
  always #5 clk1 = !clk1;

  calc calc_inst(.clk0(clk0), .clk1(clk1), .reset(reset));

  // reg [1023:0] mem_text_fn = "test/adding.text.hex";
  // reg [1023:0] mem_text_fn = "test/subtraction.text.hex";
  // reg [1023:0] mem_text_fn = "test/multi.text.hex";
  reg [1023:0] mem_text_fn = "test/divi.text.hex";
  reg [1023:0] mem_data_fn;
  reg [1023:0] dump_fn = "HelpUs.vcd";
  reg init_data = 0;

  // initial begin
  //     assign clk = 1'b0;
  //     assign clk = 1'b1;
  //     assign reset = 1'b1;
  //   #100;
  //     assign reset = 1'b0;
  //     assign clk = 1'b0;
  // end

initial calc_inst.PC.q = 32'b0;

  initial begin
  // if (! $value$plusargs("mem_text_fn=%s", mem_text_fn)) begin
  //       $display("ERROR: provide +mem_text_fn=[path to .text memory image] argument");
  //       $finish();
  //         end
  //
  //   if (! $value$plusargs("dump_fn=%s", dump_fn)) begin
  //       $display("ERROR: provide +dump_fn=[path for VCD dump] argument");
  //       $finish();
  //         end

  $readmemh(mem_text_fn, calc_inst.instMem.mem, 0);
    //if (init_data) begin
    //  $readmemh(mem_data_fn, calc_inst.memory0.mem, 4095);
    //    end


  $dumpfile(dump_fn);
  $dumpvars();

  // Display a few cycles just for quick checking
	// Note: I'm just dumping instruction bits, but you can do some
	// self-checking test cases based on your CPU and program and
	// automatically report the results.


	$display("Time | PC       | Instruction");

  reset = 1'b1;
  #300
  reset = 1'b0;

	repeat(100) begin
        #20; // $display("%4t | %h | %h", $time, calc_inst.fetchunit.PCout, calc_inst.memory0.instruction); #20 ;
        end
	$display("... more execution (see waveform)");

	// End execution after some time delay - adjust to match your program
	// or use a smarter approach like looking for an exit syscall or the
	// PC to be the value of the last instruction in your program.
	#1000 $finish();
    end
  // initial begin
endmodule
