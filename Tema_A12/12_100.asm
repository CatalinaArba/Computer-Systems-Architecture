bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,printf,scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll  
import printf msvcrt.dll
import scanf msvcrt.dll
  ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...citeste un numar de la tastatura si tipareste par sau impar
    message db "n=:",0
    format_impar db "The number is impar",0
    format_par db "The number is par",0
    formats db "%d",0
    n dd 10
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push message
        call [printf]
        add esp, 4
        
        push n
        push formats
        call [scanf]
        add esp, 4*2
        
        mov eax,[n]
        test eax,01h;if eax is par
        jpe par; jump to par if condition is met
        push format_impar
        call [printf]
        add esp,4*2
        jmp endl; if the number was impar jump to endl in order to skipm the par printing
        
        par:
        push format_par
        call [printf]
        add esp,4*2
        
        endl:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
