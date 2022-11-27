bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "The permutation is:%x",10,13,0
    n dd 0
    cn dd 100;the copy of n
    formats db "%d",0
    m db "The number is:",0

; our code starts here
segment code use32 class=code
    start:
    ;prinf 
    push dword m
    call [printf]
    add esp,4
    ;scanf(%d,&n)
    push dword n
    push dword formats
    call [scanf]
    add esp,4*2
    
    mov eax,[n]
    mov edx,[n]
    
    permutation:   
        
        mov [cn],eax
        pushad
        push dword eax
        push dword format
        call [printf]
        add esi,4*2
        popad
        mov eax,[cn]
        ;mov eax,[cn]
        rol eax,4
        mov edx,[n]
        cmp dword eax,dword edx
        je endofprogram
    jmp permutation
    endofprogram:

    
        
        
    
    
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
