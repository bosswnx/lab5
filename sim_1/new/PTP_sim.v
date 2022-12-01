`timescale 1ns / 1ps

module PTP_sim();
    reg clk100mhz = 0, in = 0;
    wire out;
    posedgeToPause PTP(clk100mhz, in, out);
    always #1 clk100mhz = ~clk100mhz;
    initial begin
        #1000
        in = 1;
        #1000
        in = 0;
        #1000
        in = 1;
        #1000
        in = 0;
    end
endmodule
