//-----------------------------------------------------------------------------
// UEFS TEC 499
// Lab 0, 2016.1
// Module: FA.v
// Desc: 1-bit Full Adder
//       You may only use structural verilog in this module.       
//-----------------------------------------------------------------------------
module FA(
    input A, B, Cin,
    output Sum, Cout
);
   wire temp_1, temp_2, temp_3;
	
	xor (temp_1, A, B);
	xor (Sum, temp_1, Cin);
	
	and (temp_2, Cin, temp_1);
	and (temp_3, A, B);
	
	or (Cout, temp_2, temp_3);
endmodule

