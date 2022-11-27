bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
import exit msvcrt.dll  
extern printf
import printf msvcrt.dll  


extern MMCmystringf


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db 'a', 'd', 'k', 'l'
    s2 db 'o', 'p', 'a', 'm'
    len1 equ 2*($-s1)
    
    rez times len1 db 0
    
    format_string db "strings are %c", 10, 13, 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;Two strings of characters of equal length are given. Calculate and display the results of the interleaving of the letters, 
        ;for the two possible interlaces (the letters of the first string in an even position, respectively the letters from the first string in an odd positions). 
        ;Where no character exist in the source string, the ‘ ’ character will replace it in the destination string. 
        
        push dword rez
        push dword len1
        push dword s2
        push dword s1
        call MMCmystringf
        
        ; print rez
        mov esi, rez
        mov ebx, 0
        mov ecx, len1
        
        print_loop:
            mov eax, 0
            lodsb
            pushad
            
            push eax
            push ebx
            push dword format_string
            call [printf]
            add esp, 4*3
            
            popad
            inc ebx
        loop print_loop
        
        
        
    
    
    
    
    
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
