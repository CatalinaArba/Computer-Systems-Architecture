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
    s db 2, 5, 10, 7, 3, 8
    ls equ $-s
    sum db 0
    two db 2

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; compute sum of all elements
       ; mov ecx, ls
       ; mov esi, 0
       ; mov dl, 0 ; we do the sum in dl
       ; jecxz end_loop
       ; sum1:
       ;    mov al, [s+esi]
       ;     add dl, al
       ;     inc esi
       ; loop sum1
       ; end_loop:
        
       ; mov [sum], dl
     
     
        ; compute sum of even elements
        ;mov ecx, ls
        ;mov esi, 0
        ;mov dl, 0 ; we do the sum in dl
       ; jecxz end_loop
        ;sum1:
       ;     mov al, [s+esi]
        ;    test al, 1 ; and 0000 0001
        ;    jnz oddnr; jump if odd ; ZF = 1 if even
       ;        add dl, al
       ;     oddnr:
       ;     inc esi
       ; loop sum1
       ; end_loop:
      ;  mov [sum], dl
        
        
        ;compute sum of even elements in a string
        mov esi, 0
        mov dl, 0 ; we do the sum in dl
        jecxz end_loop
        sum1:
            mov al, [s+esi]
            ror
            jc
            inc esi
        loop sum1
        end_loop:
        
        mov [sum], dl
        
        ; compute sum of even elements in a string
        mov ecx, ls
        mov esi, 0
        mov dl, 0 ; we do the sum in dl
        jecxz end_loop
        sum1:
            mov al, [s+esi]
            mov ah, 0 ; unsigned conv al->ax
            div byte [two] ; al-quotient, ah-remainder
            cmp ah, 1
            je oddn       ; ah=1, number is odd
            add dl, [s+esi]
            oddn:
            inc esi
        loop sum1
        end_loop:
        
        mov [sum], dl
        
        ;parity flag counts the bits in our lowest byte
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
