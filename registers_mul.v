// Liv Kelley, Jamie O'Brien, Sabrina Pereira
// Sequential Multiplier Non-shift Registers

/*
Parameterized Register

This register is used to hold the value of the counter and the incremental
sum. The width parameter can be changed when instantiating the module to change
the size of the data being stored.
*/

module register
#(parameter width = 4)
(
output reg[width-1:0] q, // 4 bit output
input[width-1:0]      d, // 4 bit input
input                 wrenable,
input                 clk
);
    always @(posedge clk) begin
        if(wrenable) begin
            //q[31:0] <= d[31:0];
            q <= d;
        end
    end
endmodule
