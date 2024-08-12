module mux4to1 (
    input wire [1:0] sel,    // 2-bit select input
    input wire [18:0] d0,           // Data input 0
    input wire [18:0] d1,           // Data input 1
    input wire [18:0] d2,           // Data input 2
    input wire [18:0] d3,           // Data input 3
    output wire [18:0] y            // Output
);

    // Using a continuous assignment to implement the multiplexer logic
    assign y = (sel == 2'b00) ? d0 :
               (sel == 2'b01) ? d1 :
               (sel == 2'b10) ? d2 :
                                d3;

endmodule
