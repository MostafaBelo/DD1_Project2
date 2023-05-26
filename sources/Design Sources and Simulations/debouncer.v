`timescale 1ns/1ns

module debouncer(input clk, in, output out);
    initial begin
        q1 = 1'b0;
        q2 = 1'b0;
        q3 = 1'b0;
    end
    
    reg q1,q2,q3;
    
    always@(posedge clk) begin
             q1 <= in;
             q2 <= q1;
             q3 <= q2;
    end
    assign out = q1 & q2 & q3;
endmodule