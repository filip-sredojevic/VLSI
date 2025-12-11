module alu (input [2:0] oc,
            input [3:0] a,
            input [3:0] b,
            output reg [3:0] f);

integer result;
always @(*) begin
    result = 0;
    if (oc == 3'b000) result = a+b;
    if (oc == 3'b001) result = a-b;
    if (oc == 3'b010) result = a*b;
    if (oc == 3'b011) result = a/b;
    if (oc == 3'b100) result = ~a;
    if (oc == 3'b101) result = a ^ b;
    if (oc == 3'b110) result = a | b;
    if (oc == 3'b111) result = a & b;
    f      = result;
    
end



endmodule
