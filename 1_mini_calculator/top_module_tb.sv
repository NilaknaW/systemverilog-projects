module top_module_tb ();
	timeunit 1ns; timeprecision 100ps;
	
	logic unsigned [3:0]A,B;
	logic [6:0]D1, D0;
	
	top_module dut(.A(A), .B(B), .D0(D0), .D1(D1));
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0,dut); #5;
		
		A<=4'd0 ; B<=4'd0 ; #10; // 0 minimum values
		A<=4'd15; B<=4'd15; #10; // 225 maximum values
		
		A<=4'd0 ; B<=4'd15; #10; // 0 multiply by zero A=0 ZERO 
		A<=4'd15; B<=4'd0 ; #10; // 0 multiply by zero B=0 ZERO
				
		A<=4'd1 ; B<=4'd10; #10; // 10 multiply by one A=1 IDNETITY
		A<=4'd15; B<=4'd1 ; #10; // 15 multiply by one B=1 IDNETITY
		
		A<=4'd3 ; B<=4'd4 ; #10; // 12 general values
		A<=4'd12; B<=4'd6 ; #10; // 72 general values
		
		A<=4'd12; B<=4'd11; #10; // 132 will display 32 (carry out)
		A<=4'd14; B<=4'd12; #10; // 168 will display 68 (carry out)
		$finish();
	end
endmodule
