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
    d times l2+l1 db 0 ; reserve l2 bytes for the destination string and initialize it
    
   
; our code starts here
segment code use32 class=code
    start:
        ; ...
     
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
