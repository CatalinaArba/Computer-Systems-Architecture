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
        mov AH, 0; unsigned conversion from AL to AX; AX = a = 10
        
        mul word[b]; DX:AX = a*b = 500
        
        push DX
        push AX
        pop EAX; EAX <- DX:AX = 500
        
        add EAX, 2; EAX <- EAX+2 = 502; EAX = a*b+2
        mov ECX, EAX; ECX = EAX = a*b+2 = 502
        
        mov AL, [a]
        add AL, 7; AL <- AL +7 = 17
        sub AL, [c]; AL <- Al-c = 17-15 = 2
        mov AH, 0; AL-> AX; AX = a+7-c = 2
        mov BX, AX; BX = a+7-c = 2
        
        mov EAX, ECX; EAX = ECX = a*b+2 = 502
        push EAX
        pop AX
        pop DX; DX:AX = EAX = 502
        
        div BX; AX<-DX:AX/BX = 251; DX<-DX:AX%BX;   AX = (a*b+2)/(a+7-c) = 251
        
        mov DX, 0; AX -> DX:AX
        
        push DX
        push AX
        pop EAX; EAX <- DX:AX = (a*b+2)/(a+7-c)
        add EAX, [d]; EAX <- EAX+d = 251+50 = 301
        
        mov EDX, 0; EAX -> EDX:EAX
        add EAX, [x+0]
        adc EDX, [x+4]
        
        
       
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
