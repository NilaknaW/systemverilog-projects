module fsmml (
	input logic clk, rstn, ser_valid, ser_data, 
	output logic unlock_valid, unlock, incorrect
);

typedef enum logic [1:0] {I=2'b00, A=2'b01, B=2'b10, C=2'b11} state_t; 	// define enum type state_t with logic as data type.
state_t next_state, state;	// declare state variables

localparam N = 4;
logic [1:0] bit_count = 0;

// next state decoder
always_comb unique 
	case (state)
	I: begin
		if (!ser_valid || !ser_data) next_state = I;
		else next_state = A;
		end
	
	A: begin
		if (!ser_valid) next_state = A;
		else if (!ser_data) next_state = B;
		else next_state = I;
		end
	
	B: begin
		if (!ser_valid) next_state = B;
		else if (!ser_data) next_state = I;
		else next_state = C;
		end
	
	C: begin
		if (!ser_valid) next_state = C;
		else next_state = I;
		end
		
	default: begin
		next_state = I;
		end
endcase

// state sequencer
always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		state <= I;
		// input_reg <= 4'b0000;
		bit_count <= 0;
		end
	else begin
		state <= next_state;
		
		if (next_state==I) begin
			bit_count <= 0;
			end
		
		if (ser_valid) begin
			bit_count <= bit_count + 1;
			end
		end
end

// output decoder
//always_comb begin
//	unlock = 0;
//	
//	unique case (state)	
//	I: begin
//		unlock_valid = ser_valid && !ser_data;
//		end
//		
//	A: unlock_valid = ser_valid && ser_data;
//	
//	B: unlock_valid = ser_valid && !ser_data;
//	
//	C: begin
//		unlock_valid = ser_valid;
//		unlock = ser_valid && ser_data;
//		end
//	endcase
//	
//	incorrect = ser_valid && (bit_count == N-1) && !unlock;
//	// incorrect = ser_valid && (input_reg != password) && (bit_count == N);	
//end
// this combinational output decoder resulted in gliteches in unlock_valid signal. so we do flipflop ones to sync.

always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		unlock_valid = 0;
		unlock =0;
	end
	else begin
		unlock = 0;
		unique case (state)	
		I: unlock_valid = ser_valid && !ser_data;	
		A: unlock_valid = ser_valid && ser_data;
		B: unlock_valid = ser_valid && !ser_data;
		C: begin
			unlock_valid = ser_valid;
			unlock = ser_valid && ser_data;
			end
		endcase
		incorrect = (bit_count == N-1) && !unlock;
	end
end

	
endmodule	
	
	
	
