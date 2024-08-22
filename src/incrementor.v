module incrementor (
	input wire clk,
	input wire in,
	input wire rst,
	output reg [23:0] out
);
	always @(posedge clk or posedge rst) begin
		if(rst) begin 
			out<=0;	
		end else if (in) begin
			out<=out+1;
		end else begin 
			out<=out-1;
		end
	end
endmodule
