bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    a dw 50
    b dw 11
    c dw 8
    d dw 100

; our code starts here
segment code use32 class=code
    start:
        ; (c+c+c)-b+(d-a)
        
        mov AX, [c]
        add AX, [c] ; AX <= AX+c = 8+8 = 16; AX = c+c
        add AX, [c] ; AX <= AX+c = 16+8 = 24 ; AX = c+c+c
        
        mov BX, [b]
        sub AX, BX; AX <= AX-BX = 24-11 = 13 ; AX = (c+c+c)-b
        
        mov BX, [d]
        sub BX, [a] ; BX <= BX-a = 100-50 = 50; BX = d-a
        
        add AX, BX ; AX <= AX+BX = 13+50 = 63; AX = (c+c+c)-b+(d-a)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
