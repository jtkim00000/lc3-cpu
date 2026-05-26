module mux #(
    parameter INPUT_WIDTH = 2, // # of 16 bit inputs
    parameter SELECT_BITS = 1
) (
    input [(INPUT_WIDTH*16)-1:0] data_in,
    input [SELECT_BITS-1:0] sel,
    output [15:0] out
);

    assign out = data_in[sel*16 +: 16];

endmodule