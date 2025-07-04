module p2s #(N=4) (
	input logic pvalid, sready, clk, rstn,
	input logic [N-1:0]pdata,
	output logic pready, svalid, sdata
);

localparam NBITS = $clog2(N);
logic [NBITS-1:0]count;
logic [N-1:0]register;

typedef enum logic {RX=1'b0, TX=1'b1} state_t; 	// define enum type state_t with logic as data type.
state_t nextState, state;								// declare state variables

// next state decoder
always_comb unique case(state)
	RX: nextState = (pvalid) 					? TX: RX;
	TX: nextState = (count==N-1 && sready) ? RX: TX;
endcase

// state sequencer
always_ff @(posedge clk or negedge rstn)
	state <= (!rstn) ? RX: nextState;			// if reset(active low) then make state to RX

// output decoder
assign sdata = register[N-1]; 						// assign output value
assign pready = (state==RX);
assign svalid = (state==TX);

always_ff @(posedge clk or negedge rstn)
	if (!rstn) count<= '0;
	else unique case (state)
	RX: begin
		register <= pdata;
		count <= '0;
		end
	
	TX: begin
		// here we havent checked if sready or not
		register <= (register << 1); 				// shift the register.
		count <= count + 1'd1;							// increment the counter.
		end
	endcase
	
endmodule	
	
	
	
