module four_bit_multiplier_tb;
	timeunit 1ns; timeprecision 100ps;
	
	logic unsigned [3:0]A,B;
	logic unsigned [7:0]product;
	
	four_bit_unsigned_multiplier dut(.*);
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0,dut); #5;
		
		// 10 different test cases to test the multiplier module.
		A<=4'd0 ; B<=4'd0 ; #10; // 0000 0000 minimum values
		A<=4'd15; B<=4'd15; #10; // 1110 0001 maximum values
		
		A<=4'd0 ; B<=4'd15; #10; // 0000 0000 multiply by zero A=0 ZERO 
		A<=4'd15; B<=4'd0 ; #10; // 0000 0000 multiply by zero B=0 ZERO
				
		A<=4'd1 ; B<=4'd10; #10; // 0000 1010 multiply by one A=1 IDNETITY
		A<=4'd15; B<=4'd1 ; #10; // 0000 1111 multiply by one B=1 IDNETITY
		
		A<=4'd3 ; B<=4'd4 ; #10; // 0000 1100 general values
		A<=4'd12; B<=4'd6 ; #10; // 0100 1000 general values
		
		A<=4'd12; B<=4'd11; #10; // 1000 0100 general values with carry out
		A<=4'd14; B<=4'd12; #10; // 1010 1000 general values with carry out
		$finish();
	end
	
endmodule