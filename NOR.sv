module nor_b (input logic a, b, output logic y);

assign y = ~(a | b);

endmodule

module nor_mod (input logic [3:0] a,b, output logic [3:0] y);

nor_b nor1 (a[0], b[0], y[0]);
nor_b nor2 (a[1], b[1], y[1]);
nor_b nor3 (a[2], b[2], y[2]);
nor_b nor4 (a[3], b[3], y[3]);

endmodule

//test bench
module tst_b_nor();

logic [3:0] a,b;
reg [3:0] y;

nor_mod dut (a,b,y);

initial begin

    for (int i=0; i < 256; i = i+1) begin

        {a, b} = i;

        #100;
    end
end

endmodule






