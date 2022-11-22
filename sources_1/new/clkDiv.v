`timescale 1ns / 1ps

module clkDiv(
input clk100mhz,
output clk380hz
    );
    reg [25:0] count = 0;
    assign clk380hz = count[17];
    always@(posedge clk100mhz)
        count <= count + 1;
endmodule

