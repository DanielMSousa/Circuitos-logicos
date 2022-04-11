module symbol_to_chip_tb;               

timeunit 1ns;
timeprecision 1ns;

//outputs
logic [31:0] chip_value_LSBs;
logic [31:0] chip_value_MSBs;

//inputs
logic [3:0] LSBs;
logic [3:0] MSBs;
logic pclk;
logic RESET_n;
logic [3:0]random_data;
logic pValid;
logic pReady;

//essas são as entradas
symbol_to_chip sc1 (.pclk(pclk),.RESET_n(RESET_n), .LSBs(LSBs), .MSBs(MSBs), .chip_value_LSBs(chip_value_LSBs),.chip_value_MSBs(chip_value_MSBs),.pValid(pValid), .pReady(pReady)); 

initial
begin
pclk=0;
pValid =1;
pReady =1;
$monitor($time,"  LSBs=%b MSBs=%b chip_value_LSBs=%b chip_value_MSBs=%b", LSBs, MSBs,chip_value_LSBs,chip_value_MSBs);

end

always
#5 pclk=~pclk;

initial
begin
RESET_n = 0;
$monitor($time,"      LSBs=%b MSBs=%b chip_value_LSBs=%b chip_value_MSBs=%b", LSBs, MSBs,chip_value_LSBs,chip_value_MSBs);
#10 RESET_n=1;
end

initial
begin
	for (int i=0; i<200; i++)
		begin
			@(posedge pclk);
		        random_data = $urandom;
			LSBs = random_data;
			random_data = $urandom;
			MSBs = random_data;
#100

			$monitor($time," LSBs=%b MSBs=%b chip_value_LSBs=%b chip_value_MSBs=%b", LSBs, MSBs,chip_value_LSBs,chip_value_MSBs);
		end
		    $monitor($time," TEST PASSED");
        $finish;
end	

endmodule
