/*
* Author : Abel DIDOUH
* Description : Binary to Binary Coded Decimal
*/
module bin2bcd 
    #(parameter N = 5)
    (
        input [N-1:0] data_in,
        output reg [int'(4*$ceil($log10($pow(2, N)))-1)+4:0] data_out
    );

    localparam CONSTANT_SIZE_BCD        = int'(4*$ceil($log10($pow(2, N))));
    localparam CONSTANT_NUMBER_BLOCK    = int'($floor((CONSTANT_SIZE_BCD - 1)/4));
    localparam CONSTANT_SIZE_BIN_EXT    = (CONSTANT_NUMBER_BLOCK - 1)*4+N+1;
    localparam CONSTANT_DEPTH_C         = N - 4;

    logic [CONSTANT_SIZE_BIN_EXT+2:0] bin_extended;
    assign bin_extended = '0;

    always @(data_in) begin
        for(integer i = 0; i <= CONSTANT_SIZE_BCD; i = i+1) data_out = 0;    
        data_out[N-1:0] = data_in;
        for (integer d = 0; d <= CONSTANT_DEPTH_C; d = d + 1) 
            for (integer b = 0; b <= CONSTANT_NUMBER_BLOCK - 1; b = b + 1)
                if (data_out[CONSTANT_SIZE_BIN_EXT-1-(4*b)-d -: 4] > 4)
                    data_out[CONSTANT_SIZE_BIN_EXT-1-(4*b)-d -: 4] = data_out[CONSTANT_SIZE_BIN_EXT-1-(4*b)-d -: 4] + 3;
        end
endmodule


