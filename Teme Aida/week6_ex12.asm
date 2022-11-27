;Given an array A of doublewords, build two arrays of bytes:  
; - array B1 contains as elements the lower part of the lower words from A
; - array B2 contains as elements the higher part of the higher words from A 


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
              ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    s dd 12343215h, 23879933h, 13982763h, 87625189h
    len equ ($-s)/4
    b1 times len db 0
    b2 times len db 0

    

; our code starts here
segment code use32 class=code
    start:
        ; ...; - array B1 contains as elements the lower part of the lower words from A
        

        mov esi, s; in esi we will store the far address of the string s
        cld; parse the string from left to right (DF=0)
        mov ecx, len
        mov edi, b1 ; store the far address of the destinaiton d
        do:
            lodsw; in ax we will have the low word (least significant) of the current doubleword from the string
            ; ax = 3215; 
            ;al = 15

            mov [edi], al
 
        
            lodsw
            ;inc esi
            ;inc esi
            inc edi
            
                    
        loop do ; if there are more elements (ecx>0) resume the loop
        
        
        ; - array B2 contains as elements the higher part of the higher words from A
        
        mov esi, 0
        mov esi, s
        mov ecx, 0
        mov ecx, len
        mov edi, b2
        do1:
            lodsw; in ax we will have the low word of the current doubleword from the string
            lodsw ; in ax we will have the high word (least significant) of the current doubleword from the string
            ;ax = 1234
            ;ah=12
            mov [edi], ah
            
            inc edi
            ;stosb
            
            
        loop do1

         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
