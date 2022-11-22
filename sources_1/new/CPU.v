`timescale 1ns / 1ps

module CPU(
    input clk, rst,
    input [3:0] in1, in2,
    input btn,
    output reg [31:0] dataBus
    );
    parameter AC = 8'hac;
    reg state;
    reg [6:0] cnt;
    reg [13:0] sum;
    always @(posedge clk) begin
        if (!rst) begin
            state <= 0;
            cnt <= 0;
        end
        else if (btn) begin
            if (state) begin
                
            end
            else begin
                
            end
        end
    end
endmodule
