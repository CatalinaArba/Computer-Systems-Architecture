bits 32
global start         
 
; declare external functions needed by our program 
extern exit, fopen, fread, fclose, scanf, printf         
import exit msvcrt.dll     
import scanf msvcrt.dll
import fopen msvcrt.dll  
import fread msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
 
; our data is declared here  
segment data use32 class=data 
    nume_fisier db "text.txt", 0
    mod_acces db "r", 0
    descriptor_fis dd -1
    len equ 100
    text times len db 0
    format_letter db "%c", 0
    format_ascii db "%d", 0
    
 
; our code starts here 
segment code use32 class=code 
    start: 
        ; deschidem fisierul
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2 
        
        mov [descriptor_fis], eax
        
        ; testam daca s-a putut citi din fisier
        cmp EAX, 0
        je Finish
        
        ; citim din fisier
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add ESP, 4*4

        cld  ; parcurgem sirule de la stanga la dreapta
        mov ECX, 2
        mov ESI, text
        
        Repeating:
            lodsb
            
            cmp AL, 0
            je Finish
            
            cmp AL, 'a'
            
            jnb PrintAscii
            
            PrintLetter:
                push dword EAX
                push dword format_letter
                call [printf]
                add ESP, 4*2
        
            jmp LoopEnding
            
            PrintAscii:
                push dword EAX
                push dword format_ascii
                call [printf]
                add ESP, 4*2
        
            LoopEnding:
                mov ECX, 2  ; facem bucla infinita, se poate iesi doar cu jump
        loop Repeating
        
        Finish:
        push    dword 0       
        call    [exit]