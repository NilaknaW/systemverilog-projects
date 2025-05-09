module fsm_moore (
	input logic clk, rstn, ser_valid, ser_data, 
	output logic unlock_valid, unlock, incorrect
);

typedef enum logic [2:0] {I=3'd0, A=3'd1, B=3'd2, C=3'd3, D=3'd4, W=3'd5} state_t; 	// define enum type state_t with logic as data type.
state_t next_state, state;	// declare state variables

localparam N = 4;

// next state decoder
always_comb unique 
	case (state)
	I: begin
		if (!ser_valid) next_state = I;
		else if (ser_data) next_state = A;
		else next_state = W;
		end
	
	A: begin
		if (!ser_valid) next_state = A;
		else if (!ser_data) next_state = B;
		else next_state = W;
		end
	
	B: begin
		if (!ser_valid) next_state = B;
		else if (ser_data) next_state = C;
		else next_state = W;
		end
	
	C: begin
		if (!ser_valid) next_state = C;
		else if (ser_data) next_state = D;
		else next_state = W;
		end
	
	D: begin
		if (!ser_valid) next_state = I;
		else next_state = D;
		end
	W: next_state = I;
		
	default: begin
		next_state = I;
		end
endcase

// state sequencer
always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) state <= I;
	else state <= next_state;
end

// output decoder
always_ff @(posedge clk or negedge rstn) begin
	if (!rstn) begin
		unlock_valid <= 1'b0;
		unlock <= 1'b0;
		incorrect <= 1'b0;
	end
	else begin
		unlock_valid <= (state==D);
		unlock <= (state==D);
		incorrect <= (state==W);
	end
end

endmodule	
	
	
	
