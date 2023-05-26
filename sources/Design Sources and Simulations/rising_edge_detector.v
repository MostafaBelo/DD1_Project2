`timescale 1ns/1ns

module rising_detector(input clk, x, output z);
    initial begin
        state = A;
    end
    
    localparam A = 2'b00, B = 2'b01, C = 2'b10;
    reg [1:0] state, next_state;

    always @(*) begin 
        case(state)
            A: begin
                if(x == 1'b0) next_state = B;
                else next_state = A;
            end
            B: begin
                if(x == 1'b0) next_state = B;
                else next_state = C;
            end
            C: begin
                if(x == 1'b0) next_state = B;
                else next_state = A;
            end
            default: next_state = A;
        endcase
    end

    always @(posedge clk) begin
        state <= next_state; 
    end

    assign z = (state == C && x == 1'b1);
    
endmodule