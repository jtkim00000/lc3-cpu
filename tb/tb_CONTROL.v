`timescale 1ns/1ps


//Only use for microsequencer testing. Outputs are just based on case statements
module tb_CONTROL;

    reg R;
    reg BEN;
    reg [15:0] IR;
    reg CLK;
    reg RESET;

    wire [5:0] current_state;

    wire LD_MAR;
    wire LD_MDR;
    wire LD_IR;
    wire LD_PC;
    wire LD_REG;
    wire LD_BEN;
    wire LD_CC;
    wire MARMUX;
    wire ADDR1MUX;
    wire [1:0] ADDR2MUX;
    wire [1:0] PCMUX;
    wire [1:0] SR1MUX;
    wire [1:0] DRMUX;
    wire GateMARMUX;
    wire GateMDR;
    wire GateALU;
    wire GatePC;
    wire MIO_EN;
    wire RW;
    wire [1:0] ALUK;

    control test_control (
        .R(R),
        .BEN(BEN),
        .IR(IR),
        .CLK(CLK),
        .LD_MAR(LD_MAR),
        .LD_MDR(LD_MDR),
        .LD_IR(LD_IR),
        .LD_PC(LD_PC),
        .LD_REG(LD_REG),
        .LD_BEN(LD_BEN),
        .LD_CC(LD_CC),
        .MARMUX(MARMUX),
        .ADDR1MUX(ADDR1MUX),
        .ADDR2MUX(ADDR2MUX),
        .PCMUX(PCMUX),
        .SR1MUX(SR1MUX),
        .DRMUX(DRMUX),
        .GateMARMUX(GateMARMUX),
        .GateMDR(GateMDR),
        .GateALU(GateALU),
        .GatePC(GatePC),
        .MIO_EN(MIO_EN),
        .RW(RW),
        .ALUK(ALUK),
        .current_state(current_state)
    );

    initial begin
        CLK = 1'b0;

        $dumpfile("sim/control.vcd");
        $dumpvars(0, tb_CONTROL);

        RESET = 1'b1;

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        RESET = 1'b0;

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        //ADD
        R = 1'b0; BEN = 1'b0;
        IR = 16'b0001000000000000;

        CLK = 1'b1;
        #10;

        if(current_state != 6'd18)
            $display("FAIL FETCH1: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH2: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH2R: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH2R");

        R = 1'b1;

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH3: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd1)
            $display("FAIL ADD: expected state 1, got %0d", current_state);
        else
            $display("PASS ADD");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd18)
            $display("FAIL FETCHBACK: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCHBACK");


        $finish;
    end

endmodule