module four_bit_signed_multiplier (
	input logic signed [3:0]A,B,
	output logic signed [7:0]product
);

logic [7:0] Mul [3:0]; 						// array of four elements of 8-bit numbers
logic [7:0] Sum [3:0];						// three elements for adding each multiplys.
logic C[3:0];									// carrys of 8 bit adders

logic a;

assign Mul[0] = (B[0]==1)? {{4{A[3] ^ B[3]}},A}     : 8'b0;
assign Mul[1] = (B[1]==1)? {{3{A[3] ^ B[3]}},A,1'b0}: 8'b0;
assign Mul[2] = (B[2]==1)? {{2{A[3] ^ B[3]}},A,2'b0}: 8'b0;
assign Mul[3] = (B[3]==1)? {{1{A[3] ^ B[3]}},A,3'b0}: 8'b0;

assign Sum[0] = Mul[0];						// carry outs of each adder.
assign C[0] = 1'b0;								// no carry in.

// add all M[i]s using 8-bit adders.
genvar i;
generate
for (i=0; i<3; i=i+1) begin: add 
	eight_bit_adder eightadder(
		.A   (Sum[i]  ),
		.B   (Mul[i+1]),
		.Ci  (C[i]    ),
		.Sum (Sum[i+1]),
		.Cout(C[i+1]  )
	);
	end
endgenerate

assign product = Sum[3];					// product assignment

endmodule































