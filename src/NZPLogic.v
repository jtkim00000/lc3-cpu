/* 
    NZP Logic

    Combinational logic circuit that uses whatever data is on the bus as an input

    It then interprets this vector as a 2's compliment value, and outs puts a 3-bit vector corresponding to the sign

*/

module nzp_logic (
    input [15:0] data_in,
    output reg [2:0] nzp
);

    always @(*) begin
        if (data_in == 16'd0)
            nzp = 3'b010;
        else if (data_in[15] == 1'b1)
            nzp = 3'b100;
        else
            nzp = 3'b001;
    end

endmodule