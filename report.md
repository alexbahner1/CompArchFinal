# CompArch Lab 2: Sequential Multiplier
### Jamie, Sabrina, and Liv



## Implementation: Our Datapath Schematic

![](./img/Datapath_Circuit.png)

The datapath represents the way the operation itself is performed within the circuit. The way it is executed is through an 8 bit left shift, a 4 bit right shift, a 2to1by8 mux, an 8 bit adder, another 2to1by8 mux, and an 8 bit register file. First, four zeros are concatenated to the beginning of 4-bit operand A (op A) so that it is 8 bits long. When the opAmode control signal tells the register that loading is done and shifting can occur, it will begin shifting the bits of A one bit to the left at each clock cycle. This shifting will represent the shifting place value of the output of the multiplication result as multiplication occurs. At the same time, the 4 bit operand B (opB) will be loaded into a 4 bit right shift reg. The shifting of this value right at each time step will represent multiplication of different place values of operand B by operand A, which is the same as the digit by digit multiplication we normally do by hand. This allows us to always use the LSB of operand B to determine if we are multiplying by 0 or 1 at each step. The shifted operand A is an input to the first 2to1by8 mux and the other input is an 8 bit 0. The select line for this multiplexer is the LSB of the shifted operand B. If this bit is one, the output of the multiplexer is the shifted operand A. If this bit is zero, the output is zero. The output of the mux goes to the adder where we add it to the sum from the previous clock cycle. This sum goes through a 2to1by8 multiplexer to an 8 bit register where it is stored. The multiplexer exists here to allow us to toggle the select line, which is reset, such that when we load the shift registers in the "SETUP" state, we also store a zero in this register. This process continues until the circuit has iterated through every bit of operand B, at which point the sequential multiplication is complete. The 8 bit register output at this final step will be the final output of the sequential multiplication. 


## FSM State/Transition Diagram and Control Table

Our FMS for our sequential multiplier is shown below. It has four states: `WAIT`, `SETUP`,
`COMPUTE`, and `DONE`. 

![](./img/FSM.jpg)

There is a start signal input and an internal counter that
determine state transitions. If the current state is `WAIT` and `start=1`, the multiplier
proceeds to the `SETUP` state. After one clock cycle, the multiplier proceeds
from the `SETUP` state to the `COMPUTE` state. Once the counter reaches 3, the
multiplier proceeds to the `DONE` state, and after one clock cycle, to the
`WAIT` state until the start signal becomes 1 again.

![](./img/FSMstateTransitions.jpg)

There are six control signals. Signals `regAmode` and `regBmode`
determine the mode for the shift registers for operands A and B, respectively.
The `reg2WrEn` is the write enable for the register that stores the incremental sum, and
`reset1` and `reset2` are the select lines for the multiplexers in the counter and
the multiplexer for reset register mux. The `count` wire holds the current value of the
counter, used to determine when the operation is done, and `done` is a flag that
turns to 1 when the operation is finished.


![](./img/FSMcontrolSignals.jpg)


![](./img/testbench.jpg)

The datapath schematic below shows the circuit for a sequential multiplier that we have built using Verilog. We'll start by looking at the rightmost part of the diagram. After the start input is set to 1, a 2 bit state is fed into a register file that stores current state, and then into a lookup table that produces different control signals based on the state. These control signals will be used as mux inputs and write enables for certain registers. The counter circuit, which starts at 0 increments by 1 at each clock cycle, feeds into the LUT to help control whether or not the rest of the circuit is performing operations or in a holding state. 

![](./img/FSM_Circuit.png)

The FSM was tested in isolation by inputting the two operands and the start signal, and then
displaying the current state, the count, and the controls signals at every clock 
edge. The results are shown below. 

![](./img/FSMtest.jpg)

## Testing

### Testbench
When choosing test cases, we were sure to include the following:<br/>
`A=0000`, `B=0000` - to test when both operands are zero<br/>
`A=0000`, `B=1101` - to test when operand A is zero<br/>
`A=0101`, `B=0000` - to test when operand B is zero<br/>
`A=1111`, `B=1111` - to test when both operands are as large as possible<br/>
`A=0001`, `B=0001` - to test when both operands are 1<br/>
The rest of the test cases are to test when both operands are small, both are large, and when one is small and the other is large. As can be seen in the testbench below, the multiplier passed all of these tests.



### Failed Cases

At first, out multiplier was only returning zeroes. This is beacuse the write enable for the incremental sum register was always high, so the sum would be overwritten by zero in the `DONE` state. We then changed the write enable to be set by `reset1` to solve this issue.

At one point, our testbench was failing every test. The least two significant bits of the results were correct, but the rest were always zero. The error ended up being in the array size in the multiplexer that either sends the incremental sum or 8'b0 to the incremental sum register. The [1:0] and [7:0] were switched, which is why only two bits of the result were ever added. Switching them back fixed the error, and the multiplier passed every test after that. 

<img src="./img/testbench_failure.jpg" width="60%">

## Timing

As can be seen in the timing simulation from GTKWave below, the operands are changed on a negative clock edge. This will be processed by the multiplier at the next positive clock edge. At this positive clock edge, the state changes from `WAIT` (00) to `SETUP` (01). The `SETUP` state takes one clock cycle, then the multiplier proceeds to the `COMPUTE` (10) state, and remains in this state for four clock cycles. The state then changes to `DONE` (11) for one clock cycle and then back to `WAIT`. The result holds during the DONE and WAIT states. In all, the multiplier takes five clock cycles to compute the result. 

![](./img/timing.png)


