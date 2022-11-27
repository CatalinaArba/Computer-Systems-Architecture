bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    
    formatp db "Number is %d ", 10, 13, 0
    n dd 100
    formats db "%d", 0
    
    b1 resb 100
    ls dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov edi, 0
        mov esi, b1
        mov ecx, 0
        read0:
            pushad
            ; scanf
            push dword esi
            push dword formats
            call [scanf]
            add esp, 4*2
            
            popad
            cmp dword[esi], 0
            je endl
            
                ;mov [ls], ecx
                ;push dword [esi]
                ;push dword formatp
                ;call [printf]
               ; add esp, 4*2
                
                ;mov ecx, [ls]
                
                mov eax, esi
                lodsw
                mov [ls], ecx
                push dword eax
                push dword formatp
                call [printf]
                add esp, 4*2
                
                
                
                ;mov [b1+edi], al
                
                ;lodsw
                ;mov [b2+edi], ah
                ;inc edi
                
                
                mov ecx, [ls]
                add esi, 4
                inc ecx
                inc edi
        jmp read0
        endl:
            
        mov [ls], edi
        ;mov edi, ecx
        mov esi, b1
        mov ecx, [ls]
        printing:
            lodsd
            
            pushad
            push dword eax
            push dword formatp
            call [printf]
            add esp, 4*2
            
            popad
        
        
        
        loop printing
            
        ; printf
        
            
            
            
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
