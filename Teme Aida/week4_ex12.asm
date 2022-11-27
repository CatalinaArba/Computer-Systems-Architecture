;Given the words A and B, compute the doubleword C as follows:

   ; the bits 0-6 of C have the value 0
   ; the bits 7-9 of C are the same as the bits 0-2 of A
   ; the bits 10-15 of C are the same as the bits 8-13 of B
   ; the bits 16-31 of C have the value 1 

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
    a dw 0101100011111001b
    b dw 1110000100010100b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        
        mov EBX, 0; we compute the result in EBX
        
        and EBX, 11111111111111111111111110000000b; we force the value of bits 0-6 of the result to the value 0 => EBX = 0000 0000 0000 0000 0000 0000 0000 0000b = 00000000(hex)
        
        mov EAX, 0
        mov AX, [a]
        ;mov EAX, [a]
        and EAX, 00000000000000000000000000000111b
        mov CL, 7
        rol EAX, CL; we rotate 7 positions to the left => EAX = 0000 0000 0000 0000 0000 0000 1000 0000b
        or EBX, EAX; we put the bits in the result => EBX =  0000 0000 0000 0000 0000 0000 1000 0000 = 00000080(hex)
        
        mov EAX, 0
        mov AX, [b]
        ;mov EAX, [b]
        and EAX, 00000000000000000011111100000000b
        mov CL, 2
        rol EAX, CL; we rotate 2 positions to the left => EAX = 0000 0000 0000 0000 1000 0100 0000 0000b
        or EBX, EAX; we put the bits in the result =>     EBX = 0000 0000 0000 0000 1000 0100 1000 0000b = 00008480(hex)
        
        or EBX, 11111111111111110000000000000000b; we force the value of bits 16-31 of the result to the value 1 => EBX = 1111 1111 1111 1111 1000 0100 1000 0000b = FFFF8480(hex)
        
        
        mov [c], EBX
        
  
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
