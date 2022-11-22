`timescale 1ns / 1ps

module top(
    input clk100mhz,
    input [3:0] numIn0, numIn1,
    input confirm,
    output [3:0] pos0, pos1,
    output [7:0] seg0, seg1
    );
    wire clk380hz, confirmD;
    wire [3:0] pos0, pos1;
    wire [7:0] seg0, seg1;
    wire [31:0] dataBus;
    
    keyled keyled(clk100mhz, confirm, confirmD);
    clkDiv clkDiv(clk100mhz, clk380hz);
    GPU GPU(clk380hz, dataBus, pos0, pos1, seg0, seg1);
endmodule
