bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    
    a db 70
    b db 50
    c db 100
    d db 25
    

; our code starts here
segment code use32 class=code
    start:
        ; c-(d+d+d)+(a-b) 
        
        mov AH, [d]
        add AH, [d] ; AH <= AH+d = d+d = 25+25 = 50
        
        mov AL, [d]
        add AH, AL ; AH <= AH+AL = 50+25 = 75;  AH = d+d+d
        
        
        mov BH, [c]
        sub BH, AH ; BH = BH-AH = 100-75 = 25 ; BH = c-(d+d+d)
        
        
        mov DH, [a]
        sub DH, [b] ; DH <= DH-b = 70-50 = 20;  DH = a-b
        
        add AH, DH ; AH <= AH+DH = 75+20 = 95 ; AH = c-(d+d+d)+(a-b)
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
