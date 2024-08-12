// `include "adder.v"
// `include "mux.v"
module op_differentiator (
    input wire clk,
    input wire rst,
    input wire lr_clk,
    input wire [18:0] in,
    output reg [18:0] out
);
    reg [18:0] zero=0;
    reg [18:0] temp;
    reg [18:0] prev1;
    reg [18:0] prev2;
    reg [18:0] prev3;
    reg [2:0] count;
    reg prev_lr_clk;
    wire [18:0] mux_out;
    wire [18:0] adder_out;
    generate
        mux4to1 a_mux4to1(//Prolly dont need this
          .sel(count[1:0]),
          .d0(zero),
          .d1(prev1),
          .d2(prev2),
          .d3(prev3),
          .y(mux_out)
        );
        adder u_adder(
            .a(mux_out),
            .b(temp),
            .out(adder_out)
        );

    endgenerate
//MADE AN ADDER AND USE MUXES TO CONTROL INPUT OUTPUT
    always @(posedge clk or posedge rst) begin

        if (rst) begin
            prev1 <= 0;
            prev2 <= 0;
            prev3 <= 0;
            temp<= 0; 
            count<= 0; 
            prev_lr_clk<= 0;     
        end else begin
            if(lr_clk && !prev_lr_clk ) begin
                count<=0;
            end else begin
                case (count)
                    0 : begin
                        temp<=prev1;
                        prev1<=in;
                        count<=1;
                    end
                    1 : begin
                        temp <= prev2;
                        prev2<=adder_out;
                        count<=2;
                    end
                    2 : begin
                        
                        prev3<=adder_out;
                        temp<=prev3;
                        count<=3;
                    end
                    3 : begin
                        out<=adder_out;
                        count<=4;
                    end
                endcase
            end
           prev_lr_clk <= lr_clk;
        end
    end

endmodule
