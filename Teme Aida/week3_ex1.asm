bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 60
    b dw 10
    c dd 50
    d dq 250

; our code starts here
segment code use32 class=code
    start:
        ; (a+b+d)-(a-c+d)+(b-c) 
        mov EBX, [a]
        add EBX, [b]; EBX <-EBX+b = 60+10 = 70 ; EBX = a+b
        
        add EAX, [d]; EAX <- EAX+d = 70+250 = 320; EAX = a+b+d
        mov EDX, 0; EAX -> EDX:EAX
        mov EAX, EBX ; EAX <- EBX
        
        
        ;mov ECX, [a]
        ;sub ECX, [c]; ECX <- ECX-c = a-c = 50; ECX = a-c
        
       ; mov 
       ; mov EBX, BX
       ; add EBX, [d] ; EBX <- EBX+d = 50+250 = 300; EBX = a-c+d
        
       ; sub EAX, EBX; EAX <- EAX-EBX = 320-300 = 20 ; EAX = (a+b+d)-(a-c+d)
        
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
