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
        .RESET(RESET),
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

        //RESET to state 18
        CLK = 1'b0;
        RESET = 1'b1;
        #10;
        CLK = 1'b1;
        #10;
        CLK = 1'b0;
        #10;
        RESET = 1'b0;
        $display("State after reset: %0d", current_state);

        // ==================== ADD ====================

        R = 1'b0; BEN = 1'b0;
        IR = 16'h1000;
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
            $display("FAIL DECODE1: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE1");

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

        // ==================== AND ====================

        BEN = 1'b0;
        IR = 16'h5000;

        if(current_state != 6'd18)
            $display("FAIL FETCH4: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH4");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH5: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH5");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH6: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH6");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE2: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd5)
            $display("FAIL AND: expected state 5, got %0d", current_state);
        else
            $display("PASS AND");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== NOT ====================

        BEN = 1'b0;
        IR = 16'h903F;

        if(current_state != 6'd18)
            $display("FAIL FETCH7: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH7");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH8: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH8");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH9: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH9");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE3: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd9)
            $display("FAIL NOT: expected state 9, got %0d", current_state);
        else
            $display("PASS NOT");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== TRAP ====================

        BEN = 1'b0;
        IR = 16'hF000;

        if(current_state != 6'd18)
            $display("FAIL FETCH10: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH10");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH11: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH11");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH12: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH12");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE4: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE4");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd15)
            $display("FAIL TRAP1: expected state 15, got %0d", current_state);
        else
            $display("PASS TRAP1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b0;

        if(current_state != 6'd28)
            $display("FAIL TRAP2: expected state 28, got %0d", current_state);
        else
            $display("PASS TRAP2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b1;

        if(current_state != 6'd28)
            $display("FAIL TRAP2R: expected state 28, got %0d", current_state);
        else
            $display("PASS TRAP2R");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd30)
            $display("FAIL TRAP3: expected state 30, got %0d", current_state);
        else
            $display("PASS TRAP3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== LEA ====================

        BEN = 1'b0;
        IR = 16'hE000;

        if(current_state != 6'd18)
            $display("FAIL FETCH13: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH13");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH14: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH14");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH15: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH15");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE5: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE5");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd14)
            $display("FAIL LEA: expected state 14, got %0d", current_state);
        else
            $display("PASS LEA");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== LD ====================

        BEN = 1'b0;
        IR = 16'h5000;

        if(current_state != 6'd18)
            $display("FAIL FETCH13: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH13");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH14: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH14");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH15: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH15");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE5: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE5");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd14)
            $display("FAIL LEA: expected state 14, got %0d", current_state);
        else
            $display("PASS LEA");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;


    
        $finish;
    end

endmodule