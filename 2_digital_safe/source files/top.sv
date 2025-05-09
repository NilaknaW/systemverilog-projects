module top #(N=4)(
	input logic pvalid, sready, clk, rstn, // inputs to p2s module
	input logic [N-1:0]pdata,
	output logic pready, svalid, sdata,
	output logic unlock_valid, unlock, incorrect //outputs of fsmml module
);


// p2s instance
p2s #(.N(N)) myp2s (
	.clk(clk),
	.rstn(rstn),
	.pvalid(pvalid),
	.sready(sready),
	.pdata(pdata),
	.pready(pready),
	.svalid(svalid),
	.sdata(sdata)
);

// fsmml instance
fsmml myfsmml (
	.clk(clk), 
	.rstn(rstn), 
	.ser_valid(svalid), 
	.ser_data(sdata), 
	.unlock_valid(unlock_valid), 
	.unlock(unlock), 
	.incorrect(incorrect)
);
	
	
endmodule
	
	
	
	