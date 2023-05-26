`timescale 1ns/1ns

module push_button(input clk, rst, SIG, output SIG_out);
    wire debouncer_out, sync_out;
    debouncer debouncer(.clk(clk), .in(SIG), .out(debouncer_out));
    synchronizer sync(.clk(clk), .SIG(debouncer_out), .SIG_1(sync_out));
    rising_detector rd(.clk(clk), .x(sync_out), .z(SIG_out));
    
endmodule