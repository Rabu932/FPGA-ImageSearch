module dHash #(
	COUNT_WIDTH = 4, 
	ROW_LIM = 9, 
	COL_LIM = 8,
	OUT_WIDTH = (ROW_LIM - 1) * COL_LIM,
	PIX_WIDTH = 8) 
	(
	input clk, rst,
	input [PIX_WIDTH - 1 : 0] pix,
	input [COUNT_WIDTH - 1 : 0] row,	
	input [COUNT_WIDTH - 2 : 0] col,
	output reg vld,
	output reg [OUT_WIDTH - 1 : 0] out
	);
	
	reg [PIX_WIDTH - 1 : 0] pix_buff;
	reg [PIX_WIDTH - 1 : 0] pix_buff_next;
	reg temp;
	reg vld_next;
	reg [OUT_WIDTH - 1 : 0] out_next;

	
	always @ (posedge clk) begin
		out 		<= #1 out_next;
		vld 		<= #1 vld_next;
		pix_buff 	<= #1 pix_buff_next;
	end


	always @ (*) begin
		pix_buff_next 	= pix;
		out_next 	= out;
		if (rst) begin
			out_next 	= 0;
			pix_buff_next 	= 0;
		end
		else begin
			if (col != 0) begin
				temp 		= pix_buff > pix;
				out_next 	= out << 1 + temp;	
			end
		end
	end

	always @(*) begin
		vld 	= 0;
		if (rst) begin
			vld_next 	= 0;
		end
		else begin
			if (col == COL_LIM - 1 && row == ROW_LIM) begin
				vld_next 	= 1;
			end
		end
	end




endmodule
