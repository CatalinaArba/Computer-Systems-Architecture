bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    d dw 20

; our code starts here
segment code use32 class=code
    start:
        ; [100*(d+3)-10]/d 
        
        mov AX, [d]
        add AX, 3 ; AX <= AX+3 = 20+3 = 23 ; AX = d+3
        
        mov DX, 100
        mul DX ; DX:AX <= AX*DX = 100*23 = 2300;
        
        push DX
        push AX
        pop EAX; EAX <= DX:AX = AX*DX = 2300; EAX = 100*(d+3)
        
        sub EAX, 10 ; EAX <= EAX-AX = 2300-10 = 2290; EAX = 100*(d+3)-10
        
        push EAX
        pop AX
        pop DX; DX:AX = EAX = 2300 = 100*(d+3)-10
        
        div WORD [d] ; AX <= DX:AX/d = 2290/20 = 114 and DX <= DX:AX%d = 2290%20 = 10; ; AX = [100*(d+3)-10]/d 
        
        
    
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
