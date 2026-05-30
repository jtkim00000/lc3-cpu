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

        $display("PC: %h", test_cpu.pc_out);
        $display("R0: %h", test_cpu.register_file.register[0]);
        $display("R1: %h", test_cpu.register_file.register[1]);
        $display("R2: %h", test_cpu.register_file.register[2]);
        $display("R3: %h", test_cpu.register_file.register[3]);
        $display("R4: %h", test_cpu.register_file.register[4]);
        $display("R5: %h", test_cpu.register_file.register[5]);
        $display("R6: %h", test_cpu.register_file.register[6]);
        $display("R7: %h", test_cpu.register_file.register[7]);
        $display("MAR: %h", test_cpu.mar_out);
        $display("mem[x3000]: %h", test_cpu.sram.mem[16'h3000]);

        $finish;

    end
endmodule