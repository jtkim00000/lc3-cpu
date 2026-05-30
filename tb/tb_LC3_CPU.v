`timescale 1ns/1ps

module tb_LC3_CPU;

    reg clk;
    reg reset;

    lc3_cpu test_cpu (.clk(clk), .reset(reset));


endmodule