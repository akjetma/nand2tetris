



// class: SimpleFunction



// line: function SimpleFunction.test 2
(SimpleFunction.test)
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: push local 0
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

// line: push local 1
@1
D=A
@LCL
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

// line: not
@SP
A=M-1
M=!M

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

// line: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

// line: push argument 1
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

// line: sub
@SP
M=M-1
A=M
D=M
A=A-1
M=M-D

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
