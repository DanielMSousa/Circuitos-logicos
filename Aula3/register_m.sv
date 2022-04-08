module register_m
#(
  parameter int unsigned W = 1 // Width
 )
 ( 
  output logic [W-1:0] q    , // register data output
  input  logic [W-1:0] d    , // data input
  input  logic         enb  , // enable
  input  logic         rst_ , // reset (asynch low)
  input  logic         clk    // clock
 ) ;

  timeunit        1ns ;
  timeprecision 100ps ;

  always_ff @....


....
endmodule : register_m
