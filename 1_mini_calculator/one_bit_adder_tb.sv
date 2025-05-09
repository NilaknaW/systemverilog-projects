module one_bit_adder_tb;
	timeunit 1ns; timeprecision 100ps;
	logic A=0,B=0,Ci=0, Sum, Cout;
	
	one_bit_adder dut(.A(A), .B(B), .Ci(Ci), .Sum(Sum), .Cout(Cout));
	
	initial begin 
		$dumpfile("dump.vcd"); $dumpvars(0,dut);
		#20 A <= 0; B <= 0; Ci <= 0;
		#10 A <= 1; B <= 1; Ci <= 1; // to indicate start for testing.
		
		#10 A <= 0; B <= 0; Ci <= 0; // go through all combinations of A, B, Ci and view waveforms
		#10 A <= 0; B <= 0; Ci <= 1;
		#10 A <= 0; B <= 1; Ci <= 0;
		#10 A <= 0; B <= 1; Ci <= 1;
		#10 A <= 1; B <= 0; Ci <= 0;
		#10 A <= 1; B <= 0; Ci <= 1;
		#10 A <= 1; B <= 1; Ci <= 0;
		#10 A <= 1; B <= 1; Ci <= 1;
		#10;
		$finish();
	end
endmodule