`timescale 1ns/1ns

module Binary_to_BCD (input [15:0] bin, output reg[19:0] bcd); // bcd {...,thousands,hundreds,tens,ones}
  integer i;
  always @(*) begin
    bcd=20'b0;
    for (i=15;i>=0;i=i-1) begin //Iterate once for each bit in input number
      if (bcd[3:0] >= 4'b0101) bcd[3:0] = bcd[3:0] + 4'b0011; //If any BCD digit is >= 5, add three
      if (bcd[7:4] >= 4'b0101) bcd[7:4] = bcd[7:4] + 4'b0011;
      if (bcd[11:8] >= 4'b0101) bcd[11:8] = bcd[11:8] + 4'b0011;
      if (bcd[15:12] >= 4'b0101) bcd[15:12] = bcd[15:12] + 4'b0011;
      if (bcd[19:16] >= 4'b0101) bcd[19:16] = bcd[19:16] + 4'b0011;
      bcd = {bcd[18:0],bin[i]}; //Shift one bit, and shift in proper bit from input
    end
  end
endmodule