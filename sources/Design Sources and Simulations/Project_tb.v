`timescale 1ns/1ns

module Project_tb();
    reg clk, btnStart, btnL, btnR;
    reg [7:0] InA, InB;
    wire IsDone;
    wire [3:0] enables;
    wire [6:0] segments;

    Project utd(clk, btnStart, btnL, btnR, InA, InB, IsDone, enables, segments);

    integer i;
    initial begin
        clk = 0;
        for (i = 0; i<3000; i=i+1) begin
            #20
            clk = ~clk;
        end
    end

    initial begin
        $dumpfile("Simulation/simuation.vcd");
        $dumpvars(0, Project_tb);
        
        btnStart = 0;
        btnL = 0;
        btnR = 0;
        InA = 0;
        InB = 0;

        repeat (2) @(posedge clk);
        InA = -5;
        InB = 3;

        repeat (5) @(posedge clk);
        btnStart = 1;
        
        repeat (10) @(posedge clk);
        btnStart = 0;

        repeat (3) @(posedge clk);
        btnL = 1;
        repeat (8) @(posedge clk);
        btnL = 0;

        repeat (7) @(posedge clk);
        btnL = 1;
        repeat (12) @(posedge clk);
        btnL = 0;

        repeat (8) @(posedge clk);
        btnR = 1;
        repeat (9) @(posedge clk);
        btnR = 0;

        repeat (9) @(posedge clk);
        btnR = 1;
        repeat (16) @(posedge clk);
        btnR = 0;

        @(posedge clk)
        InA = 117;
        InB = -2;

        repeat (5) @(posedge clk);
        btnStart = 1;

        repeat (20) @(posedge clk);
        btnStart = 0;
        InA = 127;
        InB = 127;

        repeat (15) @(posedge clk);
        btnStart = 1;
    end
endmodule