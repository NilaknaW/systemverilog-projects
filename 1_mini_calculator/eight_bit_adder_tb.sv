module eight_bit_adder_tb;
	timeunit 1ns;
	timeprecision 100ps;
	
	logic unsigned [7:0]A,B,Sum;
	logic Ci, Cout;
	
	eight_bit_adder dut(.*);
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0,dut);
		
		// run 10 test cases including cases with carry outs.	all unsigned values.
		#1  A <= 8'd0; 	B <= 8'd0; 		Ci <=0;			// 0 0000 0000 minimum input values
		#10 A <= 8'd0; 	B <= 8'd0; 		Ci <=1;			// 0 0000 0001 carry in input
		
		#10 A <= 8'd0; 	B <= 8'd8; 		Ci <=0;			// 0 0000 1000 one operand is minium (0)
		#10 A <= 8'd255; 	B <= 8'd8;	 	Ci <=0;			// 1 0000 0111 one operand is maximum (255)
		
		#10 A <= 8'd170; 	B <= 8'd85; 	Ci <=0;			// 0 1111 1111 alternating bits
		#10 A <= 8'd170; 	B <= 8'd170; 	Ci <=1;			// 1 0101 0101 alternating bits with carry in
		
		#10 A <= 8'd112; 	B <= 8'd25; 	Ci <=0;			// 0 1000 1001 average values without carry out
		#10 A <= 8'd115; 	B <= 8'd215; 	Ci <=0;			// 1 0100 1010 average values with carry out
		
		#10 A <= 8'd255;  B <= 8'd255;   Ci <=0;			// 1 1111 1110 max input values without carry in
		#10 A <= 8'd255;  B <= 8'd255;   Ci <=1;			// 1 1111 1111 max input values with carry in
		
   	// #1 assert ({Cout, Sum} == A + B + Ci) $display("%d+%d+%d != {%d,%d}", A, B, Ci, Cout, Sum);
		// 	else $error("%d+%d+%d != {%d,%d}", A, B, Ci, Cout, Sum);
	end
endmodule
	