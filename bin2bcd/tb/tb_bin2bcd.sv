module testbench;

    localparam N = 8;

    logic [N-1:0] data_in;
    logic [4*$ceil($log10($pow(2, N)))-1:0] data_out;

    bin2bcd #(.N(N)) dut (
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        data_in = 0;
        repeat ($pow(2,N)) begin
            #10; // Wait for some time before changing the input
            data_in = data_in + 1; 
        end
        $finish;
    end

endmodule
