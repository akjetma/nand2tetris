// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.




// --- pseudocode ---
//
// x = R0
// n = R1
// sum = 0
// i = 0
//
// for(i=0; i<n; i++) {
//   sum = sum + x;        
// }




// --- set x to R0 ---
@R0
D = M
@x
M = D 


// --- set n to R1 ---
@R1
D = M
@n
M = D


// --- set R2, sum, and i to 0[16] ---
@R2
M = 0 
@sum
M = 0 
@i
M = 0 



// --- main loop ---
(LOOP)

// Compute n - i
@n
D = M
@i
D = D - M

// --- exit loop if n - i == 0 ---
// note: n - i == 0 implies i == n, meaning we've run the loop n times
@SAVEANDQUIT
D; JEQ

// --- add another x to the sum ---
@x
D = M
@sum
M = D + M

// --- increment i ---
@i
M = M + 1

// --- recur ---
@LOOP
0; JMP




// --- store sum in R2 then enter 'end' loop ---
(SAVEANDQUIT)

// --- sum -> R2 ---
@sum
D = M
@R2
M = D

// --- end ---
@END
0; JMP




// --- terminal infinite loop ---
(END)

@END
0; JMP

