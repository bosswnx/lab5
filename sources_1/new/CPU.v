`timescale 1ns / 1ps

module CPU(
    input clk,
    input rst,
    input [3:0] in1, in2,
    input btn,
    output reg state = 0,
    output reg [6:0] cnt,
    output reg [13:0] res, sum
    );
    reg [3:0] num1 = 0, num2 = 0;
    parameter AC = 8'hac;
    always @(posedge clk, negedge rst) begin
        if (!rst) begin
            cnt <= 0;
            sum <= 0;
            state <= 0;
        end
        else if (btn && !state) begin
            state <= 1;
            sum <= sum + res;
            cnt <= cnt + 1;
        end
        else if (in1 != num1 || in2 != num2) begin
            num1 <= in1;
            num2 <= in2;
            res <= in1 * in2;
            state <= 0;
        end
    end
endmodule
