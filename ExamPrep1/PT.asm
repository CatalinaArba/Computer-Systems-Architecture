bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit,scanf,fread,fprintf,printf,fopen,fclose               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import scanf msvcrt.dll
import fread msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    access_mode_writing db "w",0
    access_mode_reading db "r",0
    format_read db "Caracterul c citit este",0
    format_read2 db "Numarul n citit este",0
    file_imput db "pt_imput.txt",0
    file_output db "pt_output.txt",0
    file_descriptor_imput dd -1
    file_descriptor_output dd -1
    format_c db "%c",0
    format_d db "%d",0
    format_x db "%x",0
    c dd -1
    d dd -1
    buffer resb 100
    dest resb 100
    times1 dd -1
    
    
    
    


; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;READING FORM KEYBORD
        ;printing the format_read message
        push dword format_read
        call [printf]
        add esp,4
        
        ;reading the character c
        push dword c
        push dword format_c
        call [scanf]
        add esp,4*2
        
        ;printing the format_read2 message
        push dword format_read2
        call [printf]
        add esp,4
        
        ;reading the number d
        push dword d
        push dword format_d
        call [scanf]
        add esp,4*2
        
        
        ;OPENING THE FILES        
        ;open the output file
        push dword[access_mode_writing]
        push dword file_output
        call [fopen]
        add esp,4*2
        mov [file_descriptor_output],eax
        
        ;open the imput file
        push dword [access_mode_reading]
        push dword file_imput
        call [fopen]
        add esp,4*2
        mov [file_descriptor_imput],eax
        
        ;READING AND PRINTING FROM FILES 
        cmp eax,0
        ;mov edi,0
        je final
            bucla:
                ;reading a letter from the file
                pushad
                push dword [file_descriptor_imput]
                push dword 1
                push dword 1
                push dword buffer
                call [fread]
                add esp,4*4
                popad
                
                ;comparing with the letter c
                cmp eax,c
                jne not_c
                    mov ecx,[d]
                    ;printing in the output file n times c
                    loop_1:
                        mov [times1],ecx
                        pushad
                        push dword [c]
                        push dword format_x
                        push dword [file_descriptor_output]
                        call [fprintf]
                        add esp,4*3
                        popad
                        mov ecx,[times1]
                        ;mov [dest+edi],dword c
                        ;add edi,4
                    loop loop_1
                    jmp was_c
                    
                
                not_c:
                ;mov [dest+edi],dword buffer
                ;add edi,4
                
                ;printing in the output file the character 
                pushad
                push dword [buffer]
                push dword format_x
                push dword [file_descriptor_output]
                call [fprintf]
                add esp,4*3
                popad
                
                was_c:
                
            
            jmp bucla
            end_bucla:
        
        final:
        
        
        
        
        
        ;open the output file
        push dword [file_descriptor_output]
        call [fclose]
        add esp,4
        
        ;open the imput file
        push dword [file_descriptor_imput]
        call [fclose]
        add esp,4
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
