module integrator(
    input wire clk,
    input wire rst,
    input wire [18:0] in,
    output reg [18:0] out
);
    reg [18:0] data;


    always @(posedge clk or posedge rst) begin
    	if (rst) begin
	    data<=0;
	    out<=0;
        end else begin
	    out<=data+in;
	    data<=data+in;
	end


    end
endmodule

