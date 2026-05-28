module lc3_cpu ();

    reg clk;

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

    //Control Signals
    wire rw, mio_en;
    wire ld_mar, ld_mdr, ld_ir, ld_pc, ld_cc, ld_ben, ld_reg;
    wire addr1_mux, mar_mux;
    wire [1:0] addr2_mux, dr_mux, sr1_mux, aluk, pc_mux;
    wire gate_mdr, gate_alu, gate_marmux, gate_pc;

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
    sext #(5) sext_5 (.data_in(ir[4:0]), .data_out(sext_5_out));
    sext #(6) sext_6 (.data_in(ir[5:0]), .data_out(sext_6_out));
    sext #(9) sext_9 (.data_in(ir[8:0]), .data_out(sext_9_out));
    sext #(11) sext_11 (.data_in(ir[10:0]), .data_out(sext_11_out));
    zext zext (.data_in(ir[7:0]), .data_out(zext_out));

    //Muxes
    mux #(2, 1) miomux (
        .data_in({sram_out, bus}),
        .sel(mio_en),
        .out(miomux_out)
    );

    mux #(2, 1) marmux (
        .data_in({addr_add_out, zext_out}),
        .sel(mar_mux),
        .out(marmux_out)
    );

    mux #(2, 1) sr2mux (
        .data_in({sext_5_out, sr2_out}),
        .sel(ir[5]),
        .out(sr1mux_out)
    );

    mux #(2, 1) addr1mux (
        .data_in({sr1_out, pc_out}),
        .sel(addr1_mux),
        .out(addr1mux_out)
    );

    mux #(4, 2) addr2mux (
        .data_in({sext_11_out, sext_9_out, sext_6_out, 16'd0}),
        .sel(addr2_mux),
        .data_out(addr2mux_out)
    );

    mux #(4, 2) pcmux (
        .data_in({16'd0, addr_add_out, bus, (pc_out + 1'b1)}),
        .sel(pc_mux),
        .out(pcmux_out)
    );

    //Register file
    register_file register_file (
        .clk(clk),
        .ld(ld_reg),
        .sr1(sr1mux_out),
        .sr2(ir[2:0]),
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

    register #(3) nzp (
        .clk(clk),
        .ld(ld_cc),
        .wdata(nzp_logic_out),
        .rdata(nzp_out)
    );

    ben_comp ben_comp (
        .nzp(nzp_out),
        .ir(ir[11:9]),
        .ben(ben_comp_out)
    );

    //NEED BEN COMP Reg
    register #(1) ben_comp_reg (
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
        .DR(dr_mux),
        .GateMARMUX(gate_marmux),
        .GateMDR(gate_mdr),
        .GateALU(gate_alu),
        .GatePC(gate_pc),
        .MIO_EN(mio_en),
        .RW(rw),
        .ALUK(aluk)
    );

endmodule