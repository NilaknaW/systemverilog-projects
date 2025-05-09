module p2s #(N=4) (
	input logic par_valid, ser_ready, clk, rstn,
	input logic [N-1:0]par_data,
	output logic par_ready, ser_valid, ser_data
);

localparam N_BITS = $clog2(N);
typedef enum logic {RX=1'b0, TX=1'b1} state_t; // define enum type state_t with logic as data type.
state_t next_state, state; // declare state variables

logic [N_BITS -1:0]count;
logic [N-1:0]shift_reg;

// next state decoder
always_comb unique case (state)
	RX: next_state = (par_valid == 0) ? TX: RX; 
	TX: next_state = (count==N-1 && ser_ready) ? RX: TX;
	endcase

// state sequencer
always_ff @(posedge clk or negedge rstn)
		state <= !rstn ? RX: next_state; // rstn is active low. when rstn=0, reset to RX state. Otherwise, go to next state.

// output decoder
assign ser_data = shift_reg[0];
assign par_ready = (state==RX);
assign ser_valid = (state==TX);

always_ff @(posedge clk or negedge rstn)
	if (!rstn) count <= '0;
	else 
		unique case (state)
			RX: begin
				shift_reg <= par_data; // copy paralled data to the shift register
				count <= '0; // reset the count to zero
				end
			
			TX: begin
				shift_reg <= shift_reg >> 1; // sheft forward by one bit
				count <= count + 1; // increment the counter
				end
		endcase
		
endmodule
