



// program: NestedCall




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




// class: Sys



// line: function Sys.init 0
(Sys.init)

// line: push constant 4000
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D

// line: push constant 5000
@5000
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D

// line: call Sys.main 0
@Sys$5
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
@Sys.main
0;JMP
(Sys$5)

// line: pop temp 1
@SP
M=M-1
A=M
D=M
@6
M=D

// line: label LOOP
(Sys$LOOP)

// line: goto LOOP
@Sys$LOOP
0;JMP

// line: function Sys.main 5
(Sys.main)
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
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: push constant 4001
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D

// line: push constant 5001
@5001
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D

// line: push constant 200
@200
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop local 1
@1
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

// line: push constant 40
@40
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop local 2
@2
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

// line: push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop local 3
@3
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

// line: push constant 123
@123
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: call Sys.add12 1
@Sys$21
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
@Sys.add12
0;JMP
(Sys$21)

// line: pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D

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

// line: push local 2
@2
D=A
@LCL
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push local 3
@3
D=A
@LCL
A=M+D
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push local 4
@4
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

// line: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

// line: add
@SP
M=M-1
A=M
D=M
A=A-1
M=M+D

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

// line: function Sys.add12 0
(Sys.add12)

// line: push constant 4002
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop pointer 0
@SP
M=M-1
A=M
D=M
@3
M=D

// line: push constant 5002
@5002
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: pop pointer 1
@SP
M=M-1
A=M
D=M
@4
M=D

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

// line: push constant 12
@12
D=A
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
