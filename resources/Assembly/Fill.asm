// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.




// --- pseudocode ---
//
// screenColor = 0;
// pixelChunks = 256 * 32;
//
// fn paintScreen {
//   for (chunk=0; row<pixelChunks; chunk++) {
//     screen[chunk] = screenColor;
//   }
// }
//
// loop {
//   if (keyPressed) {
//     if (screenColor == 0) {
//       screenColor = 1;
//       paintScreen();
//     }
//   } else {
//     if (screenColor == 1) {
//       screenColor = 0;
//       paintScreen();
//     }
//   }
// }




// --- Set SCREEN_END 'constant' ---
// SCREEN_END will hold the address of the last register in 
// the screen memory map. There are 256 rows, with 32 16-bit
// registers in each row. Therefore, the address of the last
// register is: [address of the first register] + 256 * 32,
// or SCREEN + 8192
@8192 // Tricky way to get a numeric constant into the system.
      // We don't actually care about register 8192, we just 
      // need the number itself (A = 8192).
D = A
@SCREEN
D = D + A
@SCREEN_END
M = D


// --- Initialize current_shade to white (0) ---
// white = 0[16], black = -1[16]
@current_shade
M = 0


// --- Initialize active_register to the address of SCREEN -- 
// (SCREEN is the first register in the screen memory map)
@SCREEN
D = A
@active_register
M = D



(LISTEN)
// Get keyboard input, then make sure the screen is black or 
// white if a key is pressed or not, respectively. 
// This is effectively the main program 'loop'--the
// recursing call happens outside of the immediate loop body 
// (in WHITEN, BLACKEN, or PAINT).

    @KBD
    D = M
    
    // If some key is pressed (KBD != 0), ensure the screen
    // is black.
    @BLACKEN
    D; JNE
    
    // Otherwise, no key must be pressed (KBD == 0), so 
    // ensure the screen is white.
    @WHITEN
    0; JMP



(WHITEN)
// Paint the screen white if it isn't already and return to 
// the LISTEN routine. If the screen is already white, it just
// immediately returns to LISTEN, otherwise it hands control
// to the PAINT routine (which in turn goes back to LISTEN after
// painting).

    // Current_shade is used for two purposes. 
    // 1. Determining the current shade of the screen mmap
    // 2. Indicating to the PAINT routine what shade to use
    @current_shade
    D = M // Get the current shade
    M = 0 // Set the next shade to white
         
    // If screen isn't already white (D != 0), PAINT
    @PAINT
    D; JNE

    // Otherwise, return to LISTEN loop
    @LISTEN
    0; JMP



(BLACKEN)
// Same as whiten, but black... This redundancy can definitely be
// cleaned up, just need to figure out how.

    @current_shade
    D = M
    M = -1 // black

    @PAINT
    0; JEQ // (D == 0) == screen is currently white

    @LISTEN
    0; JMP



(PAINT)
// Fill in the registers of the screen memory map with the value
// of current_shade.
    
    // Current 'desired' value of screen
    @current_shade
    D = M
    
    // Fill the active register with current_shade. Note that
    // @active_register stores the *address* of a register--it 
    // does not store the value of the register, nor is it the
    // register itself.
    @active_register
    A = M // Set *working address* to the active register's address
    M = D // Set the active register's memory to D (current_shade).
    
    // increment active_register
    @active_register
    MD = M + 1
    
    // if there are still pixels to paint, recur ...
    @SCREEN_END
    D = M - D
    @PAINT
    D; JGT //    (M - D > 0)
           // == (last register addr - active register addr > 0)
           // == active register addr < last register addr
           // == we haven't reached the end yet
    
    // ... otherwise, reset active_register ...
    @SCREEN
    D = A
    @active_register
    M = D
    
    // ... and head back to the LISTEN loop
    @LISTEN
    0; JMP
    
