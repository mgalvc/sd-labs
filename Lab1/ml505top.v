// UEFS TEC 499
// Lab 0, 2016.1

module ml505top (
   input  [3:0] KEY,
   input  clock_50MHz,
   output [3:0] LED
);

/* Trick to deal with the LED matrix. In this example only the first row (0)
*  is used by disabling rows 1 to 7. Considering that LEDM_C logic is
*  inverted, we have created a internal signal to not interfeer the implementation */
wire [4:0] LED_inv;

assign LED[1:0] = ~LED_inv[1:0]; // invert LED output

//and (LED_inv[0], ~KEY[0], ~KEY[1]);



/* This shows an example of module instantiation (you will need to
*  implement Mux2_1 for this to function). If you have correctly 
*  implemented Mux2_1, you should be able to use switch 'SW2' to 
*  select whether the value of switch 'SW0' or 'SW1' is displayed 
*  on LED (R0,C1). */
/*Mux2_1 gpio_mux(
   .A(~KEY[0]),
   .B(~KEY[1]),
   .SEL(~KEY[2]),
   .OUT(LED_inv[1])
);*/

/* Next, implement a full adder in FA.v. Then, instantiate the FA module
*  below such that the inputs to the adder are GPIO DIP switches 0-2 
*  (recall the number is off by one), the sum is displayed on LED (R0,C2), 
*  and the carry is displayed on LED (R0,C3). Then delete the specified 
*  line once your done */

FA fa(
	.A(~KEY[0]),
   .B(~KEY[1]),
	.Cin(~KEY[2]),
	.Sum(LED_inv[0]),
	.Cout(LED_inv[1])
);

//assign LEDM_C_inv [3:2] = 2'b0;  // delete this once you instantiate your full adder

/* Now for the adder instantiation and testing
*  The Adder module is already instantiated for you.
*  A working solution will light up green on RGB LED.
*  A failing solution will light up red on RGB LED.
*/

parameter Width   = 8;
localparam CWidth = Width*2;

wire                Clock;
wire                Reset;
reg [CWidth-1:0]    Count;
wire [Width-1:0]    CUTResult;
wire [Width-1:0]    ExpectedResult;
wire                CUTCout;
wire                ExpectedCout;	

assign Clock = clock_50MHz;
assign Reset = KEY[3] | KEY[2] | KEY[1] | KEY[0];

// Circuit Under Test
Adder #(.Width(Width)) CUT (
.A(Count[CWidth-1:Width]),
.B(Count[Width-1:0]),
.Result(CUTResult),
.Cout(CUTCout)
);

BehavioralAdder #(.Width(Width)) Solution (
.A(Count[CWidth-1:Width]),
.B(Count[Width-1:0]),
.Result(ExpectedResult),
.Cout(ExpectedCout)
);

always @(posedge Clock) begin
if(Reset) Count <= {CWidth{1'b0}};
else if ((Count != {CWidth{1'b1}}) && LED[2]) Count <= Count + 1'b1;
end

//LED[3] will light if your Adder.v works correctly
assign LED[2] = CUTResult == ExpectedResult && CUTCout == ExpectedCout;

//LED[4] will light up red if you Adder is wrong
assign LED[3] = {~LED[2]};
endmodule
