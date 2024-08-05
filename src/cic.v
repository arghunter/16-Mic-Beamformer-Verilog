module cic(
    input wire clk,
    input wire dec_clk,
    input wire rst,
    input wire in,
    input reg [18:0] out 
);

    wire [18:0] inc_out;
    wire [18:0] int_1_out;
    wire [18:0] int_2_out;
    generate 
        incrementor u_incrementor(
    	    .clk(clk),
	    .rst(rst),
	    .in(in),
	    .out(inc_out)
        );
	integrator u_integrator_1(
	    .clk(clk),
	    .rst(rst),
	    .in(inc_out),
	    .out(int_1_out)
	);
	integrator u_integrator_2(
	    .clk(clk),
	    .rst(rst),
	    .in(int_1_out),
	    .out(int_2_out)
	);
        differentiator u_differentiator_1(
	    .clk(dec_clk),
	    .rst(rst),
	    .in(int_2_out),
	    .out(diff_1_out)
	);
        differentiator u_differentiator_2(
	    .clk(dec_clk),
	    .rst(rst),
	    .in(diff_1_out),
	    .out(diff_2_out)
	);
        differentiator u_differentiator_1(
	    .clk(dec_clk),
	    .rst(rst),
	    .in(diff_2_out),
	    .out(out)
	);
    endgenerate

