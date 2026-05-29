
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
        // Default/Unsed States
        IRD = 1'b0;
        COND = 3'b000;
        J = 6'b010010;

        case(STATE)
            6'd0:  begin IRD = 1'b0; COND = 3'b010; J = 6'b010010; end
            6'd1:  begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd2:  begin IRD = 1'b0; COND = 3'b000; J = 6'b011001; end
            6'd3:  begin IRD = 1'b0; COND = 3'b000; J = 6'b010111; end
            6'd4:  begin IRD = 1'b0; COND = 3'b011; J = 6'b010100; end
            6'd5:  begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd6:  begin IRD = 1'b0; COND = 3'b000; J = 6'b011001; end
            6'd7:  begin IRD = 1'b0; COND = 3'b000; J = 6'b010111; end
            6'd8:  begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd9:  begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd10: begin IRD = 1'b0; COND = 3'b000; J = 6'b011000; end
            6'd11: begin IRD = 1'b0; COND = 3'b000; J = 6'b011101; end
            6'd12: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd13: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd14: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd15: begin IRD = 1'b0; COND = 3'b000; J = 6'b011100; end
            6'd16: begin IRD = 1'b0; COND = 3'b001; J = 6'b010000; end
            6'd17: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd18: begin IRD = 1'b0; COND = 3'b101; J = 6'b100001; end
            6'd19: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd20: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd21: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd22: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd23: begin IRD = 1'b0; COND = 3'b000; J = 6'b010000; end
            6'd24: begin IRD = 1'b0; COND = 3'b001; J = 6'b011000; end
            6'd25: begin IRD = 1'b0; COND = 3'b001; J = 6'b011001; end
            6'd26: begin IRD = 1'b0; COND = 3'b000; J = 6'b011001; end
            6'd27: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd28: begin IRD = 1'b0; COND = 3'b001; J = 6'b011100; end
            6'd29: begin IRD = 1'b0; COND = 3'b001; J = 6'b011101; end
            6'd30: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd31: begin IRD = 1'b0; COND = 3'b000; J = 6'b010111; end
            6'd32: begin IRD = 1'b1; COND = 3'bx;   J = 6'bx;      end
            6'd33: begin IRD = 1'b0; COND = 3'b001; J = 6'b100001; end
            6'd34: begin IRD = 1'b0; COND = 3'b000; J = 6'b010010; end
            6'd35: begin IRD = 1'b0; COND = 3'b000; J = 6'b100000; end
            default: begin 
                IRD = 1'b0; 
                COND = 3'b000; 
                J = 6'b010010; 
            end
        endcase
    end

    // FSM Inputs (Datapath control signals)
    always @(*) begin
        case(STATE)

        default: begin
            LD_MAR=0; LD_MDR=0; LD_IR=0; LD_PC=0;
            LD_REG=0; LD_BEN=0; LD_CC=0;
            GateMARMUX=0; GateMDR=0; GateALU=0; GatePC=0;
            MARMUX=0; ADDR1MUX=0; ADDR2MUX=0;
            PCMUX=0; SR1MUX=0; DRMUX=0; ALUK=0;
            MIO_EN=0; RW=0;
            J=6'd18; COND=3'b000; IRD=0;
        end

        endcase
    end

endmodule