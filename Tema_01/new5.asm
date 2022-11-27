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
    b db 20
    c db 30
    d db 40
; our code starts here
segment code use32 class=code
    start:
        ; ...a*d+b*c
        ;a,b,c,d-byte
        mov AH,[a]    ;AH=a=10
        mov AL,[d]    ;AL=d=40
        mul AH      ;AX=AL*AH=a*d=10*40=400
        
        mov BX,AX   ;BX=AX=a*d=400
        
        mov AH,[b]    ;AH=b=20
        mov AL,[c]   ;AL=c=30
        mul AH      ;AX=AL*AH=b*c=20*30=600
        
        add AX,BX   ;AX=AX+BX=600+400=1000
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
