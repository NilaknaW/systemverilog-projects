`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2025 10:59:34 AM
// Design Name: 
// Module Name: stopwatch_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stopwatch_tb;

    timeunit 1ns/1ps;

    // inputs
    logic stop=0, start=0, clear=0, incr=0, clk=1, rstn=0;

    // outputs
    logic [3:0] AN;
    logic [6:0] Disp[3:0];
    
    // clk generation
    localparam CLK_PERD = 10; // 100MHz clock 
    always #(CLK_PERD/2) clk = ~clk;

    // create the stopwatchh module
    stopwatch dut(
        .stop(stop), 
        .start(start), 
        .clear(clear), 
        .incr(incr), 
        .clk(clk), 
        .rstn(rstn), 
        .AN(AN), 
        .Disp(Disp)    
    );
    
    // tests
    initial begin
        $dumpfile("dump.vcd"); 
		$dumpvars;
        // initial inputs
        @(posedge clk);
        rstn = 0; // reset enable
        stop = 0;
        start = 0;
        clear = 0;
        incr = 0;
        
        // wait for reset
        @(posedge clk); #10 rstn = 1; // release reset after 10 ns
        
        // test 1
        @(posedge clk); #10 clear = 1;
        @(posedge clk); #10 clear = 1;
        
        // test 2
        @(posedge clk); #10 start = 1;
        @(posedge clk); #10 incr = 1;
        @(posedge clk); #10 incr = 0;
        @(posedge clk); #10 start = 0;
//        @(posedge clk); #200000 start = 0;
        
        @(posedge clk); #10 stop = 1;
        
        // finish
        #100 $finish; 
    end
endmodule
