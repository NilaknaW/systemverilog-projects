module fsm_moore_tb;
	timeunit 1ns; timeprecision 1ps;
	
	logic clk = 1, rstn = 0, ser_valid, ser_data, unlock_valid, unlock, incorrect;
	localparam CLK_PERIOD = 10, N=4;
	always #(CLK_PERIOD/2) clk <= ~clk;
	
	fsm_moore dut(.*);
	
	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		
		@(posedge clk); #1 rstn <= 0; // reset (active low)
		@(posedge clk); #1 rstn <= 1; // remove reset
		#(CLK_PERIOD)
		
		// test 1 - pdata when not pvalid. register should not update. 
		$display("Test 1: Invalid Input (Expect incorrect)");
		send_sequence(4'b0000);
		#(CLK_PERIOD*2);
		
		// test 2: Valid Input (1011) - Should Unlock
		$display("Test 2: Valid Input (Expect Unlock)");
		send_sequence(4'b1011);
		#(CLK_PERIOD*2);
		
		// test 3 - pdata when not pvalid. register should not update. 
		$display("Test 1: Invalid Input (Expect incorrect)");
		send_sequence(4'b1101);
		#(CLK_PERIOD*2);
		
		// test 4 - pdata when not pvalid. register should not update. 
		$display("Test 1: Invalid Input (Expect incorrect)");
		send_sequence(4'b0101);
		#(CLK_PERIOD*2);
		
		@(posedge clk)
		$finish();		
	end
	
	task send_sequence(input [N-1:0] seq);
		for (int i = N-1; i>=0; i--) begin
			@(posedge clk); #1 ser_valid =1; ser_data = seq[i];
		end
		@(posedge clk); #1 ser_valid = 0;
	endtask
	
endmodule
	