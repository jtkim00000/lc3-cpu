module ben_comp (
    input [2:0] nzp,
    input [2:0] ir,
    output reg ben
);

    assign ben = (nzp[0] & nzp[0]) | (nzp[1] & nzp[1]) | (nzp[2] & nzp[2]) |;

endmodule