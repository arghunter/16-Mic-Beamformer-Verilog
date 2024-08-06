module incrementor (
	input wire clk,
	input wire in,
	input wire rst,
	output reg [18:0] out
);

	reg [18:0] data;
	

	always @(posedge clk or posedge rst) begin
		if(rst) begin 
			data<=0;
			out<=0;	
		end else if (in) begin
			out<=data+1;
			data<=data+1;
		end else begin 
			out<=data-1;
			data<=data-1;
		end
	end
endmodule
