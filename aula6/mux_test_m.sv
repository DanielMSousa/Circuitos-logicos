module mux_test_m ;

  timeunit        1ns ;
  timeprecision 100ps ;

  localparam time WIDTH  =  8 ;

  logic [WIDTH-1:0] out     ; // mux output
  logic [WIDTH-1:0] data_a  ; // mux_test data_a
  logic [WIDTH-1:0] data_b  ; // mux_test data_b
  logic             sel_a   ; // mux_test select a

  // Instantiate mux
  mux_m #(WIDTH) mux ( .* ) ;
  //mux_assign #(WIDTH) mux1 ( .* ) ;
  //mux_if #(WIDTH) mux2 ( .sel(sal_a),.*) ;


  // Monitor Results
  initial
    begin
     $timeformat ( -9, 0, "ns", 3 ) ;
     $monitor ( "%t data_a=%b data_b=%b sel_a=%b out=%b",
	        $time,   data_a,   data_b,   sel_a,   out ) ;
    end

  // Verify Results
  task xpect (input [WIDTH-1:0] expects) ;
    if ( out !== expects )
      begin
        $display ( "out is %b and should be %b", out, expects ) ;
        $display ( "MUX TEST FAILED" );
        $finish ;
      end
  endtask

  // Apply Stimulus
  initial
    begin
      data_a='0; data_b='0; sel_a=0; #1ns xpect('0);
      data_a='0; data_b='0; sel_a=1; #1ns xpect('0);
      data_a='0; data_b='1; sel_a=0; #1ns xpect('1);
      data_a='0; data_b='1; sel_a=1; #1ns xpect('0);
      data_a='1; data_b='0; sel_a=0; #1ns xpect('0);
      data_a='1; data_b='0; sel_a=1; #1ns xpect('1);
      data_a='1; data_b='1; sel_a=0; #1ns xpect('1);
      data_a='1; data_b='1; sel_a=1; #1ns xpect('1);
      $display ( "MUX TEST PASSED" ) ;
      $finish(0) ;
    end

endmodule : mux_test_m
