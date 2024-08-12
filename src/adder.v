module adder (
    input wire [18:0] a,
    input wire [18:0] b,
    output wire [18:0] out
);
 assign out = a -b; 
endmodule
