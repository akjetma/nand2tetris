// input: push constant 10
@10
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
// input: push constant 21
@21
D=A
@SP
A=M
M=D
@SP
M=M+1
// input: push constant 22
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
// input: pop argument 2
@2
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
// input: pop argument 1
@1
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
// input: push constant 36
@36
D=A
@SP
A=M
M=D
@SP
M=M+1
// input: pop this 6
@6
D=A
@THIS
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
// input: push constant 42
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
// input: push constant 45
@45
D=A
@SP
A=M
M=D
@SP
M=M+1
// input: pop that 5
@5
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
// input: push constant 510
@510
D=A
@SP
A=M
M=D
@SP
M=M+1
// input: pop temp 6
@SP
M=M-1
A=M
D=M
@11
M=D
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
// input: push that 5
@5
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
// input: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D
// input: push this 6
@6
D=A
@THIS
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1
// input: push this 6
@6
D=A
@THIS
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
// input: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D
// input: push temp 6
@11
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
