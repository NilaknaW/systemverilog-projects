module p2s_tb;
	timeunit 1ns; timeprecision 1ps;
	
	logic clk = 1, rstn = 0;
	localparam CLK_PERIOD = 10;
	always #(CLK_PERIOD/2) clk <= ~clk;
	
	parameter N=4;
	logic [N-1:0] pdata;
	logic pvalid = 0, pready, sready=0, sdata, svalid;
	
	p2s #(.N(N)) dut(.*);
	
	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		
		@(posedge clk); #1 rstn <= 0; // reset (active low)
		@(posedge clk); #1 rstn <= 1; // remove reset
		#(CLK_PERIOD)
		
		// test 1 - pdata when not pvalid. register should not update. 
		@(posedge clk) #1 pdata <= 4'd12 ; pvalid <= 0; 
		@(posedge clk) #1 sready <= 1;  #(CLK_PERIOD *3)
		
		// test 2 - pdata given when pvalid. register should update.
		@(posedge clk) #1 pdata <= 4'd9 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
		
		// test 3 - pdata given when pvalid. register should update.
		@(posedge clk) #1 pdata <= 4'd1 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
		
		// test 4 - pdata given when pvalid. register updates. serial not ready, sdata should not update.
		@(posedge clk) #1 pdata <= 4'd1 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=0; #(CLK_PERIOD *10)
		
		// test 5 - Multiple sequential pdata inputs
		@(posedge clk) #1 pdata <= 8'd15; pvalid <= 1;
		@(posedge clk) #1 pdata <= 8'd7;  pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <= 1; #(CLK_PERIOD * 10)

		// test 6 - pdata update during serial transmission
		@(posedge clk) #1 pdata <= 8'd10; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <= 1;
		@(posedge clk) #1 pdata <= 8'd2; pvalid <= 1; #(CLK_PERIOD * 10)

		// test 7 - No ready signal from serial side
		@(posedge clk) #1 pdata <= 8'd3; pvalid <= 1; sready <= 0;
		@(posedge clk) #1 pvalid <= 0; #(CLK_PERIOD * 10)

		// test 8 - Rapid toggle of pvalid signal
		@(posedge clk) #1 pdata <= 8'd14; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <= 1;
		@(posedge clk) #1 pvalid <= 1; #(CLK_PERIOD * 14)

		// test 9 - Reset during active transmission
		@(posedge clk) #1 pdata <= 8'd5; pvalid <= 1;
		@(posedge clk) #1 rstn <= 0; pvalid <= 0;
		@(posedge clk) #1 rstn <= 1; #(CLK_PERIOD * 10)

		// test 10 - Idle periods between parallel data
		@(posedge clk) #1 pdata <= 8'd11; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <= 1; #(CLK_PERIOD * 5)
		@(posedge clk) #1 pdata <= 8'd4; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; #(CLK_PERIOD * 10)
		
		@(posedge clk)
		$finish();		
	end
endmodule
	