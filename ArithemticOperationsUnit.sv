`include "subtraction.sv"
`include "Multiplier_Divider.sv"
module AOU(input logic clk, [3:0] OP_code, A, B, output logic [7:0] Y, v);

//logic [3:0] a, b;
logic [7:0] Yadd, Ysub, Ymult, Ydiv;

four_bit_subtraction add(A, B, OP_code[0],OP_code[0], Yadd);
four_bit_subtraction sub(A, B,OP_code[0],OP_code[0], Ysub);
Multiplier_4bit mult(A, B, Ymult);
divider_4bit div(A, B, Ydiv);

always@ (posedge clk) begin

case (OP_code) 

4'b0110: begin Y <= Yadd; //Addition

if(A[3] == B[3] && A[3] != Yadd[3]) begin //Check for overflow in addition
v = 1;
end else begin
v = 0;
end
end

4'b0111: begin Y <= Ysub; //Subtraction
if(A[3] != B[3] && A[3] != Ysub[3]) begin //Check for overflow in subtraction
v = 1;
end else begin
v = 0;
end
end
4'b1000: Y <= Ymult;
4'b1001: Y <= Ydiv;

endcase

end

endmodule

module testAOU();
logic[3:0] k, l, opc;
logic [7:0] x;
logic clk, v;

AOU Andy(clk, opc, k, l, x, v);

always begin
clk = 1; #25; 
clk = 0; #25;
end

initial begin
opc = 4'b0110;
#49; //IMPORTANT BREAKTHROUGH: now, the outputs are stable 1 ps before the clock edge. We've overcome the annoying output shift.
for(int w = 0; w <256; w = w + 1) begin
	{k, l} = w;
#50; //clk must be at least 1 picosecond larger than this.

end
opc = 4'b0111;
for(int w = 0; w <256; w = w + 1) begin
	{k, l} = w;
#50; //clk must be at least 1 picosecond larger than this.

end
opc = 4'b1000;
for(int w = 0; w <256; w = w + 1) begin
	{k, l} = w;
#50; //clk must be at least 1 picosecond larger than this.

end
opc = 4'b1001;
for(int w = 0; w <256; w = w + 1) begin
	{k, l} = w;
#50; //clk must be at least 1 picosecond larger than this.

end
$stop;
end
endmodule

