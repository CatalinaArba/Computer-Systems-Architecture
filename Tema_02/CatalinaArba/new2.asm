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
    a db -10
    b dw 20
    c db 5
    d dd -100
    x dq 150
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a*b+2)/(a+7-c)+d+x; 
        ;a,c-byte; b-word; d-doubleword; x-qword
        ;Signed version
        
        mov AL, [a];    AL=a=-10    
        cbw;            AX=AL=a=-10
        
        mov BX,[b];     BX=b=20
        imul BX;        DX:AX=AX*BX=a*b=20*(-10)=-200
        
        push DX
        push AX
        pop EAX;        EAX=DX:AX=a*b=-200
        
        add EAX,2;      EAX=a*b+2=-198
        mov EBX,EAX;    EBX=EAX=a*b+2=-198
        
        
        mov AL,[a];     AH=a=-10
        add AL,7;       AH=a+7=-3
        sub AL,[c];     AH=a+7-c=-3-5=-8
        
        cbw;            AX=AL=a+7-c=-8
        mov CX,AX;      CX=AX=a+7-c=-8
        
        push EBX
        pop AX
        pop DX;         DX:AX=EBX==a*b+2=-198
        
        idiv CX;        AX ← DX:AX / CX=(a*b+2)/(a+7-c)=-198/-8=24
        cwd;            DX:AX=AX=(a*b+2)/(a+7-c)=24
        
        push DX
        push AX
        pop ECX;        ECX= CX:AX=(a*b+2)/(a+7-c)=24
       
        add ECX,[d];    ECX=(a*b+2)/(a+7-c)+d=-198+(-100)=-298
        
        mov EBX,[x];    EBX=x=150
        mov EDX,[x+4];  EDX=[x+4]
        add ECX,EBX;    ECX=ECX+EBX=(a*b+2)/(a+7-c)+d+x=-298+150=-148
        adc EAX,EDX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
