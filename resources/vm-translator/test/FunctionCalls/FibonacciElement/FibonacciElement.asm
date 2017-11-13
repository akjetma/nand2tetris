



// program: FibonacciElement




@256
D=A
@SP
M=D
@PROGRAM_ROOT$0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@5
D=A+D
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(PROGRAM_ROOT$0)




// class: Main



// line: function Main.fibonacci 0
(Main.fibonacci)

// line: push argument 0
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: lt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@TRUE_3
D;JLT
@FALSE_3
0;JMP
(TRUE_3)
@SP
A=M-1
M=-1
@CONTINUE_3
0;JMP
(FALSE_3)
@SP
A=M-1
M=0
@CONTINUE_3
0;JMP
(CONTINUE_3)

// line: if-goto IF_TRUE
@SP
AM=M-1
D=M
@Main$IF_TRUE
D;JNE

// line: goto IF_FALSE
@Main$IF_FALSE
0;JMP

// line: label IF_TRUE
(Main$IF_TRUE)

// line: push argument 0
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: return
@LCL
D=M
@R13
M=D
@5
D=A
@LCL
A=M-D
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
D=A
@SP
M=D+1
@R13
AM=M-1
D=M
@THAT
M=D
@R13
AM=M-1
D=M
@THIS
M=D
@R13
AM=M-1
D=M
@ARG
M=D
@R13
AM=M-1
D=M
@LCL
M=D
@R14
A=M
0;JMP

// line: label IF_FALSE
(Main$IF_FALSE)

// line: push argument 0
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D

// line: call Main.fibonacci 1
@Main$13
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@1
D=A
@5
D=A+D
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Main$13)

// line: push argument 0
@0
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D

// line: call Main.fibonacci 1
@Main$17
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@1
D=A
@5
D=A+D
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Main$17)

// line: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

// line: return
@LCL
D=M
@R13
M=D
@5
D=A
@LCL
A=M-D
D=M
@R14
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
D=A
@SP
M=D+1
@R13
AM=M-1
D=M
@THAT
M=D
@R13
AM=M-1
D=M
@THIS
M=D
@R13
AM=M-1
D=M
@ARG
M=D
@R13
AM=M-1
D=M
@LCL
M=D
@R14
A=M
0;JMP




// class: Sys



// line: function Sys.init 0
(Sys.init)

// line: push constant 4
@4
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: call Main.fibonacci 1
@Sys$2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@1
D=A
@5
D=A+D
@SP
D=M-D
@ARG
M=D
@SP
D=M
@LCL
M=D
@Main.fibonacci
0;JMP
(Sys$2)

// line: label WHILE
(Sys$WHILE)

// line: goto WHILE
@Sys$WHILE
0;JMP
