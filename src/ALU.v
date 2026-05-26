module alu (
    input [15:0] a,
    input [15:0] b,
    input [1:0] sel,
    output reg [15:0] s
);

    always @(*) begin
        case(sel)
            2'b00: s = a + b;
            2'b01: s = a & b;
            2'b10: s = ~a;
            2'b11: s = a;
        endcase
    end

endmodule