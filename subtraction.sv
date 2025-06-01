module four_bit_subtraction (
    input [3:0] A, B,      
    input Carryin,
    input Subtract,        
    output [3:0] Sum
//,      output CarryOut        
    //,output z,               // Zero flag (if the sum is zero)
    //output v                // Overflow flag
);

    wire [3:0] B_xor;      
    wire [3:0] Carry;    

 
    assign B_xor = Subtract ? ~B : B; 

 
    full_adder FA0 (A[0], B_xor[0], Carryin, Sum[0], Carry[0]);
    full_adder FA1 (A[1], B_xor[1], Carry[0], Sum[1], Carry[1]);
    full_adder FA2 (A[2], B_xor[2], Carry[1], Sum[2], Carry[2]);
    full_adder FA3 (A[3], B_xor[3], Carry[2], Sum[3], Carry[3]);

    assign CarryOut = Carry[3];

   
    //assign v = Carry[2] ^ Carry[3];


    //assign z = ~|Sum;  

endmodule
