module zext #(parameter WIDTH = 5) (
    input [WIDTH-1:0] data_in,
    output [15:0] data_out
);

    assign data_out = { {(16 - WIDTH){1'b0} }, data_in};

endmodule