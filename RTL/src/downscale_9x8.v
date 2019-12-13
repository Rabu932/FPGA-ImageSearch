module downscale_9x8 #(
	PIX_WIDHT = 8,
	TARGET_X = 9,
	TARGET_Y = 8,
	ALPHA_SHIFT = 8,
	ADDR_WIDTH
)(
	input clk, rst,
	input [PIX_WIDTH - 1 : 0] pix,						// Input pixel value
	input [ALPHA_SHIFT - 1 : 0] alpha_recp_shift,		// Recprocal of downscaling factor scaled
	input [15 : 0] x_p,									// X coordinate of input pixel
	input [15 : 0] y_p,									// Y coordinate of input pixel
	input [PIX_WIDTH - 1 : 0] data_in,					// Data in from BRAM
	
	output [PIX_WIDTH - 1 : 0] data_out,				// Data out to BRAM
	output [ADDR_WIDTH - 1 : 0] addr,					// Address to BRAM
	output wen,											// Write enable of BRAM
	output pix_done,									// Signals that the pixel is done being processed
	output [ADDR_WIDTH - 1 : 0] addr_done				// Address of the pixel that is done processing 
);

	reg [PIX_WIDTH - 1 : 0] pix_buff_0;
	reg [PIX_WIDTH - 1 : 0] pix_buff_1;
	reg [PIX_WIDTH - 1 : 0] pix_buff_2;
	reg [PIX_WIDTH - 1 : 0] pix_buff_3;
	
	reg [PIX_WIDTH - 1 : 0] pix_buff_0_next;
	reg [PIX_WIDTH - 1 : 0] pix_buff_1_next;
	reg [PIX_WIDTH - 1 : 0] pix_buff_2_next;
	reg [PIX_WIDTH - 1 : 0] pix_buff_3_next;
	
	reg [15 : 0] u_buff;
	reg [15 : 0] v_buff;


	wire [15 : 0] u, v;


	assign u = (x_p * alpha_recp_shift) >> ALPHA_SHIFT;  
	assign v = (y_p * alpha_recp_shift) >> ALPHA_SHIFT;  


	always @(*) begin
		if (rst) begin
			
		end
		else begin
			if (u != u_buff || v != v_buff) begin
				
			end
		end

	end


endmodule
