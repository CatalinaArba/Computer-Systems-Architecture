bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf
import printf msvcrt.dll
import scanf msvcrt.dll            ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...read a string and make all the caracters uppercase
    format1 db "How many characters do you want to read?",0
    formats db"%d",0
    formatc db "%c",0
    s resb 100
    len dd 0
    index dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push format1
        call[printf]
        add esp, 4
        
        push len
        push formats
        call[scanf]
        add esp,4*2
        
        mov esi,s
        mov ecx, [len]
        
        jecxz end_program
        loop_start:
            mov [index],ecx
            
            pushad
            push esi
            push formatc
            call[scanf]
            add esp,4*2
            popad
            
            mov eax,[esi]
            mov ebx,'a'-'A'
            sub eax,ebx
            mov [esi],eax
            add esi,4
            mov ecx,[index]
            
        loop loop_start
        end_program:
    
        mov ecx,[len]
        mov esi,s
        jecxz end_program_2
        loop_start1:
            mov [index],ecx
            lodsd
            
            pushad
            push dword eax
            push formatc
            call[printf]
            add esp, 4*2
            popad
            mov ecx,[index]
            
        loop loop_start1
        end_program_2:
   
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
