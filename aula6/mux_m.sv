module  mux_m#(WIDTH=8)(
output logic [WIDTH-1:0]  out,
input logic [WIDTH-1:0]  data_a,
input logic [WIDTH-1:0]  data_b,  
input logic sel_a        
); 

assign out = (sel_a) ? data_a : data_b;

endmodule: mux_m
