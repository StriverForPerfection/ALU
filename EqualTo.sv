module comparator #(parameter n)(
    input wire [n-1:0] A,
    input wire [n-1:0] B,
    output wire [2*n-1:0] equal
);

assign equal = & (~(A ^ B));

endmodule

module comparator_tb;

    // Inputs
    reg [3:0] A, B;

    // Output
    wire equal;

    // Instantiate the Unit Under Test (UUT)
    comparator #(4) uut (
        .A(A),
        .B(B),
        .equal(equal)
    );

    // Testbench Logic
    initial begin
        // Initialize Inputs
        A = 4'b0000;
        B = 4'b0000;

        // Add stimulus here

        for (int i = 0; i < 256; i += 1) begin
		{A,B} = i; 
		#50;
	end
    end

endmodule
