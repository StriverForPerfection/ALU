module shift_Multiplier_4bit(
//Multiplicant 
input logic [3:0] a,

//power of 2 we multiply by 
input logic [3:0] b,
output logic [7:0] result);

always_comb begin
result = a <<< b[3:0];
end
endmodule

module shift_Divider_4bit(
//dividend
input logic [3:0] a,

//power of 2 we divide by 
input logic [3:0] b,
output logic [7:0]result);

assign result = a >>> b;

endmodule

module testMult();

logic [3:0] a, b;
logic [7:0] y;

shift_Multiplier_4bit multy(a, b, y);

initial begin

for (int i = 0; i <= 256; i+= 1) begin

{a,b} = i;

#50;

end
end
endmodule

module testDiv();

logic [3:0] a, b;
logic [7:0] y;

shift_Divider_4bit divvy(a, b, y);

initial begin

for (int i = 0; i <= 256; i+= 1) begin

{a,b} = i;

#50;

end
end
endmodule



