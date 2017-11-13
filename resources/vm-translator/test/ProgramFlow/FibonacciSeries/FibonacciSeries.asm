
// input: push argument 1
@1
D=A
@ARG
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// input: pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D

// input: push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// input: pop that 0
@0
D=A
@THAT
A=M+D
D=A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D

// input: push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// input: pop that 1
@1
D=A
@THAT
A=M+D
D=A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D

// input: push argument 0
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

// input: push constant 2
@2
D=A
@SP
A=M
M=D
@SP
M=M+1

// input: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D

// input: pop argument 0
@0
D=A
@ARG
A=M+D
D=A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D

// input: label MAIN_LOOP_START
(FibonacciSeries$MAIN_LOOP_START)

// input: push argument 0
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

// input: if-goto COMPUTE_ELEMENT
@SP
AM=M-1
D=M
@FibonacciSeries$COMPUTE_ELEMENT
D;JNE

// input: goto END_PROGRAM
@FibonacciSeries$END_PROGRAM
0;JMP

// input: label COMPUTE_ELEMENT
(FibonacciSeries$COMPUTE_ELEMENT)

// input: push that 0
@0
D=A
@THAT
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// input: push that 1
@1
D=A
@THAT
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// input: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

// input: pop that 2
@2
D=A
@THAT
A=M+D
D=A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D

// input: push pointer 1
@4
D=M
@SP
A=M
M=D
@SP
M=M+1

// input: push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// input: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

// input: pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D

// input: push argument 0
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

// input: push constant 1
@1
D=A
@SP
A=M
M=D
@SP
M=M+1

// input: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D

// input: pop argument 0
@0
D=A
@ARG
A=M+D
D=A
@R13
M=D
@SP
M=M-1
A=M
D=M
@R13
A=M
M=D

// input: goto MAIN_LOOP_START
@FibonacciSeries$MAIN_LOOP_START
0;JMP

// input: label END_PROGRAM
(FibonacciSeries$END_PROGRAM)
