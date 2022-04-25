include "ex_type_pkg.sv";
import ex_type_pkg::*;

module alu_m();

	typedef enum logic [2:0] 
	{ HLT, SKZ, ADD, 
	AND, XOR, LDA, STO, JMP } opcode_e ;

	input logic accum[7:0];
	input logic data[7:0];
	input logic opcode;
	input logic clk;
	output logic out;
	logic zero;

	always_comb
		if(accum == 3'b000)
			begin
				assign zero = 3'b001;
			end
		else
			assign zero = 3'b000;


	always_ff @(negedge clk)
	begin
		unique case(opcode)
			3'b000:
				out = accum ; 
			3'b001:
				out = accum ;
			3'b010:
				out = data + accum ;
			3'b011:
				out = data & accum;
			3'b100:
				out = data ^ accum;
			3'b101:
				out = data;
			4'b110:
				out = accum ;
			4'b111:
				out = accum ;
			default:
				out = accum ; 
		endcase
	end

endmodule: alu_m