module four_bit_unsigned_multiplier (
	input logic unsigned [3:0]A,B,
	output logic unsigned [7:0]product
);

logic [7:0] Mul [3:0]; 						// array of four elements of 8-bit numbers
logic [7:0] Sum [3:0];						// three elements for adding each multiplys.
logic C[3:0];									// carrys of 8 bit adders
logic [15:0]m;									// partial products need to calculate the multiply value

assign Sum[0] = Mul[0];						// carry outs of each adder.
assign C[0] = 0;								// no carry in.
assign product = Sum[3];					// product assignment

// calculate partial products and store in m. ai*bj products.
genvar j;
generate
for (j=0;j<4; j=j+1) begin : gen_muls
	assign m[4*j+0] = A[0] & B[j];
	assign m[4*j+1] = A[1] & B[j];
	assign m[4*j+2] = A[2] & B[j];
	assign m[4*j+3] = A[3] & B[j];
	end
endgenerate
// can do the above with shift registers too.

// use partial products to make 8 bit numbers for each multiplied step.
assign Mul[0] = {1'b0	, 1'b0    , 1'b0   , 1'b0  , m[3:0]};
assign Mul[1] = {1'b0	, 1'b0	 , 1'b0   , m[7:4], 1'b0  };
assign Mul[2] = {1'b0	, 1'b0	 , m[11:8], 1'b0	, 1'b0  };
assign Mul[3] = {1'b0	, m[15:12], 1'b0   , 1'b0  , 1'b0  };

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

endmodule






























