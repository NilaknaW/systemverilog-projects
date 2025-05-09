`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: N D Warushavithana 
// 
// Create Date: 04/28/2025 08:07:07 AM
// Design Name: Stopwatch
// Module Name: stopwatch
// Project Name: Assignment 4 SVADS 25
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 1
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module stopwatch(
    input logic stop, start, clear, incr, clk, rstn,
    output logic [3:0] AN, [6:0] Disp [3:0]
    );
    
logic [16:0]ticks; // generate/count 1ms from 100M clock. 17 digits
logic millis; // millisecond count
logic ms_tick; // mark 1ms
logic [13:0]tot_count; // count from 0- 9999 ms. 14 digits
logic [3:0] digit[3:0]; // tot_count to digits

typedef enum logic [1:0] {Idle=2'b00, Reset=2'b01, Run=2'b10} state_t; 	// define enum type state_t with logic as data type.
state_t next_state, state;	// declare state variables

// next state decoder
always_comb begin
    unique case (state)
    Idle: begin
        if (clear) next_state = Reset;
        else if (start) next_state = Run;
        else next_state = Idle;
    end
        
    Reset:begin
        if (start) next_state = Run;
        else next_state = Reset;
    end
    
    Run:begin
        if (clear) next_state = Reset;
        else if (stop) next_state = Idle;
        else next_state = Run;
    end
        
    default: next_state = Reset;
    
    endcase
end 

// state sequencer
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) state <= Reset;
    else state <= next_state;
end

// generate 1ms tick
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        ticks <= 0;
        ms_tick <= 0;
        millis <= 0;
    end
    else begin 
        if (ticks == 99999) begin // 100,000 clk ticks = 1 ms.
            ms_tick <= 1; // flag 1 ms
            ticks <= 0; // reset millis tick counter
        end
        else begin
            ms_tick <= 0; // increment millis count by 1 ms
            ticks <= ticks + 1; // at each clk signal (100MHz) increment the ticks count by one.
        end
    end
end

// output logic/ state logic - hhandle tot_count, incr, and state logic
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        tot_count <= 0;
    end
    else begin
        unique case (state)
            Idle: tot_count <= tot_count;
            Reset: tot_count <= 0;
            Run: begin
                if (incr || ms_tick) begin // increment counter by input
                    if (tot_count == 9999) tot_count <= 0;
                    else tot_count <= tot_count +1;
                end
            end
        endcase
    end
end

// seven seg decoder

// assign the tot_count to four digits in decimal (4 bits needed)
assign digit[0] = tot_count % 10;
assign digit[1] = (tot_count / 10) % 10;
assign digit[2] = (tot_count / 100) % 10;
assign digit[3] = (tot_count / 1000) % 10;

// because PNP, active low.
always_comb begin
    if (digit[3]!=0) AN = 4'b0000;
    else if (digit[2]!=0) AN = 4'b1000;
    else if (digit[1]!=0) AN = 4'b1100;
    else AN = 4'b1110;
end

// display output logic
seven_segment_decoder seg_dec0(.num(digit[0]), .seg(Disp[0])); 
seven_segment_decoder seg_dec1(.num(digit[1]), .seg(Disp[1])); 
seven_segment_decoder seg_dec2(.num(digit[2]), .seg(Disp[2])); 
seven_segment_decoder seg_dec3(.num(digit[3]), .seg(Disp[3]));
    
endmodule
