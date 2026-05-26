module sext #(parameter WIDTH = 5) (
    input [WIDTH-1:0] data_in,
    output [15:0] data_out
);

    assign data_out = { {(16 - WIDTH){data_in[WIDTH-1]} }, data_in};

endmodule