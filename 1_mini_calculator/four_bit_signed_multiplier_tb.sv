module four_bit_signed_multiplier_tb;
	timeunit 1ns; timeprecision 100ps;
	
//	logic unsigned [3:0]A,B;
//	logic unsigned [7:0]product;
	
//	four_bit_unsigned_multiplier dut(.*);

	logic signed [3:0]A,B;
	logic signed [7:0]product;
	
	four_bit_signed_multiplier dut(.*);
	
	initial begin
		$monitor("A =%d * B =%d, Product =%b, A^B = %b, Mul[0] = %b, Mul[1] = %b, Mul[2] = %b, Mul[3] = %b",A,B,dut.Sum[3], A[3]^B[3], dut.Mul[0], dut.Mul[1], dut.Mul[2], dut.Mul[3]);
		$dumpfile("dump.vcd"); $dumpvars(0,dut); #5;

		// 10 different test cases to test the multiplier module. (-8 to +7)
		A<=4'd0 ; B<=4'd0 ; #10; // 00000000 zero * zero
		A<=-4'd2; B<=4'd0 ; #10; // 00000000 negative * zero
		
		A<=4'd2 ; B<=4'd3 ; #10; // 00000110 positive * positive < 7
		A<=4'd2 ; B<=-4'd3; #10; // 11111010 positive * negative < 7
			
		A<=-4'd2; B<=4'd3 ; #10; //  negative * positive
		A<=-4'd2; B<=-4'd3; #10; //  negative * negative
		
		A<= 4'd7; B<= 4'd7; #10; //  +max * +max 
		A<=-4'd7; B<=-4'd7; #10; //  -max * -max
		
		A<=-4'd7; B<= 4'd7; #10; //  
		A<= 4'd7; B<=-4'd7; #10; // 
	end
	
endmodule





























