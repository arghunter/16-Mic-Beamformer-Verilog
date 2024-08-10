module op_differentiator (
    input wire clk,
    input wire rst,
    input wire lr_clk,
    input wire [18:0] in,
    output reg [18:0] out
);
    reg [18:0] temp;
    reg [18:0] prev1;
    reg [18:0] prev2;
    reg [18:0] prev3;
    reg [2:0] count;
    reg prev_lr_clk;

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
                        temp <= prev2;
                        prev2<=in-prev1;
                        prev1<=in;
                        count<=count+1;
                    end
                    1 : begin
                        
                        prev3<=prev2-temp;
                        temp<=prev3;
                        count<=count+1;
                    end
                    2 : begin
                        out<=prev3-temp;
                        
                        count<=count+1;
                    end
                endcase
            end
           prev_lr_clk <= lr_clk;
        end
    end

endmodule
