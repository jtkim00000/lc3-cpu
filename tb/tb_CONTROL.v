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
        $dumpvars(0, tb_Control);

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
        IR = 16'h2000;

        if(current_state != 6'd18)
            $display("FAIL FETCH16: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH16");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH17: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH17");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH18: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH18");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE6: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE6");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd2)
            $display("FAIL LD1: expected state 2, got %0d", current_state);
        else
            $display("PASS LD1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b0;

        if(current_state != 6'd25)
            $display("FAIL LD2: expected state 25, got %0d", current_state);
        else
            $display("PASS LD2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b1;

        if(current_state != 6'd25)
            $display("FAIL LD2R: expected state 25, got %0d", current_state);
        else
            $display("PASS LD2R");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd27)
            $display("FAIL LD3: expected state 27, got %0d", current_state);
        else
            $display("PASS LD3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== LDR ====================

        BEN = 1'b0;
        IR = 16'h6000;

        if(current_state != 6'd18)
            $display("FAIL FETCH19: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH19");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH20: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH20");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH21: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH21");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE7: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE7");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd6)
            $display("FAIL LDR1: expected state 6, got %0d", current_state);
        else
            $display("PASS LD1R");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd25)
            $display("FAIL LDR2: expected state 25, got %0d", current_state);
        else
            $display("PASS LDR2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd27)
            $display("FAIL LDR3: expected state 27, got %0d", current_state);
        else
            $display("PASS LDR3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== LDI ====================

        BEN = 1'b0;
        IR = 16'hA000;

        if(current_state != 6'd18)
            $display("FAIL FETCH22: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH22");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH23: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH23");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH24: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH24");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE8: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE8");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd10)
            $display("FAIL LDI1: expected state 10, got %0d", current_state);
        else
            $display("PASS LDI1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b0;

        if(current_state != 6'd24)
            $display("FAIL LDI2: expected state 24, got %0d", current_state);
        else
            $display("PASS LDI2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b1;

        if(current_state != 6'd24)
            $display("FAIL LDI2R: expected state 24, got %0d", current_state);
        else
            $display("PASS LDI2R");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd26)
            $display("FAIL LDI3: expected state 26, got %0d", current_state);
        else
            $display("PASS LDI3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd25)
            $display("FAIL LDI4: expected state 25, got %0d", current_state);
        else
            $display("PASS LDI4");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd27)
            $display("FAIL LDI5: expected state 27, got %0d", current_state);
        else
            $display("PASS LDI5");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== STI ====================

        BEN = 1'b0;
        IR = 16'hB000;

        if(current_state != 6'd18)
            $display("FAIL FETCH25: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH25");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH26: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH26");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH27: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH27");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE9: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE9");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd11)
            $display("FAIL STI1: expected state 11, got %0d", current_state);
        else
            $display("PASS STI1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b0;

        if(current_state != 6'd29)
            $display("FAIL STI2: expected state 29, got %0d", current_state);
        else
            $display("PASS STI2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b1;

        if(current_state != 6'd29)
            $display("FAIL STI2R: expected state 29, got %0d", current_state);
        else
            $display("PASS STI2R");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd31)
            $display("FAIL STI3: expected state 31, got %0d", current_state);
        else
            $display("PASS STI3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd23)
            $display("FAIL STI4: expected state 23, got %0d", current_state);
        else
            $display("PASS STI4");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b0;

        if(current_state != 6'd16)
            $display("FAIL STI5: expected state 16, got %0d", current_state);
        else
            $display("PASS STI5");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        R = 1'b1;

        if(current_state != 6'd16)
            $display("FAIL STI5R: expected state 16, got %0d", current_state);
        else
            $display("PASS STI5R");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== STR ====================

        BEN = 1'b0;
        IR = 16'h7000;

        if(current_state != 6'd18)
            $display("FAIL FETCH28: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH28");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH29: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH29");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH30: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH30");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE10: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE10");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd7)
            $display("FAIL STR1: expected state 7, got %0d", current_state);
        else
            $display("PASS STR1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd23)
            $display("FAIL STR2: expected state 23, got %0d", current_state);
        else
            $display("PASS STR2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd16)
            $display("FAIL STR3: expected state 16, got %0d", current_state);
        else
            $display("PASS STR3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== STR ====================

        BEN = 1'b0;
        IR = 16'h3000;

        if(current_state != 6'd18)
            $display("FAIL FETCH31: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH31");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH32: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH32");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH33: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH33");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE11: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE11");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd3)
            $display("FAIL ST1: expected state 3, got %0d", current_state);
        else
            $display("PASS ST1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd23)
            $display("FAIL ST2: expected state 23, got %0d", current_state);
        else
            $display("PASS ST2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd16)
            $display("FAIL ST3: expected state 16, got %0d", current_state);
        else
            $display("PASS ST3");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== BR ====================
        // BEN = 0;
        BEN = 1'b0;
        IR = 16'h0000;

        if(current_state != 6'd18)
            $display("FAIL FETCH34: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH34");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH35: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH35");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH36: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH36");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE12: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE12");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd0)
            $display("FAIL BR1 BEN0: expected state 0, got %0d", current_state);
        else
            $display("PASS BR1 BEN0");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== BR ====================
        // BEN = 1;
        BEN = 1'b1;
        IR = 16'h0000;

        if(current_state != 6'd18)
            $display("FAIL FETCH37: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH37");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH38: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH38");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH39: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH39");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE13: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE13");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd0)
            $display("FAIL BR1 BEN1: expected state 0, got %0d", current_state);
        else
            $display("PASS BR1 BEN1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd22)
            $display("FAIL BR2 BEN1: expected state 22, got %0d", current_state);
        else
            $display("PASS BR2 BEN1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== JMP ====================
        BEN = 1'b0;
        IR = 16'hC000;

        if(current_state != 6'd18)
            $display("FAIL FETCH40: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH40");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH41: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH41");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH42: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH42");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE14: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE14");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd12)
            $display("FAIL JMP: expected state 12, got %0d", current_state);
        else
            $display("PASS JMP");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== JSR ====================
        BEN = 1'b0;
        IR = 16'h4800;

        if(current_state != 6'd18)
            $display("FAIL FETCH43: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH43");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH44: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH44");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH45: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH15");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE15: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE15");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd4)
            $display("FAIL JSR1: expected state 4, got %0d", current_state);
        else
            $display("PASS JSR1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd21)
            $display("FAIL JSR2: expected state 21, got %0d", current_state);
        else
            $display("PASS JSR2");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        // ==================== JSRR ====================
        BEN = 1'b0;
        IR = 16'h4000;

        if(current_state != 6'd18)
            $display("FAIL FETCH46: expected state 18, got %0d", current_state);
        else
            $display("PASS FETCH46");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd33)
            $display("FAIL FETCH47: expected state 33, got %0d", current_state);
        else
            $display("PASS FETCH47");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd35)
            $display("FAIL FETCH48: expected state 35, got %0d", current_state);
        else
            $display("PASS FETCH18");
        
        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd32)
            $display("FAIL DECODE16: expected state 32, got %0d", current_state);
        else
            $display("PASS DECODE16");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd4)
            $display("FAIL JSR1: expected state 4, got %0d", current_state);
        else
            $display("PASS JSR1");

        CLK = 1'b0;
        #10;
        CLK = 1'b1;
        #10;

        if(current_state != 6'd20)
            $display("FAIL JSR2: expected state 20, got %0d", current_state);
        else
            $display("PASS JSR2");

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