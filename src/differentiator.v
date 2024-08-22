module differentiator (
    input wire clk,
    input wire rst,
    input wire [23:0] in,
    output reg [23:0] out
);

    reg [23:0] data = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin 
            out <= 0;
            data <= 0;
        end else begin
            out <= in - data;
            data <= in;
        end
    end
endmodule
