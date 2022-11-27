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
    b dw 20
    c db 5
    d dd 100
    x dq 150
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a*b+2)/(a+7-c)+d+x; 
        ;a,c-byte; b-word; d-doubleword; x-qword
        ;Unsigned version
        ; exit(0)
        mov AL, [a];    AL=a=10    
        mov AH,0;       AX=AL=a=10
        
        mov BX,[b];     BX=b=20
        mul BX;         DX:AX=AX*BX=a*b=20*10=200
        
        push DX
        push AX
        pop EAX;        EAX=DX:AX=a*b=200
        
        add EAX,2;      EAX=a*b+2=202
        mov EBX,EAX;    EBX=EAX=a*b+2=202
        ;=>(a*b+2)
        
        mov AL,[a];     AL=a=10
        add AL,7;       AL=a+7=17
        sub AL,[c];     AL=a+7-c=17-5=12
        
        mov AH,0;       AX=AL=a+7-c=12
        mov CX,AX;      CX=AX=a+7-c=12
        
        push EBX
        pop AX;         DX:AX=EBX==a*b+2=202
        pop DX
        ;=>(a+7-c)
        
        div CX;         AX ← DX:AX / CX=(a*b+2)/(a+7-c)=202/12=16
        ;=>(a*b+2)/(a+7-c)
        
        ;mov CX,AX;      CX=AX=(a*b+2)/(a+7-c)=16
        mov CX,0;       CX:AX=CX=(a*b+2)/(a+7-c)=16
        push CX
        push AX
        pop ECX;        ECX= CX:AX=(a*b+2)/(a+7-c)=16
       
        add ECX,[d];    ECX=(a*b+2)/(a+7-c)+d=16+100=116
        
        ;=>(a*b+2)/(a+7-c)+d
        mov EBX,[x];    EBX=x
        mov EDX,[x+4];  EDX=[x+4]
        add ECX,EBX;    ECX=ECX+EBX=(a*b+2)/(a+7-c)+d+x=116+150=266
        adc EAX,EDX
        ;=>(a*b+2)/(a+7-c)+d+x
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
