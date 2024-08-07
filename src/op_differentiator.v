module op_differentiator (
    input wire clk,
    input wire rst,
    input wire lr_clk,
    input wire [18:0] in,
    output reg [18:0] out
);
    reg [18:0] temp = 0;
    reg [18:0] temp2 = 0;
    reg [18:0] temp3 = 0;
    reg [18:0] prev1 = 0;
    reg [18:0] prev2 = 0;
    reg [18:0] prev3 = 0;
    reg [2:0] count=0;
    always @(posedge rst) begin
        if (rst) begin 
            out <= 0;
            prev1 <= 0;
            prev2 <= 0;
            prev3 <= 0;
            temp<=0;
    end
    always @(posedge clk) begin
            // USE A CASE STATEMENT
        if(count == 0) begin
            temp2<=in-prev1;
            temp<=in;
            count<=count+1;
        end else if(count ==1) begin
            prev1<=temp;
            temp3<=temp2-prev2;
            count<=count+1;
        end else if(count==2) begin
            out<=temp3-prev3;
            prev2<=temp2;
            count<=count+1;
        end else begin  
            prev3<=temp3;
        end
    end
    always @(posedge lr_clk) begin
        count<=0;
    end
endmodule
