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
    a db 30
    b dw 20
    c dd 5
    d dq 40
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a+b+d)-(a-c+d)+(b-c)
        ;a - byte, b - word, c - double word, d - qword -
        ;Unsigned representation
        mov AL,[a];     AL=a=30
        mov AH,0;       AX=AL=a=30
        add AX,[b];     AX=a+b=30+20=50
        mov DX,AX;      DX=AX=50
        mov DX,0;       DX:AX=AX=50
        
        push DX
        push AX
        pop EAX;       EAX=AX=a+b=50
        
        add EAX,[d]     
        adc EDX,[d+4];  EDX:EAX=a+b+d=50+40=90
        
        mov EBX,EAX;    EBX=EAX=a+b+d=90
        mov ECX,EDX;    ECX=EDX
        
        mov AL,[a];     AL=a=30
        mov AH,0;       AX=AL=30
        
        sub AX,[c];     AX=a-c=30-5=25
        mov DX,AX;      DX=AX=25
        mov DX,0;       DX:AX=AX=25
        
        push DX
        push AX
        pop EAX;       EAX=AX=a-c=25
        
        add EAX,[d]     
        adc EDX,[d+4];  EDX:EAX=a-c+d=25+40=65
        sub EBX,EAX;    EBX=(a+b+d)-(a-c+d)=90-65=25
        sbb ECX,EDX;
        
        mov AX,[b];     AX=b=20
        mov DX,0
        push DX
        push AX
        pop EAX;       EAX=DX=b=20
        
        sub EAX,[c];     EAX=b-c=20-5=15
        
        add EBX,EAX;    EBX=EBX+EAX=(a+b+d)-(a-c+d)+(b-c)=25+15=40
        adc ECX,0;
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
