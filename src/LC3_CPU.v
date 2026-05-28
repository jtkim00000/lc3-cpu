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
    wire [15:0] sext_5, sext_6, sext_9, sext_11;
    wire [15:0] zext;

    //Multiplexers
    wire [15:0] addr2mux_out, addr1mux_out, marmux_out, pcmux_out, sr2mux_out, miomux_out;
    wire [2:0] drmux_out, sr1mux_out;

    //Other Registers
    wire [15:0] pc_out;
    wire n_out, z_out, p_out;

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
    wire rw, mio_en,;
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

    




endmodule