module register_file(
    input clk, // clock
    input ld, // LD - write enable
    input [2:0] sr1, // SR1
    input [2:0] sr2, // SR2
    input [2:0] dr, // DR
    input [15:0] wdata, // Write data
    output [15:0] sr1_out, // SR1_OUT
    output [15:0] sr2_out // SR2_OUT
);
    reg [15:0] register [7:0];

    assign sr1_out = register[sr1];
    assign sr2_out = register[sr2];

    always @(posedge clk) begin
        if(ld)
            register[dr] <= wdata;
    end
endmodule