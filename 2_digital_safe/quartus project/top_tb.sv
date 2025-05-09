module top_tb;
	timeunit 1ns; timeprecision 1ps;
	
	logic clk = 1, rstn = 0;
	localparam CLK_PERIOD = 10;
	always #(CLK_PERIOD/2) clk <= ~clk;
	
	parameter N=4;
	logic [N-1:0] pdata;
	logic pvalid = 0, pready, sready=0, sdata, svalid;
	logic unlock_valid, unlock, incorrect;
	
	top #(.N(N)) dut(
		.clk(clk),
      .rstn(rstn),
		.pdata(pdata),
      .pvalid(pvalid),
      .pready(pready),
		.sready(sready),
      .sdata(sdata),
      .svalid(svalid),
      .unlock_valid(unlock_valid),
      .unlock(unlock),
      .incorrect(incorrect)
	);
	
	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		
		@(posedge clk); #1 rstn <= 0; // reset (active low)
		@(posedge clk); #1 rstn <= 1; // remove reset
		#(CLK_PERIOD)
		
		// test 1
		@(posedge clk) #1 pdata <= 4'd11 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
		
		// test 2
		@(posedge clk) #1 pdata <= 4'd12 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
		
		// test 3
		@(posedge clk) #1 pdata <= 4'd11 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
		
		// test 4
		@(posedge clk) #1 pdata <= 3'd3 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
		
		// test 5
		@(posedge clk) #1 pdata <= 4'd8 ; pvalid <= 1;
		@(posedge clk) #1 pvalid <= 0; sready <=1; #(CLK_PERIOD *10)
	
		@(posedge clk)
		$finish();		
	end
endmodule