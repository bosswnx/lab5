`timescale 1ns / 1ps

module top(
    input clk100mhz,
    input [3:0] numIn0, numIn1,
    input rst, btn,
    output [3:0] pos0, pos1,
    output [7:0] seg0, seg1
    );
    wire clk380hz, confirmD, confirmP;
    wire state;
    wire [6:0] cnt;
    wire [13:0] res, sum;
    
    keyled keyled(clk100mhz, btn, confirmD);
    posedgeToPause keyptp(clk100mhz, confirmD, confirmP);
    clkDiv clkDiv(clk100mhz, clk380hz);
    GPU GPU(clk380hz, numIn0, numIn1, state, cnt, res, sum, pos0, pos1, seg0, seg1);
    CPU CPU(clk100mhz, rst, numIn0, numIn1, confirmP, state, cnt, res, sum);
endmodule
