//------------------------------------------------------------------------------
// Toplevel Processor for limited function caclulator
//------------------------------------------------------------------------------

`include "adder32.v"
`include "registers32.v"
`include "2way32mux.v"
`include "instructionMem.v"
`include "controlUnit.v"
`include "decoder.v"
// `include "multiplier.v"

module calc (
input clk0,
input clk1,  //clk multi
input reset
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

// wire [15:0] immA_mul;
// wire [15:0] immB_mul;

//Add subtractor
wire[31:0] addsub_Bin; //B input for ALU

//Accumulator register
wire [31:0] add_res;
wire [31:0] sub_res;
wire [31:0] addsub_res;
wire [31:0] mul_res;
wire [31:0] accum_in;
wire [31:0] accum_out;

//Controller
wire signControl;
wire storePrevControl;
wire op_in;

//memory
wire [31:0] instruction;

//decoder
wire [2:0] funct_code;



//**MODULES**\\
//Control Unit
controlLogic_cal CU(.signControl(signControl),
                .storePrevControl(storePrevControl),
                .op_in(op_in),
                .memControl(), //empty of purpose
                .funct(funct_code), //TODO from decoder
                .clk(clk0));

// Program Counter register
register32 PC  (.q(pc_curr),
               .d(reset ? 32'b0 : pc_up),
               .wrenable(1'b1),
               .clk(clk0));
// 32-bit adder
FullAdder32bit adder(.sum(pc_up),
                     .carryout(), //no need to connect
                     .overflow(), //no need to connect
                     .a(pc_curr),
                     .b(32'b00000000000000000000000000000100), //increment by 4
                     .subtract(1'b0));


//Instruction Memory (take 32-bits retrun 35-bit instructions)
memory instMem(.PC(pc_curr),
               .instruction(instruction),
               .data_out(), //no need to connect
               .data_in(),  //no need to connect
               .data_addr(), //no need to connect
               .clk(clk0),
               .wr_en() //no need to connect
);

//decoder
instructionDecoder decode(.immB(immB_14),
              .immA(immA_14),
              .funct(funct_code),
              .instruction(instruction)
              );

assign immA_32={18'b000000000000000000,immA_14};
assign immB_32={18'b000000000000000000,immB_14};

assign immA_mul={2'b00,immA_14};
assign immB_mul={2'b00,immB_14};

// //Sign Extend A
// signextend signExtendA(.sign_in(immA_14),
//                       .sign_out(immA_32));
// //Sign Extend B
// signextend signExtendB(.sign_in(immB_14),
//                       .sign_out(immB_32));

//Novel Operation Mux
mux2way32b novel_op(.out(addsub_Bin),
                   .address(storePrevControl),
                   .input0(accum_out),
                   .input1(immB_32));

// Adder/Subtractor
// FullAdder32bit add_sub(.sum(add_res),
//                      .carryout(), //no need to connect
//                      .overflow(), //no need to connect
//                      .a(immA_32),
//                      .b(addsub_Bin),
//                      .subtract(signControl));

FullAdderTest addSuber(.sum(add_res),
                     .carryout(),
                     .a(immA_32),
                     .b(addsub_Bin),
                     .carryin(signControl));

FullSubTest Suber(.sum(sub_res),
              .carryout(),
              .a(immA_32),
              .b(addsub_Bin),
              .carryin(1'b0));

mux2way32b operMuxaddsub(.out(addsub_res),
                      .address(signControl),
                      .input0(add_res),
                      .input1(sub_res));


multiplier multi(.res(mul_res),
                .done(),
                .A(immA_mul),
                .B(immB_mul),
                .clk(clk1),
                .start());


mux2way32b operation_in(.out(accum_in),
                        .address(op_in),
                        .input0(addsub_res),
                        .input1(mul_res));

//Accumulator register
register32 accumulator (.q(accum_out),
                        .d(accum_in),
                        .wrenable(1'b1),  //TODO should the reg always update
                        .clk(clk0));


endmodule //
