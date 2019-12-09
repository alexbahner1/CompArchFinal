// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// Sequential Multiplier Control Logic

// Define states
`define WAIT      2'd0
`define SETUP     2'd1
`define COMPUTE   2'd2
`define DONE      2'd3

`include "counter.v"

/*
Finite State Machine

This is the FMS for our sequential multiplier. It has four states: WAIT, SETUP,
COMPUTE, and DONE. There is a start signal input and an internal counter that
determine state transitions. There are 6 control signals. regAmode and regBmode
determine the mode for the shift registers for operands A and B, respectively.
reg2WrEn is the write enable for the register that stores the incremental sum.
reset1 and reset2 are the select lines for the multiplexers in the counter and
the multiplexer for reset register mux. Count is the current value of the
counter, used to determine when the operation is done, and done is a flag that
turns to 1 when the operation is finished.
*/
module controlLogic
(
output reg[1:0]  state,
output reg[1:0]  regAmode,
output reg[1:0]  regBmode,
output reg       reg2WrEn,
output reg       reset1,
output reg       reset2,
output[1:0]      count,
output reg       done,
input            clk,
input            start
);

    // Instantiate counter
    counter4bit controlCounter(.count(count), .reset1(reset1), .reset2(reset2), .wrenable(1'b1),.clk(clk));

    /* Set the initial state so that there's a state when the multiplier is
    an initial set of operands, it has a beginning state so that it can start.
    */
    initial state <= `WAIT;

    /*
    State transitions

    Sets the new state depending on the current state and the start signal and
    the counter. If the current state is WAIT and start=1, the multiplier
    proceeds to the SETUP state. After one clock cycle, the multiplier proceeds
    from the SETUP state to the COMPUTE state. Once the counter reaches 3, the
    multiplier proceeds to the DONE state, and after one clock cycle, to the
    WAIT state until the start signal becomes 1 again.
    */
    always @(posedge clk) begin

        if (state == `WAIT) begin
            if (start == 1) begin
                state <= `SETUP;
            end else begin
                state <= `WAIT;
            end
        end
        if (state == `SETUP) begin
            state <= `COMPUTE;

        end
        if (state == `COMPUTE) begin
            if (count < 16) begin
                state <= `COMPUTE;
            end else if (count == 16) begin
                state <= `DONE;
            end
        end
        if (state == `DONE) begin
            state <= `WAIT;
        end
    end

    /*
    State and control signal LUT

    Sets control signals depending on the current state.
    */
    always @(state) begin
        case (state)
            `WAIT:     begin regAmode = 2'b00; regBmode = 2'b00; reg2WrEn=0; reset1=0; reset2=0; done=1; end
            `SETUP:    begin regAmode = 2'b11; regBmode = 2'b11; reg2WrEn=1; reset1=0; reset2=1; done=0; end
            `COMPUTE:  begin regAmode = 2'b01; regBmode = 2'b10; reg2WrEn=1; reset1=1; reset2=1; done=0; end
            `DONE:     begin regAmode = 2'b00; regBmode = 2'b00; reg2WrEn=0; reset1=0; reset2=0; done=1; end
        endcase
    end



endmodule
