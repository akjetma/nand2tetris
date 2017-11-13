
// input: push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// input: pop local 0
@0
D=A
@LCL
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

// input: label LOOP_START
(BasicLoop$LOOP_START)

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

// input: push local 0
@0
D=A
@LCL
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

// input: pop local 0
@0
D=A
@LCL
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

// input: if-goto LOOP_START
@SP
AM=M-1
D=M
@BasicLoop$LOOP_START
D;JNE

// input: push local 0
@0
D=A
@LCL
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
