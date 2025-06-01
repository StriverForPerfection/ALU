`include "ArithmeticLogicUnit.sv"
`include "AddressGenerator.sv"

module ALU_addressGen(input logic clk, reset, En, input reg [3:0] A, B, input logic[3:0] OPcode,
	  output logic [7:0] ResultData, output logic gt, st, eq, v, output logic [2:0] WriteAddress); //Systems yields 4 flags, a result and address.

logic [3:0] a, b;
//logic g, s, e, v, 
logic OPdone, OPsmooth;

//logic [7:0] ResultData; //You pass inputs from the outside (inputs declared in the module definition) to inside the module.
			// To pass outputs, instantiate wires inside the module that convey the final results made inside the module to its
			// outputs or output "ports" ot "placeholders." Or simply, the output vectors declared in the module declaration 
			// are themselves wires.

ALU alwafy(clk, a, b, OPcode, ResultData, gt, st, eq, v, OPdone);
AddressGen adrian(clk, reset, OPsmooth, WriteAddress);

always_comb begin
if (reset) begin 	//Everything is zeroed at reset.

a = 4'b0000;
b = 4'b0000;
OPdone <= 0;
ResultData = 8'b00000000;
gt = 0; st = 0; eq = 0; v = 0;
WriteAddress = 000;

end else if (En) begin

a = A; // a and b displayed are that WILL BE entered inside the ALU in the next clock cycle. That's why their effect is only seen on the
b = B; // next rising edge.
OPsmooth <= OPdone;
end else begin
a = 4'bzzzz;
b = 4'bzzzz;
OPsmooth <= 0;
WriteAddress = 3'bzzz;
end
end
endmodule

module testALUaddress();

logic clk, reset, en;
reg[3:0] a, b;
logic [3:0] OPcode;
logic [7:0] ResultData;
logic [2:0] Waddress;
logic gt, st, eq, v;

ALU_addressGen aladin(clk, reset, en, a, b, OPcode, ResultData, gt, st, eq, v, Waddress);

always begin
clk = 1; #25;
clk = 0; #25;
end

initial begin
reset = 1; #50;
reset = 0;

en = 1;

for (int i = 0; i< 10; i += 1) begin
	OPcode = i;
	for (int j = 0; j< 256; j += 1) begin
		{a, b} = j; #50;
		end
end
$stop;

end

endmodule

module ALUaddressTest2();

logic clk, reset, en, gt, st, eq, v;
logic [3:0] A, B, opcode;
logic [7:0] result;
logic[3:0]flags;
logic[2:0] address;
logic [11:0] result_flags_exp;
logic[10000:0] testvectors [11:0];

logic [0:10000] vectornum, errors;

ALU_addressGen aldorado(clk, reset, en, A, B, opcode, result, gt, st, eq, v, address);

initial begin

vectornum = 0; errors = 0;

$readmemb("", testvectors);

reset = 1; #5; reset = 0; #5;

end

always begin

clk = 1; #50; clk = 0; #50;

end

always @ (posedge clk) begin

result_flags_exp = testvectors[vectornum];

end

always @ (negedge clk) begin

if(~reset) begin

if ((result !== result_flags_exp[7:0]) || (flags[3] !== gt) || (flags[2] !== st) ||
	 (flags [1] !== eq) || (flags[0] !== v)) begin

$display ("Error on %b", result);
$display ("Expected %b but received %b %b", result_flags_exp, outputs, flags);

errors += 1;
end

vectornum += 1;
end

if (vectornum > 10000) begin

$display("Test finished successfully with %d errors", errors);
$stop;
end

end

endmodule
