//-----------------------------------------------------------------------------
// UEFS TEC 499
// Lab 0, 2016.1
// Module: Mux2_1.v
// Desc: OUT = A*(~SEL) + B*(SEL)
//-----------------------------------------------------------------------------
module Mux2_1(
    input A,
    input B,
    input SEL,
    output OUT
);
   
	wire temp_1, temp_2;
	
	and (temp_1, B, SEL);
	and (temp_2, A, ~SEL);
	
	or (OUT, temp_1, temp_2);   
endmodule
