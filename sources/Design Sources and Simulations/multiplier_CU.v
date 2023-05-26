`timescale 1ns/1ns

module multiplier_CU (input clk, start, output reg [1:0] SA, SB, SC, output isDone, SNeg);
  initial begin
    presentState = idleState;
  end
  
  localparam [3:0] idleState=4'b1001, initState=4'b1010, endState=4'b1000;
  reg [3:0] presentState, nextState;

  always @(*) begin
    case (presentState)
      idleState: begin
        if (start) nextState = initState;
        else nextState = idleState;
      end
      endState: begin
        if (!start) nextState = idleState;
        else nextState = endState;
      end
      initState: nextState = 4'b0000; // bit 0
      
      // bits
      default: nextState = presentState+1;
    endcase
  end

  always @(posedge clk) begin
      presentState <= nextState;
  end
  
  assign isDone = (presentState == idleState) | (presentState == endState);
  assign SNeg = (presentState == initState);

  localparam  [1:0] SALoad = 2'b00, SASHR = 2'b01, SASHL = 2'b10, SAStore = 2'b11;
  localparam  [1:0] SBLoad = 2'b00, SBSHR = 2'b01, SBSHL = 2'b10, SBStore = 2'b11;
  localparam  [1:0] SCStore = 2'b00, SCacc = 2'b01, SCclr = 2'b10;

  always @(*) begin
    case (presentState)
      idleState: SA = SAStore;
      initState: SA = SALoad;
      endState: SA = SAStore;
      default: SA = SASHL; // bits
    endcase
  end

  always @(*) begin
    case (presentState)
      idleState: SB = SBStore;
      initState: SB = SBLoad;
      endState: SB = SBStore;
      default: SB = SBSHR; // bits
    endcase
  end

  always @(*) begin
    case (presentState)
      idleState: SC = SCStore;
      initState: SC = SCclr;
      endState: SC = SCStore;
      default: SC = SCacc; // bits
    endcase
  end
endmodule