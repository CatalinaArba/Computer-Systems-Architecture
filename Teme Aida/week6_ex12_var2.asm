bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;s dd 12343215h, 23879933h, 13982763h, 87625189h
    ;len equ ($-s)/4
    ;b1 times len db 0
    ;b2 times len db 0
    
    sir resb 100
    formats db "%d ", 0
    ls db 0
    b1 resb 100
    b2 resb 100
    n dd 100
    
    formatp db "number is %d", 10, 13, 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; - array B1 contains as elements the lower part of the lower words from A
        
        mov esi, b1
        mov ecx, 0
        ;mov edi, 0
        readuntil0:
            pushad
            
            ;scanf
            push dword esi
            push dword formats
            call [scanf]
            add esp, 4*2
            
            popad
            cmp dword[esi], 0
            je endl
                
                ; printf
                push dword esi
                push dword formatp
                call [printf]
                add esp, 4*2
                
                
                ;mov eax, esi
                ;lodsw
                ;mov [b1+edi], al
                
                ;lodsw
                ;mov [b2+edi], ah
                ;inc edi
                
                add esi, 4
                inc ecx
        jmp readuntil0
        endl:
        
        ;mov [ls], edi
        ;mov esi, b1
        ;mov ecx, [ls]
        ;printing:
        ;    lodsd
        ;    push dword eax
         ;   push dword formatp
         ;   call [printf]
         ;   add esp, 4*2
            
        ;loop printing
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        ;mov ESI, s; in eds:edi we will store the FAR address of the string s
        ;cld; parse the string from left to right (DF=0) clear direction flag
        ;mov ECX, len
        ;mov EDI, 0
        ;do:
        ;    lodsw; in ax we will have the low word (least significant) of the current doubleword from the string
            
            ; ax= 3215; al=15
        ;    mov [b1+edi], al
            
        ;    lodsw
            ;ax=1234; ah=12
        ;    mov [b2+edi], ah
        ;    inc edi
                   
        ;loop do ; if there are more elements (ecx>0) resume the loop
        
        ;mov DX, b1
        
        
    
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
