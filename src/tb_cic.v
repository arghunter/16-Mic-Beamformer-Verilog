module testbench;

// Clock and reset signals
reg clk;
reg dec_clk;
reg reset;

// Input signal
reg [15:0]input_signal;

// Output signal (if any, replace 'output_signal' with the actual output of your DUT)
wire  output_signal;

// Instantiate the DUT (Device Under Test)
top_module u_top_module (
    .clk(clk),
    .dec_clk(dec_clk),
    .rst(reset),
    .in(input_signal),
    .out(output_signal) 
);

// Clock generation for clk (3.072 MHz)
initial begin
    clk = 0;
    forever #162.76 clk = ~clk; // Half period = 1 / (2 * 3.072 MHz) = 162.76 ns
end

// Clock generation for dec_clk (48 kHz)
initial begin
    dec_clk = 0;
    forever #10416.67 dec_clk = ~dec_clk; // Half period = 1 / (2 * 48 kHz) = 10416.67 ns
end
integer i;
// Initial block for reset and input signal generation
initial begin
    // Initialize reset
    reset = 1;
    #1000;
    reset = 0;

    // Read input data from file and apply it to input_signal
    $readmemb("pdm_sine_wave_2_binary.txt", input_data);

    
    for (i = 0; i < 262144; i = i + 1) begin
        input_signal[0] = input_data[i]; // #NotScuffed
        input_signal[1] = input_data[i];
        input_signal[2] = input_data[i];
        input_signal[3] = input_data[i];
        input_signal[4] = input_data[i];
        input_signal[5] = input_data[i];
        input_signal[6] = input_data[i];
        input_signal[7] = input_data[i];
        input_signal[8] = input_data[i];
        input_signal[9] = input_data[i];
        input_signal[10] = input_data[i];
        input_signal[11] = input_data[i];
        input_signal[12] = input_data[i];
        input_signal[13] = input_data[i];
        input_signal[14] = input_data[i];
        input_signal[15] = input_data[i];
        @(posedge clk); // Apply input at the rising edge of clk
    end

    // Finish simulation
    #1000;
    $finish;
end
integer infile, outfile, c;
// Convert input data from -1 and 1 to 0 and 1
initial begin
    
    infile = $fopen("pdm_sine_wave_2.txt", "r");
    outfile = $fopen("pdm_sine_wave_2_binary.txt", "w");
    while (!$feof(infile)) begin
        c = $fgetc(infile);
        if (c == "-")
            $fwrite(outfile, "0\n");
        else if (c == "1")
            $fwrite(outfile, "1\n");
    end
    $fclose(infile);
    $fclose(outfile);
end
initial begin
        $dumpfile("tb_cic.vcd");  // Name of the VCD file
        $dumpvars(0, testbench);     // Dump all variables in the tb_i2s_bus module
    end

// Memory to store input data
reg [0:0] input_data [0:262143]; // Adjust the size based on your input data length
// integer outsigfile;
// initial begin
//     outsigfile = $fopen("output_changes.txt", "w");
//     if (outsigfile == 0) begin
//         $display("Failed to open file for writing");
//         $finish;
//     end
// end

// // Monitor output signal and log changes
// always @(posedge clk) begin
//     if ($time > 1000 && $time < $time + 162.76) begin // Skip logging during reset
//         if (output_signal !== prev_output_signal) begin
//             $fwrite(outsigfile, output_signal+"\n");
//             prev_output_signal = output_signal;
//         end
//     end
// end

// // Variable to store previous output signal value
// reg prev_output_signal;

// initial begin
//     prev_output_signal = 1'bx; // Initialize to an unknown value
// end

// // Close the file at the end of simulation
// initial begin
//     #100000; // Adjust the simulation end time as needed
//     $fclose(outsigfile);
// end
endmodule