module coord_gen # ( 	
	COUNT_WIDTH = 4, 
	ROW_LIM = 9, 
	COL_LIM = 8,
	)
	(
	input clk, rst,
	output reg [COUNT_WIDTH - 1 : 0] row,	
	output reg [COUNT_WIDTH - 2 : 0] col,
	);
	
	reg [COUNT_WIDTH - 1 : 0] row_next;
	reg [COUNT_WIDTH - 1 : 0] col_next;


	always @ (posedge clk) begin
		col 	<= 	#1 col_next;
		row 	<= 	#1 row_next;
	end


	always @ (*) begin
		col_next = col + 1;
		row_next = row;
		if (rst) begin
			row_next 	= 0;
			col_next 	= 0;
		end
		else begin
			if (col == COL_LIM - 1) begin
				row_next 	= row + 1;
				col_next 	= 0;
			end
		end
	end


endmodule 
