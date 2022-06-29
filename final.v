module mul32ff #(parameter W = 31)
  ( input clk,
   input reset,
   input [W:0] x, y,
   output reg [W:0] z1 );
  
  reg [W:0] c1; // {c,z} = x*y
  always @(posedge clk) begin
    if (reset)
      z1<=0;
    else 
     {c1,z1} <= x*y;
  end
    
endmodule 

// A simple calculation for Horner's algorithm in verilog...

module add32ff 
  (input clk,
   input reset,
   input [31:0] x, y,
   output reg[31:0] z);
  
  //reg cout;
  always @(posedge clk) begin
    if (reset) begin
      z <= 0;
      //cout <= 0;
    end
    
    else begin
      z <= x+y;
    end 
  end
endmodule 


module for_horner
  (input clk,
   input reset,
   input [31:0] x1, x2, 
   input [31:0] y1, y2,
   output wire [31:0] z);
  
  wire [31:0] z1, z2;
  
  mul32ff u1(clk,reset,x1,y1,z1);
  mul32ff u2(clk,reset,x2,y2,z2);
  add32ff u3(clk,reset,z1,z2,z);
  
  
endmodule



// the testbench....preferably try this on icarus verilog


`timescale 1ns / 1ns
`include "dav.v"

module f_adder_test();
  
 reg clk, reset;
  //reg [31:0]  x, y,c,z1;
  reg [31:0] x1,x2,y1,y2,z1,c,z2;
  //wire [31:0] z1,z2;
  wire [31:0] z;

  
 // initial begin
  // clk = 0;
  // reset = 1;
  //end
  
  //instantiate the clk and reset;
  //ins i(clk, reset);
  //test test(i);
  
  //add32ff a1(clk, reset, x, y, cin, cout, z2);
  //mul32ff a1(clk, reset, x, y, c, z1);
  for_horner a1(.clk(clk),
                .reset(reset),
                .x1(x1),
                .x2(x2),
                .y1(y1),
                .y2(y2),
               // .z1(z1),
               // .z2(z2),
                .z(z));
  
  initial begin
    clk = 0;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
    #1 clk = ~clk;
  end
  initial
  	begin
	 $dumpfile("dav_tb.vcd");
      //$dumpfile("systolic_array1.vcd");
    $dumpvars(0,f_adder_test);
      //$dumpvars(1,systolic_array);

      
     reset = 1;
      x1=4'h0;   x2=4'h0; y1=4'h0; y2=4'h0; z1=4'h0; z2=4'h0;
     //x=4'h0;   y=4'h0;   cin=4'h0;
      #2 reset = 0;
   //   #5 i.x = 4'h1; i.y = 4'h1; i.cin=4'h1;
     // #5 x = 4'ha; y = 4'h3; cin=4'h0;
      #5 x1 = 4'ha; x2=4'h1; y1 = 4'h9; y2=4'h1; z1=4'h1; z2=4'h1;
      //#2 x = 4'h1; y = 4'ha; cin = 4'ha;
     // #20 i.x = 0; i.y = 0; i.cin = 0;


	end

endmodule
