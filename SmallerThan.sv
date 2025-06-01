module smt_mod (input logic [3:0] a, b, output logic [7:0] y);

logic [7:0] d;
logic bout;

sub_mod4 sub (a, b, d, bout);

always_comb begin
    if (bout == 0 && b != a) begin
        // Negative (a > b)
        y = 8'b00000000;
    end
    else if (bout == 1) begin
        // Positive (a <= b)
        y = 8'b10000000; // if a = b, result will be don't care
    end
end

endmodule

// test bench
module tst_sml();

logic [3:0] a, b;
reg [7:0] y;

smt_mod L(a, b, y);

initial begin
    for (int i = 0; i < 16; i = i + 1) begin
        a = i;
        for (int j = 0; j < 16; j = j + 1) begin
            	b = j;
		#100;
        end
	#100;
    end
end

endmodule
