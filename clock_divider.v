`timescale 1ns/1ns

module clock_divider(input clk_in, output reg clk_out);
    initial begin
        clk_out <= 1'b0;
    end

    parameter n = 250000;
    wire [31:0] count;

    wire en;
    assign en = 1'b1;
    
    mod_n_counter #(.n(n), .bits(32)) clk_counter (.clk(clk_in), .en(en), .count_out(count));
    always @ (posedge clk_in) begin
        if (count == (n-1))
            clk_out <= ~clk_out;
    end
    
endmodule