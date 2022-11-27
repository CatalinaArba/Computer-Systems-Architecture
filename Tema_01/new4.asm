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
    b db 15
    c db 5
    d dw 100
; our code starts here
segment code use32 class=code
    start:
        ; ...3*[20*(b-a+2)-10*c]/5
        ;a,b,c - byte, d - word
        mov AL,[b]    ;AL=b=15
        mov AH,[a]    ;AH=a=10
        sub AL,AH   ;AL=AL-AH=b-a=15-10=5
        add AL,2    ;AL=AL+2=b-a+2=150+2=7
        
        mov AH, 20  ;AH=20
        mul AH; AX=AL*AH=20*(b-a+2)=20*7=140
        mov BX,AX; BX=AX=20*(b-a+2)=140
        
        mov AL,10
        mov DL,[c];  DL=c=5
        
        mul DL;   AX=DL*AL=10*c=50
        sub BX,AX; BX=BX-AX=20*(b-a+2)-10*c=140-50=90
        
        mov DX,3
        mov AX,BX;  AX=BX=20*(b-a+2)-10*c=140-50=90
        mul DX; DX:AX=DX*AX=3*(20*(b-a+2)-10*c)=3*90=270
        
        mov SI,5; DX=5
        div SI; AX=DX:AX/SI=3*(20*(b-a+2)-10*c)/5=270/5=54
        
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
