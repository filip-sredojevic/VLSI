module register (input clk,
                 input rst_n,
                 input cl,
                 input ld,
                 input [3:0] in,
                 input inc,
                 input dec,
                 input sr,
                 input ir,
                 input sl,
                 input il,
                 output reg[3:0] out);
    
    
    always @(posedge clk, negedge rst_n) begin
        
        if (!rst_n)out = 4'b0000;
        
        else begin
        
        if (cl) out       = 4'b0000;
        else if (ld) out  = in;
        else if (inc) out = out + 4'b0001;
        else if (dec) out = out - 4'b0001;
        else if (sr) begin
        out    = out >> 1;
        out[4] = ir;
    end
    else if (sl) begin
    out    = out <<1 ;
    out[0] = il;
    end
    end
    
    
    end
    
    
endmodule
