`timescale 1ns / 1ps
module segMsg(
    input [3:0] data,
    output reg [7:0] seg
    );
    always @* begin
        case (data)
            0: seg = 8'b0011_1111;
            1: seg = 8'b0000_0110;
            2: seg = 8'b0101_1011;
            3: seg = 8'b0100_1111;
            4: seg = 8'b0110_0110;
            5: seg = 8'b0110_1101;
            6: seg = 8'b0111_1101;
            7: seg = 8'b0000_0111;
            8: seg = 8'b0111_1111;
            9: seg = 8'b0110_1111;
            10: seg = 8'b0111_0111;
            12: seg = 8'b0011_1001;
            default: seg = 'b0000_0000;
        endcase
    end
endmodule

module toBCD(
    input [15:0] in,
    output reg [15:0] out
    );
    always @* begin
        if (in < 10) begin
            out[15:4] = 12'hfff;
            out[3:0] = in;
        end
        else if (in < 100) begin
            out[15:8] = 8'hff;
            out[7:4] = in / 10;
            out[3:0] = in % 10;
        end
        else if (in < 1000) begin
            out[15:12] = 4'hf;
            out[11:8] = in / 100;
            out[7:4] = in / 10 % 10;
            out[3:0] = in % 10;
        end
        else begin
            out[15:12] = in / 1000;
            out[11:8] = in / 100 % 10;
            out[7:4] = in / 10 % 10;
            out[3:0] = in % 10;
        end
    end
endmodule

module GPU(
    input clk380hz,
    input [3:0] numin1, numin2,
    input state,
    input [6:0] cnt,
    input [13:0] res, sum,
    output reg [3:0] pos0, pos1,
    output [7:0] seg0, seg1
    );
    reg [1:0] posC = 0;
    reg [31:0] dataBus;
    reg [3:0] dataP0 = 0, dataP1 = 0;
    reg [15:0] in1;
    wire [15:0] out1;
    reg [7:0] in2, in3;
    wire [7:0] out2, out3;
    parameter AC = 8'hac;
    toBCD toBCD1(in1, out1);
    toBCD toBCD2(in2, out2);
    toBCD toBCD3(in3, out3);
    always @(*) begin
        if (state) begin
            dataBus = {AC, out2, out1};
            in1 = sum;
            in2 = cnt;
        end
        else begin
            dataBus = {out2, out3, out1};
            in1 = res;
            in2 = numin1;
            in3 = numin2;
        end
    end
    
    segMsg segMsg0(dataP0, seg0);
    segMsg segMsg1(dataP1, seg1);
    always @(posedge clk380hz) begin
        posC <= posC + 1;
        case (posC)
            0: begin
                pos0 <= 'b0001;
                pos1 <= 'b0001;
                dataP0 <= dataBus[19:16];
                dataP1 <= dataBus[3:0];
            end
            1: begin
                pos0 <= 'b0010;
                pos1 <= 'b0010;
                dataP0 <= dataBus[23:20];
                dataP1 <= dataBus[7:4];
            end
            2: begin
                pos0 <= 'b0100;
                pos1 <= 'b0100;
                dataP0 <= dataBus[27:24];
                dataP1 <= dataBus[11:8];
            end
            3: begin
                pos0 <= 'b1000;
                pos1 <= 'b1000;
                dataP0 <= dataBus[31:28];
                dataP1 <= dataBus[15:12];
            end
        endcase
    end
endmodule

