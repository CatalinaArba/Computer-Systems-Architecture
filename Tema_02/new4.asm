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
    a db -30
    b dw -20
    c dd 5
    d dq 40
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a-b-c)+(d-b-c)-(a-d)
        ;a - byte, b - word, c - double word, d - qword -
        ;Signed representation
        ;a-b-c
        mov AL,[a];      AL=a=-30
        cbw;             AX=AL=a=-30
        sub AX,[b];        AX=a-b=-30-(-20)=-10
        cwd;
        push DX
        push AX
        pop EAX;        EAX=a-b=-10
        sub EAX,[c];      EAX=a-b-c=-10-5=-15
        mov ECX,EAX;    ECX=EAX=a-b-c
        ;=>ecx=(a-b-c)
        ;d-b-c
        mov EBX,[d];
        mov Edx,[d+4]
        mov AX,[b];       AX=b=-20
        cwd;            DX:AX=AX=b=-20
        push DX
        push AX
        pop EAX;        EAX=DX:AX=AX=b=-20
        sub EBX,EAX;    EBX=EBX-EAX=d-b=40-(-20)=60
        sbb EDX,0;
        sub EBX,[c];    EBX=d-b-c=60-5=55
        sbb EDX,0;
        add ECX,EBX;
        adc EDX,0;
        mov EBX,EDX
        ;=>EBX:ECX=(a-b-c)+(d-b-c)
        
        mov AL,[a]; AL=a=-30
        cbw;        AX=AL=-30
        cwd;
        push DX;
        push AX;
        pop EAX;    EAX=AX=a=-30
        mov EDX,[d];EDX=d
        sub EAX,EDX;
        mov EDX,[d+4];
        SBB 
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
