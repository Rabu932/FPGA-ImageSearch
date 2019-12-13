module top_dhash # (
	COUNT_WIDTH = 4, 
	ROW_LIM = 9, 
	COL_LIM = 8,
	OUT_WIDTH = (ROW_LIM - 1) * COL_LIM,
	PIX_WIDTH = 8)
	(
	input clk, rst,
	input [PIX_WIDTH - 1 : 0] pix,
	output [OUT_WIDTH - 1 : 0] hash_out,
	output hash_vld
	);

	wire [COUNT_WIDTH - 1 : 0] row;	
	wire [COUNT_WIDTH - 2 : 0] col;
	
	
	dhash dhash_0 (.clk(clk), .rst(rst), .pix(pix), .row(row), .col(col), .vld(hash_vld), .out(hash_out));
	
	coord_gen coord_gen_0 (.clk(clk), .rst(rst), .row(row), .col(col));


endmodule
