`timescale 1ns / 1ps

module CPU_sim();
    reg rst, numIn0, numIn1, confirmP;
    wire state, cnt, res, sum;
    CPU CPU(rst, numIn0, numIn1, confirmP, state, cnt, res, sum);
endmodule
