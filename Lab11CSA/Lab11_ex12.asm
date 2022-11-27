bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll 

extern MMCfunction   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s1 db 'a','b','c','d',0
    s2 db 'e','f','g','h',0
    len equ($-s2)
    format db "%s",0
    s3 times len*2+1 db 0

    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword s3;rez
        push dword len;lenght
        push dword s2;string 2
        push dword s1;string 1
        call MMCfunction
        
        push s3
        push format
        call[printf]
        add esp,4*2 
         
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
