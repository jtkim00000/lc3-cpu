/*
    Branch Enable Comparator

    Computes the BEN signal by ANDing each NZP condition code bit with the corresponding bit from IR[11:9] (the branch condition mask in the BR instruction):

    The output is stored in a 1-bit register and used as an input for the control.

 */

module ben_comp (
    input [2:0] nzp,
    input [2:0] ir,
    output ben
);

    assign ben = (nzp[0] & ir[0]) | (nzp[1] & ir[1]) | (nzp[2] & ir[2]);

endmodule