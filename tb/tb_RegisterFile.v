`timescale 1ns/1ps

module tb_RegisterFile;

    reg clk;
    reg ld;

    reg [2:0] sr1;
    reg [2:0] sr2;
    reg [2:0] dr;

    reg [15:0] wdata;

    wire [15:0] sr1_out;
    wire [15:0] sr2_out;

    register_file test_register_file (
        .clk(clk),
        .ld(ld),
        .sr1(sr1),
        .sr2(sr2),
        .dr(dr),
        .wdata(wdata),
        .sr1_out(sr1_out),
        .sr2_out(sr2_out)
    );

    always #20 clk = ~clk;

    initial begin
        clk = 1'b0;

        $dumpfile("sim/register_file.vcd");
        $dumpvars(0, tb_RegisterFile);

        //normal write then read
        ld = 1'b1; dr = 3'd2; wdata = 16'd42; 

        @(posedge clk) 
        #2;
        ld = 1'b0; sr1 = 3'd2; sr2 = 3'd2;
        #10
        if (sr1_out != 16'd42)
            $display("FAIL WR SR1: expected 42, got %0d", sr1_out);
        else if(sr2_out != 16'd42)
            $display("FAIL WR SR2: expected 42, got %0d", sr2_out);
        else
            $display("PASS WR");

        //wrong ld
        ld = 1'b0; dr = 3'd4; wdata = 16'd42; 

        @(posedge clk) 
        #2;
        ld = 1'b0; sr1 = 3'd4; sr2 = 3'd4;
        #10
        if (sr1_out != 16'd0)
            $display("FAIL wLD SR1: expected 0, got %0d", sr1_out);
        else if(sr2_out != 16'd0)
            $display("FAIL wLD SR2: expected 0, got %0d", sr2_out);
        else
            $display("PASS wLD");

        //writting and reading from two locations
        ld = 1'b1; dr = 3'd5; wdata = 16'd67; 

        @(posedge clk) 
        #2;
        ld = 1'b0; sr1 = 3'd2; sr2 = 3'd5;
        #10
        if (sr1_out != 16'd42)
            $display("FAIL WR2 SR1: expected 42, got %0d", sr1_out);
        else if(sr2_out != 16'd67)
            $display("FAIL WR2 SR2: expected 67, got %0d", sr2_out);
        else
            $display("PASS WR2");

        $finish;

    end

endmodule