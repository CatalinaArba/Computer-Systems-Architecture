bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1001101010111011b
    b dw 0011010110011001b
    c dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Given the words A and B, compute the doubleword C as follows:
        ;the bits 0-6 of C have the value 0
        ;the bits 7-9 of C are the same as the bits 0-2 of A
        ;the bits 10-15 of C are the same as the bits 8-13 of B
        ;the bits 16-31 of C have the value 1
        mov bx,0
        mov dx,0;       we compute the result in dx:bx
        
        
        and bx,1111111110000000b;    we force the value of bits 0-6 from result to have the value 0
        ;=>bx=0000000000000000(binary)=0000(hex)
        
        mov ax,[a];
        and ax,0000000000000111b; we isolate bits 0-2 of A
        mov cl,7
        rol ax,cl; we rotate 6 position to left
        or bx,ax; we put the bits into the result
        ;=>bx=0000000110000000(binary)=0180(hex)
        
        mov ax,[b]
        and ax,0011111100000000b; we isolate bits 8-13 of B
        mov cl, 2
        rol ax,cl; we rotate 2 position to right
        or bx,ax; we put the bits into the result
        ;=>bx=1101010110000000(binary)=d580(hex)
        
        or dx,1111111111111111b; force the value of bits 0-15 from result to have the value 1
        ;=>dx=1111111111111111(binary)=FFFF(hex)
        
        push dx; dx=1111111111111111(binary)=FFFF(hex)
        push bx; bx=1101010110000000(binary)=d580(hex)
        pop eax
        
        mov[c],eax
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
