module one_bit_adder(
	input logic A, B, Ci,
	output logic Sum, Cout
);

wire [2:0]w;
assign w[0] = A ^ B;
assign w[1] = w[0] & Ci;
assign w[2] = A & B;
	
always_comb 
	begin
	Sum = w[0] ^ Ci ;
	Cout = w[1] | w[2];
	end

endmodule 