



// program: StaticsTest




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




// class: Class1



// line: function Class1.set 0
(Class1.set)

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

// line: pop static 0
@SP
M=M-1
A=M
D=M
@Class1.0
M=D

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

// line: pop static 1
@SP
M=M-1
A=M
D=M
@Class1.1
M=D

// line: push constant 0
@0
D=A
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

// line: function Class1.get 0
(Class1.get)

// line: push static 0
@Class1.0
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push static 1
@Class1.1
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




// class: Sys



// line: function Sys.init 0
(Sys.init)

// line: push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: push constant 8
@8
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: call Class1.set 2
@Sys$3
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
@2
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
@Class1.set
0;JMP
(Sys$3)

// line: pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D

// line: push constant 23
@23
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: push constant 15
@15
D=A
@SP
A=M
M=D
@SP
M=M+1

// line: call Class2.set 2
@Sys$7
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
@2
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
@Class2.set
0;JMP
(Sys$7)

// line: pop temp 0
@SP
M=M-1
A=M
D=M
@5
M=D

// line: call Class1.get 0
@Sys$9
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
@Class1.get
0;JMP
(Sys$9)

// line: call Class2.get 0
@Sys$10
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
@Class2.get
0;JMP
(Sys$10)

// line: label WHILE
(Sys$WHILE)

// line: goto WHILE
@Sys$WHILE
0;JMP




// class: Class2



// line: function Class2.set 0
(Class2.set)

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

// line: pop static 0
@SP
M=M-1
A=M
D=M
@Class2.0
M=D

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

// line: pop static 1
@SP
M=M-1
A=M
D=M
@Class2.1
M=D

// line: push constant 0
@0
D=A
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

// line: function Class2.get 0
(Class2.get)

// line: push static 0
@Class2.0
D=M
@SP
A=M
M=D
@SP
M=M+1

// line: push static 1
@Class2.1
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
