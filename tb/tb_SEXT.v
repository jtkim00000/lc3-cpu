`timescale 1ns/1ps

module tb_SEXT;

    //possible data_ins
    reg [4:0] imm5;
    reg [5:0] offset6;
    reg [8:0] PCoffset9;
    reg [10:0] PCoffset11;

    wire [15:0] out5, out6, out9, out11;

    sext #(5) test_imm5 (.data_in(imm5), .data_out(out5));
    sext #(6) test_offset6 (.data_in(offset6), .data_out(out6));
    sext #(9) test_PCoffset9 (.data_in(PCoffset9), .data_out(out9));
    sext #(11) test_PCoffset11 (.data_in(PCoffset11), .data_out(out11));

    initial begin
        $dumpfile("sim/sext.vcd");
        $dumpvars(0, tb_SEXT);

        //imm5
        imm5 = 5'd3;
        #10;
        if(out5 != 16'd3)
            $display("FAIL IMM5 POS: expected 3, got %0d", out5);
        else   
            $display("PASS IMM5 POS");

        imm5 = 5'b11110;
        #10;
        if(out5 != 16'hFFFE)
            $display("FAIL IMM5 NEG: expected -2, got %0d", out5);
        else   
            $display("PASS IMM5 NEG");

        imm5 = 5'd0;
        #10;
        if(out5 != 16'd0)
            $display("FAIL IMM5 ZERO: expected 0, got %0d", out5);
        else   
            $display("PASS IMM5 ZERO");

        //offset6
        offset6 = 6'd3;
        #10;
        if(out6 != 16'd3)
            $display("FAIL OFFSET6 POS: expected 3, got %0d", out5);
        else   
            $display("PASS OFFSET6 POS");

        offset6 = 6'b111110;
        #10;
        if(out6 != 16'hFFFE)
            $display("FAIL OFFSET6 NEG: expected -2, got %0d", out5);
        else   
            $display("PASS OFFSET6 NEG");

        offset6 = 6'd0;
        #10;
        if(out6 != 16'd0)
            $display("FAIL OFFSET6 ZERO: expected 0, got %0d", out5);
        else   
            $display("PASS OFFSET6 ZERO");

        //offset9
        PCoffset9 = 9'd3;
        #10;
        if(out9 != 16'd3)
            $display("FAIL PCOFFSET9 POS: expected 3, got %0d", out5);
        else   
            $display("PASS PCOFFSET9 POS");

        PCoffset9 = 9'b111111110;
        #10;
        if(out9 != 16'hFFFE)
            $display("FAIL PCOFFSET9 NEG: expected -2, got %0d", out5);
        else   
            $display("PASS PCOFFSET9 NEG");

        PCoffset9 = 9'd0;
        #10;
        if(out9 != 16'd0)
            $display("FAIL PCOFFSET9 ZERO: expected 0, got %0d", out5);
        else   
            $display("PASS PCOFFSET9 ZERO");

        //offset11
        PCoffset11 = 11'd3;
        #10;
        if(out11 != 16'd3)
            $display("FAIL PCOFFSET11 POS: expected 3, got %0d", out5);
        else   
            $display("PASS PCOFFSET11 POS");

        PCoffset11 = 11'b11111111110;
        #10;
        if(out11 != 16'hFFFE)
            $display("FAIL PCOFFSET11 NEG: expected -2, got %0d", out5);
        else   
            $display("PASS PCOFFSET11 NEG");

        PCoffset11 = 11'd0;
        #10;
        if(out11 != 16'd0)
            $display("FAIL PCOFFSET11 ZERO: expected 0, got %0d", out5);
        else   
            $display("PASS PCOFFSET11 ZERO");

        $finish;
    end

endmodule