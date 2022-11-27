bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    ;Given an array A of doublewords, build two arrays of bytes:  
    ;- array B1 contains as elements the lower part of the lower words from A
    ;- array B2 contains as elements the higher part of the higher words from A
    ; ...
    
    s dd 12345678h, 11223344h, 55667788h
    len_s equ ($-s)/4
    b1 times len_s db 0 
    b2 times len_s db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, s; esi contains the destination of the array s
        cld; clear direction flag
        mov edi,0; edi is de current index of the array b1 and b2
        mov ecx, len_s; ecx will contain the idex of the array a1
        
        repeta:
            lodsw; in ax we will have the low word (least significant) of the current doubleword from the string
            ;ax=5678=>al=78
            mov [b1+edi],al
            
            lodsw; in ax we will have the high word (least significant) of the current doubleword from the string
            ;ax=1234=>ah=0012
            mov [b2+edi],ah
            
            inc edi
        loop repeta
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
