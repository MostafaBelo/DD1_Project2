`timescale 1ns/1ns

module synchronizer(input clk, SIG, output reg SIG_1);
    initial begin
        META = 1'b0;
        SIG_1 = 1'b0;
    end
    
    reg META;
        
    always @(posedge clk) begin
            META <= SIG;
            SIG_1 <= META;
    end
endmodule