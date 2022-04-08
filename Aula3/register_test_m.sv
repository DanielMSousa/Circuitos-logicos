
module register_test_m ;

  timeunit        1ns ;
  timeprecision 100ps ;

  localparam time PERIOD = 20 ;
  localparam time WIDTH  =  8 ;

  logic [WIDTH-1:0] data_out ; // register data output
  logic [WIDTH-1:0] data_in  ; // register_test data input
  logic             load     ; // register_test enable
  logic             rst_     ; // register_test reset (asynch)
  logic             clk      ; // register_test clock

  // Instantiate register
  register_m #(WIDTH)  register ( .q(data_out), .d(data_in), .enb(load), .* ) ;

  // Generate Clock
  initial clk = 0 ;
  always #(PERIOD/2) clk = ~clk ;

  // Monitor Results
  initial
    begin
     $timeformat ( -9, 0, "ns", 5 ) ;
     $monitor ( "%t load=%b rst_=%b data_in=%h data_out=%h",
	        $time,   load,   rst_,   data_in,   data_out ) ;
     #(PERIOD * 99)
     $display ( "REGISTER TEST TIMEOUT" ) ;
     $finish ;
    end

  // Verify Results
  task xpect (input [WIDTH-1:0] expects) ;
    if ( data_out !== expects )
      begin
        $display ( "data_out is %b and should be %b", data_out, expects ) ;
        $display ( "REGISTER TEST FAILED" );
        $finish ;
      end
  endtask

  // Apply Stimulus
  initial
    begin
      @(negedge clk) // synchronize
      {rst_, load, data_in} = 10'b1_X_XXXXXXXX; @(negedge clk)             ;
      {rst_, load, data_in} = 10'b0_X_XXXXXXXX; @(negedge clk) xpect(8'h00);
      {rst_, load, data_in} = 10'b1_0_XXXXXXXX; @(negedge clk) xpect(8'h00);
      {rst_, load, data_in} = 10'b1_1_10101010; @(negedge clk) xpect(8'hAA);
      {rst_, load, data_in} = 10'b1_0_01010101; @(negedge clk) xpect(8'hAA);
      {rst_, load, data_in} = 10'b0_X_XXXXXXXX; @(negedge clk) xpect(8'h00);
      {rst_, load, data_in} = 10'b1_0_XXXXXXXX; @(negedge clk) xpect(8'h00);
      {rst_, load, data_in} = 10'b1_1_01010101; @(negedge clk) xpect(8'h55);
      {rst_, load, data_in} = 10'b1_0_10101010; @(negedge clk) xpect(8'h55);
      $display ( "REGISTER TEST PASSED" ) ;
      $finish ;
    end
endmodule : register_test_m
