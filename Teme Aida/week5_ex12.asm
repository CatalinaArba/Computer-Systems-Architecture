;Two character strings S1 and S2 are given. Obtain the string D by concatenating the elements found on even positions in S2 and the elements found on odd positions in S1.
;Example:
;S1: 'a', 'b', 'c', 'd', 'e', 'f'
;S2: '1', '2', '3', '4', '5'
;D: '2', '4','a','c','e'

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
    s1 db 'a', 'b', 'c', 'd', 'e', 'f'
    l1 equ $-s1 ; compute the length of the string s1 in l1
    s2 db '1', '2', '3', '4', '5'
    l2 equ $-s2 ; compute the length of the string s2 in l2
    d times l1/2+l2/2+2 db 0 ; reserve l2 bytes for the destination string and initialize it
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ECX, l2; I put the legth l2 in ECX in order to make the loop
        mov esi, 1
        mov edi, 0
        jecxz Finish
        Do:
            test esi, 1 ; check if esi is odd or even
            jpo even_nr  ;jump short if parity odd
                mov AL, [s2+esi-1]
                mov [d+edi], AL
                inc edi
            even_nr:
            inc esi
        loop Do
        Finish: 
        
        mov ECX, 0
        mov ECX, l1 ; I put the length l1 in ECX in order to make the loop
        mov esi, 1
        jecxz Finish1
        Do1:
            test esi, 1 ; check if esi is odd or even
            jpe odd_nr   ;jump short if parity even
                mov AL, [s1+esi-1]
                mov [d+edi], AL
                inc edi
            odd_nr:
            inc esi
        loop Do1
        Finish1:
        
        
        
        
            
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
