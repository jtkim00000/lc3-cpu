module ben_comp (
    input [2:0] nzp,
    input [2:0] ir,
    output ben
);

    assign ben = (nzp[0] & ir[0]) | (nzp[1] & ir[1]) | (nzp[2] & ir[2]);

endmodule