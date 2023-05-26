`timescale 1ns/1ns

module Signed_Sequential_Multiplier(input clk, start, input [7:0] InA, InB, output IsDone, IsNeg, output [15:0] product);
    wire [1:0] SA, SB, SC;
    wire SNeg;
    multiplier_CU cu(.clk(clk), .start(start), .SA(SA), .SB(SB), .SC(SC), .isDone(IsDone), .SNeg(SNeg));
    Multiplier_DataPath dp(.clk(clk), .SNeg(SNeg), .SA(SA), .SB(SB), .SC(SC), .InA(InA), .InB(InB), .IsNeg(IsNeg), .product(product));
endmodule