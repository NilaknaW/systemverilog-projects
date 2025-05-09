module eight_bit_adder (
	input logic unsigned [7:0] A, B,
	input logic Ci,
	output logic unsigned [7:0] Sum,
	output logic Cout
);

logic C[8:0];								// define ripple carries
assign C[0] = Ci;							// assign input to the specific wire
assign Cout = C[8];						// define the carry out with C wire

genvar i;
generate
for (i=0; i<8; i=i+1) begin: add
	one_bit_adder fa(.A(A[i]), .B(B[i]), .Ci(C[i]), .Sum(Sum[i]), .Cout(C[i+1]));
	end 
endgenerate
endmodule