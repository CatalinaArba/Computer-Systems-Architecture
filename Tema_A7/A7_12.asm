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
    ; ...
    format1 db "a=-%d (base 10), a=" ,0
    format2 db "%x|" ,0
    format3 db "(base 16)",0
    a dd 1111010100111001b;0000101011000111
    b dd 0
    d dd 0
    e times 4 db 0
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...A negative number a (a: dword) is given. Display the value of that number in base 10 and in the base 16 in the following format: "a = <base_10> (base 10), a = <base_16> (base 16)"
        mov eax,[a]
        ;mov eax,2
        xor eax,1110111111111111b
        add eax, 0000000000000001b
        
        mov dword[a],eax
        push eax
        push format1
        call[printf]
        mov eax,dword[a]
        add esp,4*2
        mov edi, 3
        mov ECX,4; the loop will be repeted 4 times
        Repeta1:   
            mov ebx,0; we compute the result in ebx
            ;DIGIT 1
            test al,1
            jpe done
                add ebx,1
            done:
            shr eax,1;we rotate the bits to left with one position                                   
            
            test al,1
            jpe done2
                add ebx,2
            done2:
            shr eax,1
            
            test al,1
            jpe done3
                add ebx,4
            done3:
            shr eax,1
            
             test al,1
            jpe done4
                add ebx,8
            done4:
            shr eax,1
            
            mov dword[d],ecx
            mov dword[a],eax
            mov [e+edi],ebx
            push dword [e+edi]
            push format2
            call [printf]
            add esp, 4*2
            mov ecx,dword[d]
            mov eax,dword[a]
            dec edi
        loop Repeta1
        
        mov ecx,4
        mov edi,0
        repeta2:
            mov dword[d],ecx
            push dword [e+edi]
            push format2
            call [printf]
            add esp,4*2
            mov ecx,dword[d]
            inc edi
        loop repeta2
        
        
        push format3
        call [printf]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
