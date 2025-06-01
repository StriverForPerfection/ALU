module xnor_b (input logic a, b, output logic y);

assign y = ~(a ^ b);
endmodule
module xnor_mod (input logic [3:0] a, b, output logic [3:0] y);
xnor_b xnorl (a[0], b[0], y[0]);
xnor_b xnor2 (a[1], b[1], y[1]);
xnor_b xnor3 (a[2], b[2], y[2]);
xnor_b xnor4 (a[3], b[3], y[3]);
endmodule
//test bench
module tst_b_xnor();
logic [3:0] a,b;
reg [3:0] y;
xnor_mod L (a, b, y);
initial begin
for (int i=0; i<16; i=i+1) begin
 {a} = i;

#100;
for (int c= 0; c <16; c = c+1) begin
{b} = c;
#100;
end
end
end
endmodule
