bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

extern Letters
segment data use32 class=data
    ; ...
    sir1 db 'a', 'b', 'c', 'd', 0
    sir2 db 'e', 'f', 'g', 'h', 0
    len equ ($-sir2)
    
    rez times len db 0
    
    format_string db "%s", 0

; our code starts here
segment code use32 class=code
    start:
        ; ...Two strings of characters of equal length are given. 
        ;Calculate and display the results of the interleaving of the letters, 
        ;for the two possible interlaces (the letters of the first string in an even position, 
        ;respectively the letters from the first string in an odd positions)
        
        ; 0 1 2 3 4 5 6 7
        ; a e b f c g d h 
       push dword rez
       push dword sir2
       push dword sir1
       push dword len
       call Letters
       
       push eax
       mov ecx, len
       do:
            lodsb
            pushad
            
            push dword eax
            push dword format_string
            call [printf]
            add esp, 4*2
            
            popad
            
        loop do
     
       
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
