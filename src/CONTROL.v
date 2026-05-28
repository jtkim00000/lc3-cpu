
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

    reg [5:0] STATE;

    // Microsequencer
    reg IRD;
    reg [2:0] COND;
    reg [5:0] J;

    always @(posedge CLK) begin
        if(IRD)
            STATE <= {2'b00, IR[15:12]};
        else begin
            STATE[5] <= J[5]; STATE[4] <= J[4]; STATE[3] <= J[3]; 
            STATE[2] <= J[2] | (BEN & (COND == 3'd2));
            STATE[1] <= J[1] | (R & (COND == 3'd1));
            STATE[0] <= J[0] | (IR[11] & ((COND == 3'd3)));
        end

    end

    // Microsequencer Outputs (J, COND, IRD)
    always @(*) begin
        case(STATE)

        endcase
    end

    // FSM Inputs (Datapath control signals)
    always @(*) begin
        case(STATE)

        endcase
    end

endmodule