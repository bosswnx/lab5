`timescale 1ns / 1ps

module keyled(
input clk,
input in,
output reg out
    );
    reg [25:0] count_low;
    reg [25:0] count_high;
    reg out_reg;
    parameter DELAY_TIME = 500000;
    always @(posedge clk)
        if (in == 0)
            count_low <= count_low + 1;
        else
            count_low <= 0;
    always @(posedge clk)
        if (in == 1)
            count_high <= count_high + 1;
        else
            count_high = 0;
    always @(posedge clk)
        if (count_high == DELAY_TIME)
            out <= 1;
        else if (count_low == DELAY_TIME)
            out <= 0;
endmodule

