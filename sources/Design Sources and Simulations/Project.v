`timescale 1ns/1ns

module Project(input clk, btnStart, btnL, btnR, input [7:0] InA, InB, output IsDone, output [3:0] ssd_enables, output [6:0] ssd_segments);
    wire clk_out; // a slowed down clock for physical interaction modules
    clock_divider #(.n(250000)) new_clk(.clk_in(clk), .clk_out(clk_out)); // n = 1 for simulation testing, n = 250000 for FPGA
    
    wire BtnStart, BtnL, BtnR;
    push_button pStart (.clk(clk_out), .SIG(btnStart), .SIG_out(BtnStart));
    push_button pLeft (.clk(clk_out), .SIG(btnL), .SIG_out(BtnL));
    push_button pRight (.clk(clk_out), .SIG(btnR), .SIG_out(BtnR));
    
    wire start;
    assign start = BtnStart & IsDone;
    
    wire IsNeg;
    wire [15:0] product;
    wire [19:0] Digits;
    wire [15:0] Current_Digits;
    Signed_Sequential_Multiplier multiplier (.clk(clk), .start(BtnStart), .InA(InA), .InB(InB), .IsDone(IsDone), .IsNeg(IsNeg), .product(product));
    Binary_to_BCD BCD (.bin(product), .bcd(Digits));
    DigitShifter shift (.clk(clk_out), .init(start), .BtnL(BtnL), .BtnR(BtnR), .IsNeg(IsNeg), .Digits(Digits), .Digit_out(Current_Digits));
    SSD_render ssdrender (.clk(clk_out), .Digit(Current_Digits), .ssd_enables(ssd_enables), .ssd_segments(ssd_segments));
endmodule