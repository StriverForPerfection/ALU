`include "ArithmeticOperationsUnit.sv"
`include "LogicalOperationsUnit.sv"

module ALU(input logic clk, input logic [3:0] A, B, OPcode,
	   output logic [7:0] ResultData, output logic gt, st, eq, overflow, OperationsDone); //ALU outputs 5 flags and 1 result

logic [7:0] Ylogic, Yarithmetic;


AOU Alen(OPcode, A, B, Yarithmetic, overflow);
LOU Larry(OPcode, A, B, Ylogic);

always_comb begin


case(OPcode)

4'b0000: begin
ResultData <= Ylogic;	//NAND
OperationsDone = 1;
end

4'b0001: begin
ResultData <= Ylogic; 	//NOR
OperationsDone = 1;
end

4'b0010: begin
ResultData <= Ylogic; 	//XNOR
OperationsDone = 1;
end

4'b0011: begin
ResultData <= Ylogic; 	//GreaterThan

if (Ylogic[2] == 1) begin 	// One-hot encoding gives a greater than flag = 1 if the third bit = 1;
gt = 1;
st = 0;
eq = 0;
end else begin
gt = 0;
end

OperationsDone = 1;
end

4'b0100: begin
ResultData <= Ylogic; 	//SmallerThan

if (Ylogic[0] == 1) begin 	// One-hot encoding gives a smaller than flag = 1 if the first bit = 1;
st = 1;
gt = 0;
eq = 0;
end else begin
st = 0;
end

OperationsDone = 1;
end

4'b0101: begin
ResultData <= Ylogic; 	//Equal

if (Ylogic[1] == 1) begin 	// One-hot encoding gives an equal flag = 1 if the second bit = 1;
eq = 1;
gt = 0;
st = 0;
end else begin
eq = 0;
end

OperationsDone = 1;
end

4'b0110: begin
ResultData <= Yarithmetic; //Addition

OperationsDone = 1;
end

4'b0111: begin
ResultData <= Yarithmetic; //Subtraction

OperationsDone = 1;
end

4'b1000: begin
ResultData <= Yarithmetic; //Multiplication

OperationsDone = 1;
end

4'b1001: begin
ResultData <= Yarithmetic; //Division

OperationsDone = 1;
end

default: 
OperationsDone = 0;

endcase

end
endmodule 

module testALU();

logic clk;
reg[3:0] a, b;
logic [3:0] OPcode;
logic [7:0] ResultData;
logic gt, st, eq, v, OPdone;

ALU alchemy(clk, a, b, OPcode, ResultData, gt, st, eq, v, OPdone);

always begin
clk = 1; #25;
clk = 0; #25;
end

initial begin
for (int i = 0; i< 10; i += 1) begin
	OPcode = i;
	for (int j = 0; j< 256; j += 1) begin
		{a, b} = j; #50;
		end
end
$stop;

end

endmodule
