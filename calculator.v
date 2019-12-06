//------------------------------------------------------------------------------
// Toplevel Processor for limited function caclulator
//------------------------------------------------------------------------------

`include "adder32.v"
`include "registers.v"
`include "signExtend.v"
`include "2way32mux.v"
`include "instructionMem.v"
`include "controlUnit.v"

module calc (
input clk
  );
//**WIRING**\\

//adder
wire [31:0] pc_curr; //current program counter
wire [31:0] pc_up; //update program counter

//sign extend
wire [15:0] immA_16; //immediate A pre-sign extend
wire [31:0] immA_32; //immediate A post-sign extend, fed to addsub
wire [15:0] immB_16;  //immediate B pre-sign extend
wire [31:0] immB_32; //immediate B post-sign extend, fed to mux

//Add subtractor
wire[31:0] addsub_Bin; //B input for ALU

//Accumulator register
wire [31:0] accum_in;
wire [31:0] accum_out;

//Controller
wire signControl;
wire storePrevControl;


//**MODULES**\\
//Control Unit
controlLogic CU(.signControl(signControl),
                .storePrevControl(storePrevControl),
                .memControl(), //empty of purpose
                .funct(), //TODO from decoder
                .clk(clk));

// Program Counter register
register32 PC  (.q(pc_curr),
               .d(pc_up),
               .wrenable(1'b1),
               .clk(clk));
// 32-bit adder
FullAdder32bit adder(.sum(pc_up),
                     .carryout(), //no need to connect
                     .overflow(), //no need to connect
                     .a(pc_curr),
                     .b(), //TODO need to figure out how much to increment by
                     .subtract(1'b0));


//Instruction Memory (take 32-bits retrun 35-bit instructions)

//Sign Extend A
signextend signExtendA(.sign_in(immA_16),
                      .sign_out(immA_32));
//Sign Extend B
signextend signExtendB(.sign_in(immB_16),
                      .sign_out(immB_32));

//Novel Operation Mux
mux2way32b novel_op(.out(addsub_Bin),
                   .address(storePrevControl), //TODO control signal
                   .input0(accum_out),
                   .input1(immB_32));

// Adder/Subtractor
FullAdder32bit add_sub(.sum(accum_in),
                     .carryout(), //TODO check no need to connect
                     .overflow(), //TODO check no need to connect
                     .a(immA_32),
                     .b(addsub_Bin),
                     .subtract(signControl));

//Accumulator register
register32 accumulator  (.q(accum_out),
               .d(accum_in),
               .wrenable(1'b1),  //TODO should the reg always update
               .clk(clk));


endmodule //
