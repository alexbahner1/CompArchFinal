//------------------------------------------------------------------------------
// Toplevel Processor for limited function caclulator
//------------------------------------------------------------------------------

`include "adder32.v"
`include "registers.v"
`include "signExtend.v"
`include "2way32mux.v"
`include "instructionMem.v"
`include "controlUnit.v"
`include "decoder.v"

module calc (
input clk,
input [31:0] instruction,
output [31:0] result
  );
//**WIRING**\\

//adder
wire [31:0] pc_curr; //current program counter
wire [31:0] pc_up; //update program counter

//sign extend
wire [13:0] immA_14; //immediate A pre-sign extend
wire [31:0] immA_32; //immediate A post-sign extend, fed to addsub
wire [13:0] immB_14;  //immediate B pre-sign extend
wire [31:0] immB_32; //immediate B post-sign extend, fed to mux

//Add subtractor
wire[31:0] addsub_Bin; //B input for ALU

//Accumulator register
wire [31:0] accum_in;
wire [31:0] accum_out;

//Controller
wire signControl;
wire storePrevControl;

//memory
// wire [31:0] instruction;

wire [31:0] result;

//decoder
wire [2:0] funct_code;


//**MODULES**\\
//Control Unit
controlLogic CU(.signControl(signControl),
                .storePrevControl(storePrevControl),
                .memControl(), //empty of purpose
                .funct(funct_code), //TODO from decoder
                .clk(clk));

//decoder
instructionDecoder decode(.immB(immB_14),
              .immA(immA_14),
              .funct(funct_code),
              .instruction(instruction)
              );

//Sign Extend A
assign immA_32={18'b000000000000000000,immA_14};
assign immB_32={18'b000000000000000000,immB_14};
// signextend signExtendA(.sign_in(immA_14),
//                       .sign_out(immA_32));
//Sign Extend B
// signextend signExtendB(.sign_in(immB_14),
//                       .sign_out(immB_32));

//Novel Operation Mux
mux2way32b novel_op(.out(addsub_Bin),
                   .address(storePrevControl),
                   .input0(accum_out),
                   .input1(immB_32));

// Adder/Subtractor
FullAdder32bit add_sub(.sum(accum_in),
                     .carryout(), //no need to connect
                     .overflow(), //no need to connect
                     .a(immA_32),
                     .b(addsub_Bin),
                     .subtract(signControl));

//Accumulator register
register32 accumulator  (.q(accum_out),
               .d(accum_in),
               .wrenable(1'b1),  //TODO should the reg always update
               .clk(clk));

assign result=accum_out;

endmodule //
