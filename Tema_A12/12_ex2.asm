bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import printf msvcrt.dll
import scanf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format1 db "How many numbers do you want to read?",0
    format2 db"%d",0
    format3 db "the number is:%d",10,13,0
    n dd 0
    s resb 100
    len dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push format1
        call [printf]
        add esp,4
        
        push n
        push format2
        call [scanf]
        add esp, 4*2
        
        mov ecx,[n]
        mov esi,s
        
        start_loop:
            mov [len],ecx
            
            pushad
            push dword esi
            push format2
            call [scanf]
            add esp,4*2
            popad
            
            add esi,4
            mov ecx,[len]
        loop start_loop
        
        mov ecx,[n]
        mov esi,s
        start_loop2:
            mov [len],ecx
            lodsd
            
            pushad
            push dword eax
            push format3
            call [printf]
            add esp,4*2
            popad
            
            mov ecx,[len]
        loop start_loop2
            
            
            
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
