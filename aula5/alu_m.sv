module alu_m #(parameter W = 1)
 (
  output logic [W-1:0] out, 
  output logic zero,
  input  logic [W-1:0] accum, 
  input  logic [W-1:0] data, 
  input  ex_type_pkg::opcode_e opcode, 
  input  logic clk      
 ) ;

  timeunit 1ns ;
  timeprecision 100ps ;

  import ex_type_pkg::* ;

  always_ff @(negedge clk)
    unique case ( opcode )
      ADD: 
	out <= accum + data;
      AND:
	out <= accum & data;
      XOR:
	out <= accum ^ data;
      LDA:
	out <= data;
      HLT,
      SKZ,
      JMP,
      STO:
	out <= accum ;
      default
	out <= 8'bx ;
    endcase

  always_comb 
    zero = ~(|accum) ;

endmodule : alu_m