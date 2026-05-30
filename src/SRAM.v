module sram (
    input clk,
    input cs,   //MIO.EN
    input rw,   // R'/W
    input [15:0] addr,
    input [15:0] data_in,
    output reg ready, //ready signal
    output reg [15:0] data_out
); // 64k x 16 RAM
    reg [1:0] counter;
    reg [15:0] mem [65536:0];

    initial begin
        $readmemh("test_program.hex", mem, 16'h3000);
    end

    //counter for ready signal is not needed but good practice
    always @(posedge clk) begin
        if(cs) begin
            if(ready) begin
                //wait till cs is done so counter doesn't keep going
            end
            else if(counter == 2'b10) begin
                counter <= 2'b00;
                ready <= 1'b1;
            end
            else begin
                counter <= counter + 1;
                ready <= 1'b0;
            end
        end
        else begin
            counter <= 2'b0;
            ready <= 1'b0;
        end
    end

    always @(posedge clk) begin
        if(cs) begin
            if(ready && rw) begin //write
                mem[addr] <= data_in;
            end
        end
    end

    always @(*) begin //read (combinational)
        if(cs && ~rw)
            data_out = mem[addr];
        else
            data_out = 16'h0000;
    end
endmodule