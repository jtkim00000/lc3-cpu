


//all caps is used for easier wiring of datapath
module control (
    input R,
    input BEN,
    input [15:0] IR,
    input CLK,
    // Register LD signals
    output LD_MAR,
    output LD_MDR,
    output LD_IR,
    output LD_PC,
    output LD_REG,
    output LD_BEN,
    output LD_CC,
    // MUX select bits
    output MARMUX,
    output ADDR1MUX,
    output [1:0] ADDR2MUX,
    output [1:0] PCMUX,
    output [1:0] SR1MUX,
    output SR2MUX,
    output [1:0] DR,
    // Tri-state buffers gate for bus
    output GateMARMUX,
    output GateMDR,
    output GateALU,
    output GatePC,
    // Memory
    output MIO_EN,
    output RW,
    // ALU select bits
    output [1:0] ALUK
);



endmodule