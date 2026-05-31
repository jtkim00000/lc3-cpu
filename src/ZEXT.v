/*
    ZEXT

    interprets a input vector with variable width as an unsigned number
    ouputs a 16-bit vector with the same value when interpreted as unsigned integer
*/

module zext (
    input [7:0] data_in,
    output [15:0] data_out
);

    assign data_out = { {8{1'b0} }, data_in};

endmodule