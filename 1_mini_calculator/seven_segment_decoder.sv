module seven_segment_decoder(
	input logic [3:0]num,
	output logic [6:0]seg // output in order of gfedcba
);

   always_comb begin
	   case(num)
		4'd0: seg = 7'b0111111;
		4'd1: seg = 7'b0000110;
		4'd2: seg = 7'b1011011;
		4'd3: seg = 7'b1001111;
		4'd4: seg = 7'b1100110;
		4'd5: seg = 7'b1101101;
		4'd6: seg = 7'b1111101;
		4'd7: seg = 7'b0000111;
		4'd8: seg = 7'b1111111;
		4'd9: seg = 7'b1101111;
		default: seg = 7'b1000000;
	   endcase
   end
endmodule