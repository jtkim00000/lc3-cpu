//used for PC, MAR, MDR, IR
module register(
    input clk, 
    input ld,
    input [15:0] wdata, //write data
    output [15:0] rdata //read data
);

    reg [15:0] register;

    assign rdata = register;

    always @(posedge clk) begin
        if(ld)
            register <= wdata;
    end
endmodule