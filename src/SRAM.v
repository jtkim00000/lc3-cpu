module sram (
    input cs,   //MIO.EN
    input rw,   // R'/W
    input [15:0] addr,
    input [15:0] data_in,
    output r, //ready signal
    output [15:0] data_out
); // 64k x 16 RAM



endmodule