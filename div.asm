// (R0,R1,R2 refer to RAM[0],RAM[1],RAM[2])
   @10
   D=A              
   @0
   M=D              // M[0] = 20 (DIVIDENDO)
   @3
   D=A              
   @1
   M=D              // M[1] = 3 (DIVISOR)
   @0
   D=A              
   @2
   M=D              // M[2] = 0 (QUOCIENTE)
   (LOOP)
   @1
   D=M              // D = b
   @0 
   M=M-D            // D = a - b 
   @0
   D=M
   @1
   D=D-M
   @END
   D;JLT            // if D<0 (a < b) goto END
   @2
   M=M+1            // M[2] = M[2]+1 (QUOCIENTE)
   @LOOP
   0;JMP
   (END)
   @0
   D=M              // M[0] É O RESTO DA DIVISÃO INTEIRA  
   @2
   D=M              // M[2] É O QUOCIENTE DA DIVISÃO INTEIRA
