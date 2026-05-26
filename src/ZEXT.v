module zext (
    input [7:0] data_in,
    output [15:0] data_out
);

    assign data_out = { {8{1'b0} }, data_in};

endmodule