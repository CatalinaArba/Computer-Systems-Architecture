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
    a dw 5
    b dw 6
    c dw 7
    d dw 8
; our code starts here
segment code use32 class=code
    start:
        ; ...b+c+d+a-(d+c)
        mov AX,[b]  ;AX=b=6
        add AX,[c]  ;AX=b+c=6+7=13
        add AX,[d]  ;AX=b+c+d=13+8=21
        add AX,[a]  ;AX=b+c+d+a=21+5=26
        
        mov BX,[d]  ;BX=d=8
        add BX,[c]  ;BX=d+c=8+7=15
        
        sub AX,BX   ;AX=AX-BX=26-15=11
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
