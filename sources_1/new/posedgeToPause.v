`timescale 1ns / 1ps

module posedgeToPause(
    input clk,
    input in,
    input out
    );
    reg [1:0] state = 0;
    assign out = in && (state == 1);
    always @(posedge clk) begin
        if (in) begin
            if (state < 2)
                state = state + 1;
        end
        else
            state = 0;
    end
endmodule
