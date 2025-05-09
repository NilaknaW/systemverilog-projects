module seven_segment_decoder_tb();
	timeunit 1ns; timeprecision 100ps;
	
	logic [3:0]num;
	logic [6:0]seg;
	
	seven_segment_decoder dut(.*);
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0,dut); #1;
		
		for(int i=0; i<10; i=i+1) begin: seg_display
			num = i; 
			#10;
		end
		
		$finish();
	end

endmodule
