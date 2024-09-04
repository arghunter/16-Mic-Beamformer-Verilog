/*
 * Copyright (c) 2024 Armaan Gomes
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none
// This porject was a collaboration between me(arghunter) and the other collaborators on this repository (Acknowledged in the ReadMe)
module tt_um_16_mic_beamformer_arghunter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
wire rst;
wire bit_clk;
wire lr_clk; 
wire [7:0] in;
wire out;
    
  // All output pins must be assigned. If not used, assign to 0.
  // assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;
  assign bit_clk = uio_in[0];
  assign lr_clk = uio_in[1]; 
  assign rst = !rst_n;
  assign in = ui_in;
  assign uo_out[0] = out;
  assign uo_out[1:7] = 0;
  generate 
      top_module u_top_module(
          .clk(bit_clk),
          .dec_clk(lr_clk),
          .rst(rst),
          .in(in),
          .out(out)
      );
      
  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk,uio_in[2:7], 1'b0};

endmodule
