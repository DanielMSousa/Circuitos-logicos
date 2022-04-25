module alu_test_m ;

  timeunit        1ns ;
  timeprecision 100ps ;

  import ex_type_pkg::* ;

  localparam time PERIOD = 20 ;
  localparam int  WIDTH  =  8 ;

  logic  [7:0] alu_out ; // alu output
  logic        zero    ; // alu accumulator value is 0
  logic  [7:0] accum   ; // alu_test accumulator
  logic  [7:0] data    ; // alu_test data bus
  opcode_e     opcode  ; // alu_test operation (enumerated)
  logic        clk     ; // alu_test clock

  // Instantiate ALU
  alu_m #(WIDTH) alu ( .out(alu_out), .* ) ;

  // Generate Clock
  initial clk = 0 ;
  always #(PERIOD/2) clk = ~clk ;

  // Monitor Response
  initial
    fork
      $timeformat ( -9, 0, "ns", 5 ) ;
      forever @(alu_out or zero)
        #(PERIOD/4)
          $display("%t accum=%b data=%b opcode=%s zero=%b alu_out=%b",
                   $time, accum, data, opcode.name(), zero, alu_out ) ;
      begin
        #(100 * PERIOD)
          $display ( "ALU TEST TIMEOUT" ) ;
        $finish ;
      end
    join

  // Verify Response
  task xpect (input zero_e, input [WIDTH-1:0] alu_out_e ) ;
    if ( zero!==zero_e || alu_out!==alu_out_e )
      begin
        $display ( "ALU TEST FAILED" ) ;
        $display ( "results should be . . . . . . . . . . . . . . . . zero=%b alu_out=%b",
                   zero_e, alu_out_e ) ;
        $finish ;
      end
  endtask


  // Apply Stimulus
  initial
    begin
      @(posedge clk)
      opcode=HLT; data='h37; accum='hDA; @(posedge clk) xpect(0,'hDA); // ACCUM
      opcode=SKZ; data='h37; accum='hDA; @(posedge clk) xpect(0,'hDA); // ACCUM
      opcode=ADD; data='h37; accum='hDA; @(posedge clk) xpect(0,'h11);
      opcode=AND; data='h37; accum='hDA; @(posedge clk) xpect(0,'h12);
      opcode=XOR; data='h37; accum='hDA; @(posedge clk) xpect(0,'hED);
      opcode=LDA; data='h37; accum='hDA; @(posedge clk) xpect(0,'h37); // DATA
      opcode=STO; data='h37; accum='hDA; @(posedge clk) xpect(0,'hDA); // ACCUM
      opcode=JMP; data='h37; accum='h00; @(posedge clk) xpect(1,'h00); // ACCUM
      opcode=ADD; data='h07; accum='h12; @(posedge clk) xpect(0,'h19);
      opcode=AND; data='h1F; accum='h35; @(posedge clk) xpect(0,'h15);
      opcode=XOR; data='h1E; accum='h1D; @(posedge clk) xpect(0,'h03);
      opcode=LDA; data='h72; accum='h00; @(posedge clk) xpect(1,'h72); // DATA
      opcode=STO; data='h00; accum='h10; @(posedge clk) xpect(0,'h10);
      $display ( "ALU TEST PASSED" ) ;
      $finish ;
    end

endmodule : alu_test_m
