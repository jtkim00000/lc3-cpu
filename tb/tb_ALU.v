`timescale 1ns/1ps


module tb_ALU;

    //input reg
    reg [15:0] a;
    reg [15:0] b;
    reg [1:0] sel;
    //output wire
    wire [15:0] s;

    alu test_alu (
       .a(a),
       .b(b),
       .sel(sel),
       .s(s)
    );

    initial begin
        $dumpfile("sim/alu.vcd");
        $dumpvars(0, tb_ALU);

        //add
        a = 16'd1; b = 16'd3; sel = 2'd0;
        #10;  //wait
        if (s !== 32'd4)
            $display("FAIL ADD: expected 4, got %0d", s);
        else
            $display("PASS ADD");

        //overflow edgecase
        a = 16'hFFFF; b = 16'd1; sel = 2'd0;
        #10;
        if (s !== 16'd0)
            $display("FAIL ADD overflow: expected 0, got %0d", s);
        else
            $display("PASS ADD overflow");

        //adding zeros
        a = 16'd0; b = 16'd0; sel = 2'd0;
        #10;
        if (s !== 16'd0)
            $display("FAIL ADD zero: expected 0, got %0h", s);
        else
            $display("PASS ADD zero");

        //and
        a = 16'hFEFE; b = 16'hAABB; sel = 2'd1;
        #10;
        if (s !== 16'hAABA)
            $display("FAIL AND: expected AABA, got %0h", s);
        else
            $display("PASS AND");

        //and zero
        a = 16'hABCD; b = 16'h0000; sel = 2'd1;
        #10;
        if (s !== 16'h0000)
            $display("FAIL AND zero: expected 0, got %0h", s);
        else
            $display("PASS AND zero");

        //not
        a = 16'hAABB; b = 16'hEEEE; sel = 2'd2;
        #10;
        if (s !== 16'h5544)
            $display("FAIL NOT: expected 5544, got %0h", s);
        else
            $display("PASS NOT");

        //not 0
        a = 16'h0000; b = 16'hEEEE; sel = 2'd2;
        #10;
        if (s !== 16'hFFFF)
            $display("FAIL NOT zero: expected FFFF, got %0h", s);
        else
            $display("PASS NOT zero");

        //pass
        a = 16'h4242; b = 16'hEEEE; sel = 2'd3;
        #10;
        if (s !== 16'h4242)
            $display("FAIL, PASS: expected 4242, got %0h", s);
        else
            $display("PASS, PASS");
        $finish;
    end

endmodule