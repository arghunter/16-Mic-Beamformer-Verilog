// `include "cic.v"
// `include "adder5bit16way.v"
// `include "i2s_bus.v"
// `include "multi_ddr_to_sdr.v"
module top_module(
    input wire clk,
    input wire dec_clk,
    input wire rst,
    input wire [15:0] in,
    output wire out,
    output wire cic_outr

);

wire [4:0] adder_out;
wire [7:0] sdr_data_0;
wire [7:0] sdr_data_1;
wire [15:0] mic_data;
wire [23:0] cic_out;
assign mic_data[0] = sdr_data_0[0];
assign mic_data[1] = sdr_data_1[0];
assign mic_data[2] = sdr_data_0[1];
assign mic_data[3] = sdr_data_1[1];
assign mic_data[4] = sdr_data_0[2];
assign mic_data[5] = sdr_data_1[2];
assign mic_data[6] = sdr_data_0[3];
assign mic_data[7] = sdr_data_1[3];
assign mic_data[8] = sdr_data_0[4];
assign mic_data[9] = sdr_data_1[4];
assign mic_data[10] = sdr_data_0[5];
assign mic_data[11] = sdr_data_1[5];
assign mic_data[12] = sdr_data_0[6];
assign mic_data[13] = sdr_data_1[6];
assign mic_data[14] = sdr_data_0[7];
assign mic_data[15] = sdr_data_1[7];
assign cic_outr = cic_out;
    generate 
    multi_ddr_to_sdr u_multi_ddr_to_sdr(
        .clk(clk),
        .rst(rst),
        .ddr_data(in),
        .sdr_data_0(sdr_data_0),
        .sdr_data_1(sdr_data_1)

    );
    adder5bit16way u_adder5bit16way(
        .in(mic_data),
        .out(adder_out)
    );
    cic u_cic(
        .clk(clk),
        .dec_clk(dec_clk),
        .rst(rst),
        .in(adder_out),
        .out(cic_out)
    );
    i2s_bus u_i2s_bus(
        .clk(clk),
        .rst(rst),
        .lr_clk(dec_clk),
        .bit_data(cic_out),
        .out(out)
    );
    endgenerate
endmodule