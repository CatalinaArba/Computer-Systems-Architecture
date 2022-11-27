bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import printf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 1423h, 8675h, 0ADBCh
    len equ ($-a)
    ;b times len dw 0
    b resb 100
    format db "%x", 10, 13, 0
    number dd 0

; our code starts here
segment code use32 class=code
    start:
        ; An array of words is given. Write an asm program in order to obtain an array of doublewords, 
        ;where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), 
        ;arranged in an ascending order within the doubleword. 
        ; 1432h, 8675h, 0ADBCh, ... = 01020304h, 05060708h, 0A0B0C0Dh, ...
        
        mov esi, a
        cld
        mov ecx, len
        mov edi, b
        mov edx, 0
        do:
            lodsb; al = 23
            mov bl, al
            and al, 00001111b
            mov [edi], al
            inc edi
            ;mov al, 0
            ;lodsb
            mov al, bl
            shr al, 4
            and al, 00001111b
            mov [edi], al
           
            inc edi
            
        loop do
        
        
        mov esi, b
        mov ecx, len
        print:
            mov eax, [esi]
            and eax, 11111111111111111111111111111111b
            mov dword[number], eax
            push ecx
            push dword [number]
            push dword format
            call [printf]
            add esp, 4*2
            add esi, 2
            pop ecx
            
        loop print
       
       
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
