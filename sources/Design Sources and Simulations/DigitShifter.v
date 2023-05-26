`timescale 1ns/1ns

module DigitShifter(input clk, init, BtnL, BtnR, IsNeg, input [19:0] Digits, output [15:0] Digit_out);
    initial begin
        state = 2'b00;
    end
    
    wire [3:0] DigitsInside [4:0];
    reg [3:0] Digit_out_Inside [3:0];
    
    reg [1:0] state, nextState;

    always @(*) begin
        if (init) nextState = 2'b00;
        else if (BtnR && (state != 2'b00)) nextState = state-1;
        else if (BtnL && (state != 2'b10)) nextState = state+1;
        else nextState = state;
    end

    always @(posedge clk) begin
        state <= nextState;
    end
    
    wire [3:0] signDigit;
    assign signDigit = IsNeg ? 4'b1010 : 4'b1011; // 10 = -ve, 11 = +ve
    always @(*) begin
        case (state)
            2'b00: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {signDigit, DigitsInside[2], DigitsInside[1], DigitsInside[0]};
            2'b01: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {signDigit, DigitsInside[3], DigitsInside[2], DigitsInside[1]};
            2'b10: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {signDigit, DigitsInside[4], DigitsInside[3], DigitsInside[2]};
            default: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {signDigit, DigitsInside[2], DigitsInside[1], DigitsInside[0]};
        endcase
    end
    // law habeb el alg el adim aho
//    always @(*) begin
//        case (state)
//            2'b00: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {DigitsInside[3], DigitsInside[2], DigitsInside[1], DigitsInside[0]};
//            2'b01: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {DigitsInside[4], DigitsInside[3], DigitsInside[2], DigitsInside[1]};
//            2'b10: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {signDigit, DigitsInside[4], DigitsInside[3], DigitsInside[2]};
//            default: {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]} = {DigitsInside[3], DigitsInside[2], DigitsInside[1], DigitsInside[0]};
//        endcase
//    end
    
    assign {DigitsInside[4], DigitsInside[3],DigitsInside[2],DigitsInside[1],DigitsInside[0]} = Digits;
    assign Digit_out = {Digit_out_Inside[3], Digit_out_Inside[2], Digit_out_Inside[1], Digit_out_Inside[0]};
endmodule