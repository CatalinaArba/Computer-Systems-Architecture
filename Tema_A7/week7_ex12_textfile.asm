bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf, scanf, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll           ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll


; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    fd dd -1
    accmode db "w", 0
    filename db "week7ex12file.txt", 0
    
    format db "Enter number %d ", 10, 13, 0
    n dd 100
    
    formats db "%d", 0
    
    s resb 100
    ls dd 0
    
    format2 db "The numbers are: ", 0
    formatp db "Number is: %d ", 10, 13, 0

    
    
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;A file name is given (defined in the data segment). Create a file with the given name, then read numbers from the keyboard and write those numbers in the file, until the value '0' is read from the keyboard. 
       
       
        ; fopen("week7ex12file.txt", "w")
        push dword accmode
        push dword filename
        call [fopen]
        add esp, 4*2
        
        ; fd = EAX
        
        cmp EAX, 0
        je finish
        
            mov esi, s
            mov ecx, 0
            readuntil0:
                pushad
                
                ;scanf("%d", &n )
                push dword esi
                push dword formats
                call [scanf]
                add esp, 4*2
                
                popad
                
                cmp dword [esi], 0
                je endloop
                add esi, 4
                inc ecx
            jmp readuntil0     
            endloop:
            
            mov [ls], ecx
        
       
            mov [fd], EAX
            
            ;printf("The numbers are: ")
            push dword format2
            push dword [fd]
            call [fprintf]
            add esp, 4*2
            
            mov esi, s
            mov ecx, [ls]
            printing:
                lodsd ; EAX a valua from s
                
                pushad
                
                ; fprintf(fd, "Number is %d: ", n)
                push dword EAX
                push dword formatp
                push dword [fd]
                call [fprintf]
                add esp, 4*3
                    
                popad
            
            loop printing
            
            ; fclose(fd)
            push dword [fd]
            call [fclose]
            add esp, 4
           
        finish:
        
        
        
        
        
        
        
        
        
        
        
      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
