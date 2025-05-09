module top_module (
	input logic unsigned [3:0]A, B, // 4-bit unsigned input numbers A and B
	output logic[6:0]D0, D1		// 7-bit signals D0 and D1 to displays
);

logic unsigned [7:0]product;
logic [3:0]num0, num1;

four_bit_unsigned_multiplier AB_mul (.A(A), .B(B), .product(product)); // find the product using 4-bit unsigned adder

always_comb begin
	num1 = (product%100)/10; 	// get tens place value
	num0 = product%10;			// get ones place value
end

seven_segment_decoder Disp1 (.num(num1), .seg(D1)); // display tens value in disp1
seven_segment_decoder Disp0 (.num(num0), .seg(D0)); // display ones value in disp2

endmodule
