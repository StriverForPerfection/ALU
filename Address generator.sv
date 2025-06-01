module d_FF(input logic d, clk, reset, output reg Q, output Q_bar);

always_ff @(posedge clk) begin

if (reset)

Q <= 0;

else

Q <= d;

end

assign Q_bar = ~Q;

endmodule

module mux(input logic a, b, selector, clk, output logic u);

always @ (posedge clk) begin

if (~selector)

u = a;

else

u = b;

end

endmodule

module AddressGen(input clk, reset, op_done, output [2:0] address);

logic [2:0] A, A_bar; //flip flops' current states

// W signifies a minterm. Z signifies one input to a flip flop (or ORing of minterms).

and a1(W1, A[2], A[0]);
and a2(W2, A[1], ~A[0]);

or r1(Z2, W1, W2); 	//For flip flop of A2 if operation done is true.

and a3(W3, ~A[2], A[0]);

or r2(Z1, W3, W2); 	//For flip flop of A1 if operation done is true.

and a4(W4, ~A[2], ~A[1]);
and a5(W5, A[2], A[1]);

or r3(Z0, W4, W5);	//For flip flop of A0 if operation done is true.

logic [2:0] u; 		//Outputs of muxes.

mux m2(A[2], Z2, op_done, clk, u[2]);
mux m1(A[1], Z1, op_done, clk, u[1]);
mux m0(A[0], Z0, op_done, clk, u[0]);

d_FF bit2(u[2], clk, reset, A[2], A_bar[2]);
d_FF bit1(u[1], clk, reset, A[1], A_bar[1]);
d_FF bit0(u[0], clk, reset, A[0], A_bar[0]);

assign address = A;

endmodule

module testbenchMUX();

logic a, b, selector, clk, u;

mux m5(a, b, selector, clk, u);

initial begin
clk = 1; #50; clk = 0; #50;
a = 0; b = 1; selector = 0; #50
selector = 1;

end

endmodule

module testbenchAddressGen();

logic clk, reset, p;
logic [2:0] ad;

AddressGen AG(clk, reset, p, ad);

initial begin

clk = 0; 

forever #25 clk = ~clk;
end

initial begin

p = 1;
reset = 1; #25; // #24 doesn't work, but #25 does. Beware race conditions and synchronization.
@(posedge clk);

reset = 0;

end

endmodule