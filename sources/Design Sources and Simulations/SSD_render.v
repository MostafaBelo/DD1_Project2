`timescale 1ns/1ns

module SSD_render(input clk, input [15:0] Digit, output reg [3:0] ssd_enables, output reg [6:0] ssd_segments);
    initial begin
        ssd_enables = digit0;
    end
    
    wire [3:0] currentDigits [3:0];
    reg [3:0] selectedDigit;
    
    reg [3:0] next_ssd_enables;
    localparam [3:0] digit0 = 4'b1110, digit1 = 4'b1101, digit2 = 4'b1011, digit3 = 4'b0111;

    always @(*) begin
        case (ssd_enables)
            digit0: next_ssd_enables = digit1;
            digit1: next_ssd_enables = digit2;
            digit2: next_ssd_enables = digit3;
            digit3: next_ssd_enables = digit0;
            default: next_ssd_enables = digit0;
        endcase
    end

    always @(posedge clk) begin
        ssd_enables <= next_ssd_enables;
    end
    
    always @(*) begin
        case (ssd_enables)
            digit0: selectedDigit = {currentDigits[0][3], currentDigits[0][2], currentDigits[0][1], currentDigits[0][0]};
            digit1: selectedDigit = {currentDigits[1][3], currentDigits[1][2], currentDigits[1][1], currentDigits[1][0]};
            digit2: selectedDigit = {currentDigits[2][3], currentDigits[2][2], currentDigits[2][1], currentDigits[2][0]};
            digit3: selectedDigit = {currentDigits[3][3], currentDigits[3][2], currentDigits[3][1], currentDigits[3][0]};
            default: selectedDigit = {currentDigits[0][3], currentDigits[0][2], currentDigits[0][1], currentDigits[0][0]};
        endcase
    end
    
    localparam [6:0] ZeroSegments = 7'b0000001, OneSegments = 7'b1001111, TwoSegments = 7'b0010010, ThreeSegments = 7'b0000110, FourSegments = 7'b1001100, FiveSegments = 7'b0100100,
                    SixSegments = 7'b0100000, SevenSegments = 7'b0001111, EightSegments = 7'b0000000, NineSegments = 7'b0000100, NegativeSegments = 7'b1111110, BlankSegments = 7'b1111111;
    always @(*) begin
        case (selectedDigit)
            4'b0000: ssd_segments = ZeroSegments;
            4'b0001: ssd_segments = OneSegments;
            4'b0010: ssd_segments = TwoSegments;
            4'b0011: ssd_segments = ThreeSegments;
            4'b0100: ssd_segments = FourSegments;
            4'b0101: ssd_segments = FiveSegments;
            4'b0110: ssd_segments = SixSegments;
            4'b0111: ssd_segments = SevenSegments;
            4'b1000: ssd_segments = EightSegments;
            4'b1001: ssd_segments = NineSegments;
            4'b1010: ssd_segments = NegativeSegments;
            4'b1011: ssd_segments = BlankSegments;
            default: ssd_segments = BlankSegments;
        endcase
    end
    
    assign {currentDigits[3],currentDigits[2],currentDigits[1],currentDigits[0]} = Digit;
endmodule
