module lc3_cpu (input clk);

    /*
        Below are the wires that connect modules together
    */

    wire [15:0] bus;

    //Memory
    wire [15:0] mdr_out, mar_out, sram_out;
    wire ready_out;

    //Instruction Register
    wire [15:0] ir_out;

    //SEXT / ZEXT
    wire [15:0] sext_5_out, sext_6_out, sext_9_out, sext_11_out;
    wire [15:0] zext_out;

    //Multiplexers
    wire [15:0] addr2mux_out, addr1mux_out, marmux_out, pcmux_out, sr2mux_out, miomux_out;
    wire [2:0] drmux_out, sr1mux_out;

    //Other Registers
    wire [15:0] pc_out;
    wire [2:0] nzp_out;
    wire ben_comp_reg_out;

    //Branch Enable
    wire [2:0] nzp_logic_out;
    wire ben_comp_out;

    //ALU
    wire [15:0] alu_out;

    //Register File
    wire [15:0] sr1_out, sr2_out;

    //Other
    wire [15:0] addr_add_out;
    assign addr_add_out = addr1mux_out + addr2mux_out;

    //Control Signals
    wire rw, mio_en;
    wire ld_mar, ld_mdr, ld_ir, ld_pc, ld_cc, ld_ben, ld_reg;
    wire addr1_mux, mar_mux;
    wire [1:0] addr2_mux, dr_mux, sr1_mux, aluk, pc_mux;
    wire gate_mdr, gate_alu, gate_marmux, gate_pc;

    //Unused
    wire [5:0] current_state;

    /*
        Below is the instantiate modules
    */

    //Registers
    register mar (
        .clk(clk),
        .ld(ld_mar),
        .wdata(bus),
        .rdata(mar_out)
    );

    register mdr (
        .clk(clk),
        .ld(ld_mdr),
        .wdata(miomux_out),
        .rdata(mdr_out)
    );

    register ir (
        .clk(clk),
        .ld(ld_ir),
        .wdata(bus),
        .rdata(ir_out)
    );

    register pc (
        .clk(clk),
        .ld(ld_pc),
        .wdata(pcmux_out),
        .rdata(pc_out)
    );

    //EXT
    sext #(5) sext_5 (.data_in(ir_out[4:0]), .data_out(sext_5_out));
    sext #(6) sext_6 (.data_in(ir_out[5:0]), .data_out(sext_6_out));
    sext #(9) sext_9 (.data_in(ir_out[8:0]), .data_out(sext_9_out));
    sext #(11) sext_11 (.data_in(ir_out[10:0]), .data_out(sext_11_out));
    zext zext (.data_in(ir_out[7:0]), .data_out(zext_out));

    //Muxes
    mux #(.INPUT_WIDTH(2), .SELECT_BITS(1)) miomux (
        .data_in({sram_out, bus}),
        .sel(mio_en),
        .out(miomux_out)
    );

    mux #(.INPUT_WIDTH(2), .SELECT_BITS(1)) marmux (
        .data_in({addr_add_out, zext_out}),
        .sel(mar_mux),
        .out(marmux_out)
    );

    mux #(.INPUT_WIDTH(2), .SELECT_BITS(1)) sr2mux (
        .data_in({sext_5_out, sr2_out}),
        .sel(ir_out[5]),
        .out(sr2mux_out)
    );

    mux #(.INPUT_WIDTH(2), .SELECT_BITS(1)) addr1mux (
        .data_in({sr1_out, pc_out}),
        .sel(addr1_mux),
        .out(addr1mux_out)
    );

    mux #(.INPUT_WIDTH(4), .SELECT_BITS(2)) addr2mux (
        .data_in({sext_11_out, sext_9_out, sext_6_out, 16'd0}),
        .sel(addr2_mux),
        .out(addr2mux_out)
    );

    mux #(.INPUT_WIDTH(3), .SELECT_BITS(2)) pcmux (
        .data_in({addr_add_out, bus, (pc_out + 1'b1)}),
        .sel(pc_mux),
        .out(pcmux_out)
    );

    mux #(.DATA_WIDTH(3), .INPUT_WIDTH(3), .SELECT_BITS(2)) drmux (
        .data_in({3'b110, 3'b111, ir_out[11:9]}),
        .sel(dr_mux),
        .out(drmux_out)
    );

    mux #(.DATA_WIDTH(3), .INPUT_WIDTH(3), .SELECT_BITS(2)) sr1mux (
        .data_in({3'b110, ir_out[8:6], ir_out[11:9]}),
        .sel(sr1_mux),
        .out(sr1mux_out)
    );

    //Register file
    register_file register_file (
        .clk(clk),
        .ld(ld_reg),
        .sr1(sr1mux_out),
        .sr2(ir_out[2:0]),
        .dr(drmux_out),
        .wdata(bus),
        .sr1_out(sr1_out),
        .sr2_out(sr2_out)
    );

    //ALU
    alu alu (
        .a(sr1_out),
        .b(sr2mux_out),
        .sel(aluk),
        .s(alu_out)
    );

    //Memory
    sram sram (
        .clk(clk),
        .cs(mio_en),
        .rw(rw),
        .addr(mar_out),
        .data_in(mdr_out),
        .ready(ready_out),
        .data_out(sram_out)
    );

    //BEN
    nzp_logic nzp_logic (
        .data_in(bus),
        .data_out(nzp_logic_out)
    );

    register #(.WIDTH(3)) nzp (
        .clk(clk),
        .ld(ld_cc),
        .wdata(nzp_logic_out),
        .rdata(nzp_out)
    );

    ben_comp ben_comp (
        .nzp(nzp_out),
        .ir(ir_out[11:9]),
        .ben(ben_comp_out)
    );

    register #(.WIDTH(1)) ben_comp_reg (
        .clk(clk),
        .ld(ld_ben),
        .wdata(ben_comp_out),
        .rdata(ben_comp_reg_out)
    );

    //Control
    control control (
        .R(ready_out),
        .BEN(ben_comp_reg_out),
        .IR(ir_out),
        .CLK(clk),
        .LD_MAR(ld_mar),
        .LD_MDR(ld_mdr),
        .LD_IR(ld_ir),
        .LD_PC(ld_pc),
        .LD_REG(ld_reg),
        .LD_BEN(ld_ben),
        .LD_CC(ld_cc),
        .MARMUX(mar_mux),
        .ADDR1MUX(addr1_mux),
        .ADDR2MUX(addr2_mux),
        .PCMUX(pc_mux),
        .SR1MUX(sr1_mux),
        .DRMUX(dr_mux),
        .GateMARMUX(gate_marmux),
        .GateMDR(gate_mdr),
        .GateALU(gate_alu),
        .GatePC(gate_pc),
        .MIO_EN(mio_en),
        .RW(rw),
        .ALUK(aluk),
        .current_state(current_state)
    );

    //Tri-state buffer for Gates

    assign bus =    gate_pc     ? pc_out     :
                    gate_mdr    ? mdr_out    :
                    gate_alu    ? alu_out    :
                    gate_marmux ? marmux_out :
                    16'h0000;

endmodule