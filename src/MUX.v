/* 
    Multiplexer

    Standard multiplexer design that had modular data input width, and number of inputs. 

    Select bits choose the output from a series of inputs.

    Inputs should be concatnated together into one vector
*/

module mux #(
    parameter DATA_WIDTH = 16,
    parameter INPUT_WIDTH = 2,
    parameter SELECT_BITS = 1
) (
    input [(INPUT_WIDTH*DATA_WIDTH)-1:0] data_in,
    input [SELECT_BITS-1:0] sel,
    output [DATA_WIDTH-1:0] out
);

    assign out = data_in[sel*(DATA_WIDTH) +: DATA_WIDTH];

endmodule