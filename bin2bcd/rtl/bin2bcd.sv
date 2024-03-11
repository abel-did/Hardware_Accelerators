module bin2bcd 
    #(parameter N = 8)
    (
        input logic [N-1:0] data_in,
        output logic [4*$ceil($log10($pow(2, N)))-1:0] data_out
    );

    localparam CONSTANT_SIZE_BCD        = 4*$ceil($log10($pow(2, N)));
    localparam CONSTANT_NUMBER_BLOCK    = $floor((CONSTANT_SIZE_BCD - 1)/4);
    localparam CONSTANT_SIZE_BIN_EXT    = (CONSTANT_NUMBER_BLOCK - 1)*4+N+1;
    localparam CONSTANT_DEPTH_C         = N - 4;

    logic [CONSTANT_SIZE_BIN_EXT+2:0] bin_extended;
    assign bin_extended = '0;

  

    always_comb begin
        logic [CONSTANT_SIZE_BIN_EXT+2:0] tmp;
    	for (integer i = 0; i < N; i = i + 1) begin
    		bin_extended[i] = data_in[i];
    	end
        tmp = bin_extended;

        for (integer d = 0; d <= CONSTANT_DEPTH_C; d = d + 1) 
            for (integer b = 0; b <= CONSTANT_NUMBER_BLOCK - 1; b = b + 1)
                if (tmp[CONSTANT_SIZE_BIN_EXT-1-(4*b)-d -: 4] > 4)
                    tmp[CONSTANT_SIZE_BIN_EXT-1-(4*b)-d -: 4] = tmp[CONSTANT_SIZE_BIN_EXT-1-(4*b)-d -: 4]+ 3;
        
        
        data_out = tmp[$size(bin_extended)-1:0];
    end

endmodule