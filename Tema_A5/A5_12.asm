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
   
    s2 db '1','2','3','4','5'
    l2 equ $-s2    
    s1 db 'a','b','c','d','e','f'
    l1 equ $-s1
    
    d times l2 db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
    ;Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on even positions in S2 and the elements found on odd positions in S1.
    ;S1: 'a', 'b', 'c', 'd', 'e', 'f'
    ;S2: '1', '2', '3', '4', '5'
    ;D: '2', '4','a','c','e'
    
        
        mov esi,0
        mov ecx,l2

        jecxz Sfarsit1
        Repeta1:
            mov al, [s2+esi]
            mov [d+edi],al
            inc esi
            inc esi
            inc edi
        loop Repeta1
        Sfarsit1:
        
        mov ecx,l1
        mov esi,0
 
        jecxz Sfarsit2
        Repeta2:
            mov al, [s1+esi]
            mov [d+edi],al
            inc esi
            inc esi
            inc edi
        loop Repeta2
        Sfarsit2:    
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
