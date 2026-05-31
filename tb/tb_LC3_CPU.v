`timescale 1ns/1ps

module tb_LC3_CPU;

    reg clk;
    reg reset;

    lc3_cpu test_cpu (.clk(clk), .reset(reset));

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;

        $dumpfile("sim/lc3_cpu.vcd");
        $dumpvars(1, tb_LC3_CPU);

        reset = 1'b1;

        @(posedge clk); #1;

        reset = 1'b0;

        $display("Start Program");

        repeat(1000) @(posedge clk);
        $display("Registers");
        $display("R0: %h", test_cpu.register_file.register[0]);
        $display("R1: %h", test_cpu.register_file.register[1]);
        $display("R2: %h", test_cpu.register_file.register[2]);
        $display("R3: %h", test_cpu.register_file.register[3]);
        $display("R4: %h", test_cpu.register_file.register[4]);
        $display("R5: %h", test_cpu.register_file.register[5]);
        $display("R6: %h", test_cpu.register_file.register[6]);
        $display("R7: %h", test_cpu.register_file.register[7]);
        $display("\n");

        $display("Memory");
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h3072]);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h3073]);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h3074]);
        $display("\n");
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h307C]);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h307D]);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h307E]);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h307F]);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h3080]);
        $display("\n");

        $display("Other");
        $display("NZP: %b", test_cpu.nzp_out);
        $display("\n");

        /* Expected Values
        R0 = 3073
        R1 = 3072
        R2 = FFFE
        R3 = 301D
        R4 = 3020
        R5 = 3072
        R6 = 3020
        R7 = 3022

        M[3072] = 3073
        M[3073] = 3072
        M[3074] = 3072

        M[307C] = 0000
        M[307D] = 0005
        M[307E] = 0008
        M[307F] = 0001
        M[3080] = FFFE

        NZP = 001
        */

        if (test_cpu.register_file.register[0] != 16'h3073)
            $display("FAIL AT R0: expected 3073, got %0h", test_cpu.register_file.register[0]);
        else if (test_cpu.register_file.register[1] != 16'h3072)
            $display("FAIL AT R1: expected 3072, got %0h", test_cpu.register_file.register[1]);
        else if (test_cpu.register_file.register[2] != 16'hFFFE)
            $display("FAIL AT R1: expected FFFE, got %0h", test_cpu.register_file.register[2]);
        else if (test_cpu.register_file.register[3] != 16'h301D)
            $display("FAIL AT R1: expected 301D, got %0h", test_cpu.register_file.register[3]);
        else if (test_cpu.register_file.register[4] != 16'h3020)
            $display("FAIL AT R1: expected 3020, got %0h", test_cpu.register_file.register[4]);
        else if (test_cpu.register_file.register[5] != 16'h3072)
            $display("FAIL AT R1: expected 3072, got %0h", test_cpu.register_file.register[5]);
        else if (test_cpu.register_file.register[6] != 16'h3020)
            $display("FAIL AT R1: expected 3020, got %0h", test_cpu.register_file.register[6]);
        else if (test_cpu.register_file.register[7] != 16'h3022)
            $display("FAIL AT R1: expected 3022, got %0h", test_cpu.register_file.register[7]);
        else if(test_cpu.sram.mem[16'h3072] != 16'h3073)
            $display("FAIL AT M[3072]: expected 3073, got %0h", test_cpu.sram.mem[16'h3072]);
        else if(test_cpu.sram.mem[16'h3073] != 16'h3072)
            $display("FAIL AT M[3073]: expected 3072, got %0h", test_cpu.sram.mem[16'h3073]);
        else if(test_cpu.sram.mem[16'h3074] != 16'h3072)
            $display("FAIL AT M[3074]: expected 3072, got %0h", test_cpu.sram.mem[16'h3074]);
        else if(test_cpu.sram.mem[16'h307C] != 16'h0000)
            $display("FAIL AT M[307C]: expected 0000, got %0h", test_cpu.sram.mem[16'h307C]);
        else if(test_cpu.sram.mem[16'h307D] != 16'h0005)
            $display("FAIL AT M[307D]: expected 0005, got %0h", test_cpu.sram.mem[16'h307D]);
        else if(test_cpu.sram.mem[16'h307E] != 16'h0008)
            $display("FAIL AT M[307E]: expected 0008, got %0h", test_cpu.sram.mem[16'h307E]);
        else if(test_cpu.sram.mem[16'h307F] != 16'h0001)
            $display("FAIL AT M[307F]: expected 0001, got %0h", test_cpu.sram.mem[16'h307F]);
        else if(test_cpu.sram.mem[16'h3080] != 16'hFFFE)
            $display("FAIL AT M[3080]: expected FFFE, got %0h", test_cpu.sram.mem[16'h3080]);
        else if (test_cpu.nzp_out != 3'b001)
            $display("FAIL AT NZP: expected 001, got %0b", test_cpu.nzp_out);
        else
            $display("PASSED ALL CPU TESTS!!!!!!!!!!!!!!!!!!!!!!!!!!!");

        $display("\n");

        $finish;

    end
endmodule