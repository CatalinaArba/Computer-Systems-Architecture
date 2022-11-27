bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 15
    b dw 50
    c db 10
    d dd 100
    x dq 250

; our code starts here
segment code use32 class=code
    start:
        ; (a*b+2)/(a+7-c)+d+x; a,c-byte; b-word; d-doubleword; x-qword
        ; unsigned
        
        ;mov AL, [a]
        ;mov AH, 0; unsigned conversion from AL to AX
        ;mov DX, 0; unsigned conversion from AX to DX:AX
        ;DX:AX = a
        ;mul word[b]; unsigned multiplication DX:AX by b ; AX = a*b
        
        ;add AX, 2; AX <- AX+2 = 752; AX = a*b+2
        
        ;mov BL, [a]
        ;add BL, 7; AL <- AL+7 = 15+7 = 22
        ;sub BL, [c]; AL <- AL-c = 22-10 = 12
        
        ;div byte BL; AL = AX/BL = 62; AH = AX%BL = 8; AL = (a*b+2)/(a+7-c)
        
        ;add AL, 7; AL <- AL+7 = 62+7 = 69; AL = (a*b+2)/(a+7-c)+d
        
       ; mov BL, AL
        ;mov EAX, 0; EDX:EAX = AL
        ;mov AL, BL
        ;mov EBX, [x]
        ;add EBX, EAX; EBX <- EBX+EAX = 69+ 250 = 319 ; EBX = (a*b+2)/(a+7-c)+d+x
        
        ; signed 
        ;(a*b+2)/(a+7-c)+d+x
        
        mov AL, [a]
        cbw; signed conversion from AL to AX
        cwd; signed conversion from AX to DX:AX
        ; DX:AX = a
        imul word [b]; signed multiplication  ; AX = a*b
        adc AX, 2; AX <- AX+2 = 750 + 2 = 750 ; AX = a*b +2
        
        
        mov BL, [a]
        adc BL, 7; BL  <- BL + 7 = 15+7 = 22
        sbb BL, [c]; BL<- BL - c = 22 - 10 = 12
        
        push AX
        pop AX
        
        idiv byte BL;  AL = AX/BL = 62; AH = AX%BL = 8; AL = (a*b+2)/(a+7-c)
        
        adc AL, 7; AL <- AL+7 = 62+7 = 69; AL = (a*b+2)/(a+7-c)+d
        
        mov BL, AL
        cwd
        cwde
        cdq
        ;mov EBX, dword [x+0]
        ;mov ECX, dword [x+4]
        ;adc EAX, EBX
        mov AL, BL
        mov EBX, [x]
        adc EAX, EBX
        
        
        
        

        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
