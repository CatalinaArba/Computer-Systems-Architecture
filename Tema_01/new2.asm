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
    a db 2
    b db 4
    c db 3
    d db 1
; our code starts here
segment code use32 class=code
    start:
        ; ...(a+d+d)-c+(b+b)
        mov AL,[a] ;AL=a=2
        add AL,[d] ;AL=a+d=2+1=3
        add AL,[d] ;AL=a+d+d=3+1=4
        
        mov AH,[c]  ;AH=c=3
        sub AL,AH   ;AL=AL-AH=(a+d+d)-c=4-3=1
        
        mov AH,[b] ;AH=b=4
        add AH,[b]  ;AH=b+b=4+4=8
        add AH,AL   ;AH=AH+AL=8+1=9
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
