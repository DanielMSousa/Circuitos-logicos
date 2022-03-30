module gates #(parameter WIDTH = 32)(clk, entradaJ, entradaK, saidaQ, saidaQN);

input clk;
input [WIDTH-1:0]entradaJ, entradaK;

output logic[WIDTH:0] saidaQ, saidaQN;

always_ff @(posedge clk)
begin
	if ((entradaJ==4'b0000) && (entradaK == 4'b0000))
		begin
			saidaQ <= saidaQ;
			saidaQN <= saidaQN;
		end
	else if
	((entradaJ==4'b0001) && (entradaK == 4'b0000))
		begin
			saidaQ <= 4'b0001;
			saidaQN <= 4'b0000;
		end
	else if
	((entradaJ==4'b0000) && (entradaK == 4'b0001))
		begin
			saidaQ <= 4'b0000;
			saidaQN <= 4'b0001;
		end
	else
		begin
			saidaQ <= saidaQ;
			saidaQN <= saidaQN;
		end
		
end

endmodule: gates