`timescale 1ps/1ps 

module tb_BEN_COMP;

    reg [2:0] nzp;
    reg [2:0] ir;

    wire ben;

    ben_comp test_ben_comp (
        .nzp(nzp),
        .ir(ir),
        .ben(ben)
    );

    initial begin
        $dumpfile("sim/ben_comp.vcd");
        $dumpvars(0, tb_BEN_COMP);

        //none
        nzp = 3'b001; ir = 3'b100;
        #10;
        if (ben != 1'b0)
            $display("FAIL BEN NONE: expected 0, got %0d", ben);
        else
            $display("PASS BEN NONE");

        //one
        nzp = 3'b100; ir = 3'b100;
        #10;
        if (ben != 1'b1)
            $display("FAIL BEN ONE: expected 1, got %0d", ben);
        else
            $display("PASS BEN ONE");

        //multiple
        nzp = 3'b111; ir = 3'b100;
        #10;
        if (ben != 1'b1)
            $display("FAIL BEN SOME: expected 1, got %0d", ben);
        else
            $display("PASS BEN SOME"); 

        $finish;
    end


endmodule