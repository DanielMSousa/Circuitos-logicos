package ex_type_pkg ;
  typedef enum logic [2:0] 
  { HLT, SKZ, ADD, 
AND, XOR, LDA, STO, JMP } opcode_e ;
endpackage : ex_type_pkg

//ela recebe os valores no negged do clock