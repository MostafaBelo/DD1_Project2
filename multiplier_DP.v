`timescale 1ns/1ns

module Multiplier_DataPath(input clk, SNeg, input [1:0] SA, SB, SC, input [7:0] InA, InB, output reg IsNeg, output reg [15:0] product);
    initial begin
        A = 16'b0;
        B = 16'b0;
        product = 16'b0;
        IsNeg = 1'b0;
    end
    
    wire [7:0] AbsA, AbsB;
    assign AbsA = (InA[7]) ? -InA : InA;
    assign AbsB = (InB[7]) ? -InB : InB;
    
    reg [15:0] A, B;
    localparam  [1:0] SALoad = 2'b00, SASHR = 2'b01, SASHL = 2'b10, SAStore = 2'b11;
    localparam  [1:0] SBLoad = 2'b00, SBSHR = 2'b01, SBSHL = 2'b10, SBStore = 2'b11;
    localparam  [1:0] SCStore = 2'b00, SCacc = 2'b01, SCclr = 2'b10;

    always @(posedge clk) begin
        case (SA)
            SALoad: A <= {8'b0, AbsA};
            SASHR: A <= A>>1;
            SASHL: A <= A<<1;
            default:
            // SStore
            // A <= A
            ;
        endcase
    end

    always @(posedge clk) begin
        case (SB)
            SBLoad: B <= {8'b0, AbsB};
            SBSHR: B <= B>>1;
            SBSHL: B <= B<<1;
            default:
            // SStore
            // B <= B
            ;
        endcase
    end
    
    always @(posedge clk) begin
        case (SC)
            SCacc: product <= product + (B[0] ? A : 16'b0);
            SCclr: product <= 0;
            default:
            // SCStore
            // product <= product
            ;
        endcase
    end

    always @(posedge clk) begin
        if (SNeg)
            IsNeg <= (InA[7] ^ InB[7]) && ~(InA == 0) && ~(InB == 0);
    end
endmodule
