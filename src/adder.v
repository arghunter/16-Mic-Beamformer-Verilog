module adder (
    input wire [23:0] a,
    input wire [23:0] b,
    output wire [23:0] out
);
 assign out = a -b; 
endmodule
