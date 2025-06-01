module AND_GATE_PRO_N (input logic [3:0] A,B, output logic [3:0] C);
assign C = A&B;
endmodule

module INV_GATE_PRO_N (input logic [3:0] a, output logic [7:0] c);
assign c = {4'b0,~a};
endmodule

module NAND_GATE_PRO (input logic [3:0] A, B, output logic [7:0] C);
logic [3:0] Y;
AND_GATE_PRO_N andgate(A,B,Y);
INV_GATE_PRO_N invgate(Y,C);

assign C[4]=1'b0;
assign C[5]=1'b0;
assign C[6]=1'b0;
assign C[7]=1'b0;

endmodule

module tb_NAND_1();

logic [3:0] a,b; //inputs
logic [7:0] y; //outputs

//instantiate device under test
NAND_GATE_PRO dut(a,b,y);

//initial values
initial begin
    for (int i =0; i<16; i = i+1) begin
        a = i;
        for (int j = 0; j<16; j = j+1) begin
            b = j;
            #10;
        end
        #10;
    end
end

assign y[4]=1'b0;
assign y[5]=1'b0;
assign y[6]=1'b0;
assign y[7]=1'b0;

endmodule
