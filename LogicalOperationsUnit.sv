`include "NAND.sv"
`include "NOR.sv"
`include "XNOR.sv"
`include "GreaterThan.sv"

module LOU(input logic [3:0] OP_code, A, B, output logic [7:0] Y);

//logic [3:0] a, b;
logic [7:0] Ynand, Ynor, Yxnor, Ygreater;


NAND_GATE_PRO n0(A, B, Ynand);
nor_mod n1(A, B, Ynor);
xnor_mod n3(A, B, Yxnor);

//smt_mod st(A, B, Ysmaller);
grtr_b_mod gt(A, B, Ygreater);
//comparator #(4)et(A, B, Yequal);

always_comb begin

case (OP_code) 

4'b0000: Y = Ynand;
4'b0001: Y = Ynor;
4'b0010: Y = Yxnor;
4'b0011: Y = Ygreater; // Greater than
4'b0100: Y = Ygreater; // Smaller than
4'b0101: Y = Ygreater; // Equal to

endcase

end
endmodule

module testLOU();
logic[3:0] k, l, opc;
logic [7:0] x;


LOU larry(opc, k, l, x);

assign k = 4'b1010;
assign l = 4'b1001;

initial begin
for(int w = 0; w <7; w = w + 1) begin

opc = w; 
#49; //clk must be at least 1 picosecond larger than this.

end
end
endmodule
	
