bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    sir db 'a', 'a', 'a', 't', 's', 'a', '0', '1', 0
    len equ ($-sir)
    format db "%c", 0
    formatp db "The character %c apears %d times", 0
    s db 0

; our code starts here
segment code use32 class=code
    start:
        ; ...A character string is given (defined in the data segment). 
        ;Read one character from the keyboard, then count the number of occurences of that character 
        ;in the given string and display the character along with its number of occurences. 
    
        push dword s
        push dword format
        call [scanf]
        add esp,4*2
        
        mov cl, byte [s]
      
        mov esi, sir 
        mov ecx, len
        ;mov edi, 0
        mov edx, 0
        do: 
            mov al, byte[esi]
            test al, cl
            jne finish
                inc edx
            finish:
            inc esi
        loop do

        push dword edx
        push dword [s]
        push dword formatp
        call [printf]
        add esp, 4*3
        
   
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
