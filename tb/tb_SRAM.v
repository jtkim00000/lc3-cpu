`timescale 1ns/1ps

module tb_SRAM;

    reg clk;
    reg cs;
    reg rw;
    reg [15:0] addr;
    reg [15:0] data_in;

    wire ready;
    wire [15:0] data_out;

    sram test_sram (
        .clk(clk),
        .cs(cs),
        .rw(rw),
        .addr(addr),
        .data_in(data_in),
        .ready(ready),
        .data_out(data_out)
    );

    always #5 clk = ~clk;

    /* 
        Order for Write then Read

        1. Assert cs, set addr, data_in, rw=1 (write)
        2. Wait for ready
        3. Deassert cs
        5. wait a bit
        4. Assert cs again, same addr, rw=0 (read)
        5. Wait for ready
        6. Sample data_out and check

        This is because we wait for ready to do anything, so for a write, or a read to finish

    */

    initial begin
        clk = 1'b0;

        $dumpfile("sim/sram.vcd");
        $dumpvars(1, tb_SRAM);

        cs = 1'b0;
        repeat(2) @(posedge clk);

        //normal write then read to memory
        cs = 1'b1; addr = 16'd5; data_in = 16'd42; rw = 1'b1;

        @(posedge ready) cs = 1'b0;

        repeat(2) @(posedge clk); //wait two cycles to reassert cs

        cs = 1'b1; addr = 16'd5; rw = 1'b0;            

        @(posedge ready);
        #10
        if (data_out != 16'd42)
            $display("FAIL WR: expected 42, got %0d", data_out);
        else
            $display("PASS WR");

        cs = 1'b0;
        repeat(2) @(posedge clk);


        //wrong wr
        cs = 1'b1; addr = 16'd15; data_in = 16'd42; rw = 1'b0;

        @(posedge ready) cs = 1'b0;

        repeat(2) @(posedge clk);

        cs = 1'b1; addr = 16'd15; rw = 1'b0;            

        @(posedge ready);
        #10
        if (data_out != 16'd0)
            $display("FAIL WWR: expected 0, got %0d", data_out);
        else
            $display("PASS WWR");

        cs = 1'b0;
        repeat(2) @(posedge clk);

        //retain value
        #50

        cs = 1'b1; addr = 16'd5; rw = 1'b0;            

        @(posedge ready);
        #10
        if (data_out != 16'd42)
            $display("FAIL RETAIN: expected 42, got %0d", data_out);
        else
            $display("PASS RETAIN");


        $finish;
    end

endmodule