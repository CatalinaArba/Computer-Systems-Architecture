;7. Given the words A and B, compute the doubleword C:
;- the bits 0-4 of C have the value 1
;- the bits 5-11 of C are the same as the bits 0-6 of A
;- the bits 16-31 of C have the value 0000000001100101b
;- the bits 12-15 of C are the same as the bits 8-11 of B

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0111011101010111b
    b dw 1001101110111110b
    c dd 0 ; should be  0000 0000 0110 0101 1011 1010 1111 1111
    
; our code starts here
segment code use32 class=code
    start:
        mov ebx, 0 ; we compute the result in ebx
        
        or ebx, 00000000000000000000000000011111b ; we force the value of bits 0-4 of the result to the value 1
        
        mov  eax, [a] ; we isolate bits 0-6 of A
        and eax, 00000000000000000000000001111111b
        mov cl, 5
        rol eax, cl ; we rotate 5 positions to the left
        or ebx, eax ; we put the bits into the result
        
        mov eax, 00000000011001010000000000000000b
        or ebx, eax ; we put bits into the result
        
        mov eax, [b] ; we isolate bits 8-11 of B
        and eax, 00000000000000000000111100000000b
        mov cl, 4
        rol eax, cl ; we rotate 4 positions to the left
        or ebx, eax ; we put the bits into the result
        
        mov [c], ebx ; we move the result from the register to the result variable
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
