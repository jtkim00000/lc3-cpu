//used for PC, MAR, MDR, IR
module register #(parameter WIDTH = 16) (
    input clk, 
    input ld,
    input [WIDTH-1:0] wdata, //write data
    output [WIDTH-1:0] rdata //read data
);

    reg [WIDTH-1:0] register;

    assign rdata = register;

    always @(posedge clk) begin
        if(ld)
            register <= wdata;
    end
endmodule