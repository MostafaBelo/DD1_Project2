`timescale 1ns/1ns

module mod_n_counter(clk, en, count_out);
  initial begin
    count_out = rstLoad;
  end

  parameter n = 16, bits = 4, rstLoad = 0;
  
  input clk, en;
  output reg[bits-1:0] count_out;
  
  always @(posedge clk) begin
   if(count_out == n-1)
      count_out <= 0;
    else count_out <= count_out + 1;
  end
  
endmodule