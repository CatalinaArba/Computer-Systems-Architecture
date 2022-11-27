bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll 
import printf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dd -9
    format db "a = %x (base 16)", 10, 13, 0
    formatdec db "a = %d (base 10)", 10, 13, 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ; A negative number a (a: dword) is given. Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = <base_16> (base 16)" 
        
        push dword [a]
        push dword formatdec
        call [printf]
        add esp, 4*2
        
        
        push dword [a]
        push dword format
        call [printf]
        add esp, 4*2
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
