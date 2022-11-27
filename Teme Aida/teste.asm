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
    ;a dd 1A2B3CH, 4D9FH, 6E27H
    ;a db '123', '4', '56'
    ;b resd 1
    ;c dw 4-1, 3
 
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ;mov al, 250>>4 ; 15
        ;mov al, 0ffffh>>4 ; -1
        ;mov al, 0efffh>>12; 14
        ;mov al, -1>>4; -1
        ;mov al, -1>>12 ; -1
        ;sbb al,al
        ;mov al, 0
        ;mov al, -2
        ;mov bl, -128
        ;imul al
        
        ;mov bx, [a+5]
        
        ;mov al, -2
        ;mov bl, -128
        ;mul al
        ;or EAX, EAX
        ;mov cl, 11h
        ;rcr ax, cl
        
        
        ;mov al, 255
        ;add al, -1
       
       ;mov ax, 65535
       ;cwd
       ;mov bx, 7
       ;div bx
        
        
        ;mov ax, 65535
        ;mov bl, 10
        ;div bl
        
        
        ;mov ah, 11111111b
        ;mov al, -1
        ;add ah, al
        mul ax
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
