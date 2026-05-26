`timescale 1ns/1ps

module tb_NZPLogic;

    reg [15:0] data_in;

    wire [2:0] nzp;

    nzp_logic test_nzp_logic (
        .data_in(data_in),
        .nzp(nzp)
    );

    initial begin
        $dumpfile("sim/nzp_logic.vcd");
        $dumpvars(0, tb_NZPLogic);

        //zero
        data_in = 16'd0;
        #10;
        if(nzp != 3'b010)
            $display("FAIL NZP ZERO: expected 010, but got %0b", nzp);
        else
            $display("PASS NZP ZERO");
        
        //positive
        data_in = 16'd3;
        #10;
        if(nzp != 3'b001)
            $display("FAIL NZP POS: expected 001, but got %0b", nzp);
        else
            $display("PASS NZP POS");

        //negative
        data_in = 16'hFFFF;
        #10;
        if(nzp != 3'b100)
            $display("FAIL NZP NEG: expected 100, but got %0b", nzp);
        else
            $display("PASS NZP NEG");

        $finish;
    end

endmodule