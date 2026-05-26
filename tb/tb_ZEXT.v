`timescale 1ns/1ps

module tb_ZEXT;

    //possible data_ins
    reg [7:0] data_in;

    wire [15:0] data_out;

    zext test_zext (.data_in(data_in), .data_out(data_out));

    initial begin
        $dumpfile("sim/zext.vcd");
        $dumpvars(0, tb_ZEXT);

        //data_in
        data_in = 8'd3;
        #10;
        if(data_out != 16'd3)
            $display("FAIL POS: expected 3, got %0d", data_out);
        else   
            $display("PASS POS");

        data_in = 8'hEE;
        #10;
        if(data_out != 16'h00EE)
            $display("FAIL NEG: expected OOEE got %0h", data_out);
        else   
            $display("PASS NEG");

        data_in = 8'd0;
        #10;
        if(data_out != 16'd0)
            $display("FAIL ZERO: expected 0, got %0d", data_out);
        else   
            $display("PASS ZERO");

        $finish;
    end

endmodule