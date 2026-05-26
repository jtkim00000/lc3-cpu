`timescale 1ns/1ps

module tb_Register;

    reg clk;
    reg ld;

    reg [15:0] wdata;

    wire [15:0] rdata;

    register test_register (
        .clk(clk),
        .ld(ld),
        .wdata(wdata),
        .rdata(rdata)
    );

    always #20 clk = ~clk;

    initial begin
        clk = 1'b0;

        $dumpfile("sim/register.vcd");
        $dumpvars(0, tb_Register);

        //normal write then read
        ld = 1'b1; wdata = 16'd42;

        @(posedge clk) 
        #2;
        ld = 1'b0;
        #10
        if (rdata != 16'd42)
            $display("FAIL WR: expected 42, got %0d", rdata);
        else
            $display("PASS WR");

        //wrong ld
        ld = 1'b0; wdata = 16'd67;

        @(posedge clk) 
        #2;
        ld = 1'b0;
        #10
        if (rdata != 16'd42)
            $display("FAIL wLD: expected 42, got %0d", rdata);
        else
            $display("PASS wLD");

        //retains value
        #80
        if (rdata != 16'd42)
            $display("FAIL RETAIN: expected 42, got %0d", rdata);
        else
            $display("PASS RETAIN");


        $finish;

    end

endmodule