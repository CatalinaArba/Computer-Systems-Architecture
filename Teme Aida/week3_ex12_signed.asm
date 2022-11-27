bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;...
    a db 10
    b dw 50
    c db 15
    d dd 50
    x dq 113
    

; our code starts here
segment code use32 class=code
    start:
        ; (a*b+2)/(a+7-c)+d+x; a,c-byte; b-word; d-doubleword; x-qword
        
        mov AL, [a]
        add AL, 7; AL<-AL+7 = a+7 = 10+7 = 17
        sub AL, [c]; AL<-AL-c = 17-15 = 2
        cbw; signed conversion from AL to AX
        mov BX, AX; BX<-AX; BX = a+7-c
        
        mov AL, [a]
        cbw; signed conversion from AL to AX
        mov CX, [b]
        imul CX; DX:AX = 10*50 = 500
        
        push DX
        push AX
        pop EAX; EAX<-DX:AX = 500
        
        add EAX, 2; EAX = 502 = a*b+2
        
        push EAX
        pop AX
        pop DX; DX:AX <- EAX
        
        idiv BX; AX<- DX:AX/BX; DX<- DX:AX%BX;  AX = (a*b+2)/(a+7-c)
        cwd
        
        add AX, [d+0]
        adc DX, [d+2]; DX:AX <- (a*b+2)/(a+7-c)+d = 301
        
        push DX
        push AX
        pop EAX; EAX <- DX:AX = (a*b+2)/(a+7-c)+d = 301
        cdq; EAX->EDX:EAX = (a*b+2)/(a+7-c)+d
        
        add EAX, [x+0]; EAX = (a*b+2)/(a+7-c)+d+x = 414
        adc EDX, [x+4]; EDX:EAX = (a*b+2)/(a+7-c)+d+x 
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
