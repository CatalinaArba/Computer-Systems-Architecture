bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,fopen,fread,printf,fclose,fprintf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import fopen msvcrt.dll 
import fread msvcrt.dll 
import printf msvcrt.dll
import fclose msvcrt.dll 
import fprintf msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    file_name db "file.txt",0
    file_print db "print.txt",0
    access_mode db "r",0
    access_modde_write db "w",0
    descriptor_file dd -1
    
    descriptor_file_print dd -1
    len equ 1
    buffer resb 100
    format db "%s",0
    formatx db "X",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;A file name and a text (defined in the data segment) are given. The text contains lowercase letters, uppercase letters, digits and special characters. Replace all the special characters from the given text with the character 'X'. Create a file with the given name and write the generated text to file.
        
        ;open the file
         push dword access_modde_write
        push dword file_print
        call [fopen]
        add esp,4*2
        mov [descriptor_file_print],eax
        
        push dword access_mode
        push dword file_name
        call [fopen]
        add esp,4*2
        mov [descriptor_file],eax
       
        
        
        cmp eax,0
        je final
        
         
        bucla:
            push dword [descriptor_file]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp,4*4
            ;mov [buffer+eax],byte 0
            cmp eax,0
            je clean_up
            cmp dword[buffer],'A'
            jb next_char
                cmp dword[buffer],'Z'
                ja next_char
                push dword buffer
                push dword [descriptor_file_print]
                call [fprintf]
                add esp,4*2
                jmp it_was_a_letter
            next_char:
            
            push dword formatx
            push dword[descriptor_file_print]
            call [fprintf]
            add esp,4*2
            it_was_a_letter:
            
            
        jmp bucla    
        clean_up:    
        
        
        ;fclose
        push dword [descriptor_file]
        call [fclose]
        add esp,4
        push dword [descriptor_file_print]
        call [fclose]
        add esp,4
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
