// `include "incrementor.v"
// `include "integrator.v"
// // `include "differentiator.v"
// `include "op_differentiator.v"

module cic (
    input wire clk,
    input wire dec_clk,
    input wire rst,
    input wire in,
    output [18:0] out 
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
		op_differentiator u_differentiator(
			.clk(clk),
			.rst(rst),
			.lr_clk(dec_clk),
			.in(int_2_out),
			.out(out)
		);
    endgenerate

endmodule
