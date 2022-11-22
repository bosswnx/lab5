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
            11: seg = 8'b0011_1001;
            default: seg = 'b0000_0000;
        endcase
    end
endmodule

module GPU(
    input clk380hz,
    input [31:0] dataBus,
    output reg [3:0] pos0, pos1,
    output [7:0] seg0, seg1
    );
    reg [1:0] posC = 0;
    reg [3:0] dataP0 = 0, dataP1 = 0;
    initial begin
        pos0 = 0;
        pos1 = 0;
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

