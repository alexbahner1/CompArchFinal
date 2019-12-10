
// this code is inspired by look at code form this website
// https://verilogcodes.blogspot.com/2015/11/synthesisable-verilog-code-for-division.html

module division//(a,B,Res);

    //the size of input and output ports of the division module is generic.
    #(parameter width = 32)
    (
    //input and output ports.
    input [width-1:0] b,
    input [width-1:0] a,
    output [width-1:0] Res
    );
    //internal variables
    reg [width-1:0] Res = 0;
    reg [width-1:0] qot,divs;
    reg [width:0] remander;
    integer i;

    always@ (a or b)
    begin
        //initialize the variables.
        qot = a;
        divs = b;
        remander= 0;
        for(i=0;i < width;i=i+1)    begin //start the for loop
            remander = {remander[width-2:0],qot[width-1]};
            qot[width-1:1] = qot[width-2:0];
            remander = remander-divs;
            if(remander[width-1] == 1)    begin
                qot[0] = 0;
                remander = remander + divs;   end
            else
                qot[0] = 1;
        end
        Res = qot;
    end

endmodule
