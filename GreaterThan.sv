`include "EqualTo.sv"

module grtr_b_mod (input logic [3:0] a, b, output logic [7:0] y);

logic [3:0] d;
logic [7:0] Ycheck;

assign d = a - b;

comparator #(4)chckr(a, b, Ycheck);

always_comb begin
    // if (d[3] == 1) // negative (a < b)
    if (d[3]) 
        y = 8'b00000001; // y[6:0] = 1'b00; if d[3] == 1: Y[7] = 0 (not greater than; smaller than)
    else
	if(Ycheck[0] == 1)
        y = 8'b00000010; // Not greater than, but equal (output = 0 = not greater than); equal
	else if(Ycheck[0] == 0)
	y = 8'b00000100; // y[6:0] = 1'b00; d[3] == 0: y[7] = 1 (greater than)
end

endmodule

//test bench
module tst_b_grtr();
logic clk;
logic [3:0] a,b;
reg [7:0] y;

grtr_b_mod L(a,b, y);
always begin
clk = 1; #50; 
clk = 0; #50;
end

initial begin
    for (int i=0; i < 256; i = i+1) begin
        {a, b} = i; 
	#50;
    end
	$stop;
end

endmodule
