@1               // Início do programa principal  
D=M              // DENOMINADOR 
@DIVISAOPORZERO
D;JEQ            // if (NUMERADOR == 0) goto DIVISAOPORZERO
@0               
D=M              // NUMERADOR
@TIPO2OU3        // classificação do TIPO 
D;JLT            // if (NUMERADOR < 0) goto TIPO2OU3
@1
D=M              // DENOMINADOR
@TIPO1OU3
D;JLT            // if (DENOMINADOR < 0) goto TIPO1OU3
@7               // resultado tipo 0 - default (NUMERADOR e DENOMINADOR positivos) RAM[7]
M=0
@INICIODIVIDE
0;JMP
(TIPO1OU3)
@0
D=M
@TIPOAMBOSNEG
D;JLT            // if (DENOMINADOR < 0) goto TIPOAMBOSNEG
@7               // resultado tipo 1 (NUMERADOR + e DENOMINADOR -) RAM[7]
M=1
@INICIODIVIDE
0;JMP
(TIPO2OU3)
@1
D=M
@TIPOAMBOSNEG
D;JLT            // if (DENOMINADOR < 0) goto TIPOAMBOSNEG
@7               // resultado tipo 2 (NUMERADOR - e DENOMINADOR +) RAM[7]
@2
D=A
@7
M=D 
@INICIODIVIDE
0;JMP
(TIPOAMBOSNEG)
@3
D=A
@7               // resultado tipo 3 (NUMERADOR - e DENOMINADOR -) RAM[7]
M=D 
(INICIODIVIDE)
@0               // Carrega MÓDULO DO NUMERADOR para RAM[4] - Passagem de parâmetros por cópia
D=M              
@NEGATIVO0
D;JLT
@4               // Carrega MÓDULO DO NUMERADOR para RAM[4] 
M=D  
(RETORNONEG0)                
@1
D=M             // carrega DENOMINADOR para D
@NEGATIVO1
D;JLT
@5               // Carrega NUMERADOR POSITIVO para RAM[5] 
M=D  
(RETORNONEG1)                
@DIVIDE
0;JMP
(NEGATIVO0)
@0
D=M
@4
M=-D
@RETORNONEG0
0;JMP
(NEGATIVO1)
@1
D=M
@5
M=-D
@RETORNONEG1
0;JMP
(DIVIDE)
@6              
M=0             // Zera o QUOCIENTE em RAM[6]
(DIVIDEUNSIGN)  // função divide_unsign com parâmetros NUMERADOR(RAM[4]) e DENOMINADOR(RAM[5])
@5
D=M              // DENOMINADOR 
@4 
D=M-D            // NUMERADOR = NUMERADOR - DENOMINADOR em D
@NAOINCREMENTA
D;JLT
@4
M=D
@6
M=M+1            // RAM[6] = RAM[6]+1 (QUOCIENTE)
(NAOINCREMENTA)
@4
D=M
@5
D=D-M
@DIVIDEFEITO
D;JLT            // if (Dividento < DENOMINADOR) goto DIVIDEFEITO
@DIVIDEUNSIGN
0;JMP
(DIVIDEFEITO)
@7              
D=M              // Tipo em D 
@RESPOSTA0
D;JEQ            // if (Tipo == 0) goto RESPOSTA0
@1
D=D-A
@RESPOSTA1
D;JEQ            // if (Tipo == 1) goto RESPOSTA1
@7               // Tipo em D
D=M
@2
D=D-A
@RESPOSTA2
D;JEQ            // if (Tipo == 2) goto RESPOSTA2
@7               // Tipo em D
D=M
@3
D=D-A
@RESPOSTA3
D;JEQ            // if (Tipo == 3) goto RESPOSTA3
(RESPOSTA0)
@4               // RAM[4] está o RESTO
D=M
@3
M=D
@6              // RAM[6] está o QUOCIENTE
D=M              
@2
M=D             // RETORNA (Q,R)
@FIM
0;JMP           // VAI PARA FIM
(RESPOSTA1)
@4
D=M
@3
M=D
@6
D=-M              
@2
M=D             // RETORNA (-Q,R)
@FIM
0;JMP           // VAI PARA FIM
(RESPOSTA2)
@4               
D=M              // RESTO
@RESTOA
D;JEQ           // VAI PARA RESTO0
@1
D=M-D            // NUMERADOR-RESTO em D
@3
M=D
@6
D=-M            // -QUOCIENTE em D
@1
D=D-A
@2
M=D             // RETORNA (-Q-1, DENOMINADOR-R)
@FIM
0;JMP
(RESTOA)
@3
M=0
@6
D=-M              
@2
M=D             // RETORNA (-Q,0)
@FIM
0;JMP           // VAI PARA FIM
(RESPOSTA3)
@4               
D=M              // RESTO EM D
@3
M=D
@6
D=M+1            // QUOCIENTE+1 em D
@2
M=D              // RETORNA (Q+1, R)
@FIM
0;JMP
(DIVISAOPORZERO)
@2
M=0              // quociente = 0
@32767
D=A              
@3
M=D              // resto = 32767
@FIM
0;JMP
(FIM)
@FIM
0;JMP