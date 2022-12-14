bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 10
    b db 5
    c db 12
    d db 20

; our code starts here
segment code use32 class=code
    start:
        ; (a+b)*(c+d)
        mov AL, [a]
        add AL, [b] ; AL <= AL+b = a+b = 10+5 = 15; AL = a+b
        
        mov AH, [c]
        add AH,[d] ; AH <= AH+d = c+d = 12+20 = 32; AH = c+d
        
        mul AH ; AX <= AL*AH = 15*32 = 480; AX = (a+b)*(c+d)
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
