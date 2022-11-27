bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)


global MMCmystringf

;MMCmystringf(s1, s2, len, rez)
;- 4 parameters, s1 and s2 - strings of bytes, len - int, rez - empty string of bytes
;- s1, s2 are input, rez is output
;- len is input, the lenghts of the arrays
;- in reverse order on the stack
;- uses esi, edi, ecx, ebx
;-return in ebx the string


MMCmystringf:
    ;[esp] contains the returned address
    
    ;mov esi, [esp+4]; s1
    ;mov edi, [esp+8]; s2
    ;mov ecx, [esp+12]; len
    ;mov ebx, [esp+16]; rez
    
    mov esi, [esp+4]; s1
    mov ebx, [esp+8]; s2
    mov ecx, [esp+12]; len
    mov edi, [esp+16]; rez
    
    
    mov edx, 0
    jecxz end_l
    
    loop_repeta:
        mov edi, [esi+edx]
        inc edx
        mov edi, [edi+edx]
        ;movsb
        
    loop loop_repeta
    end_l:
    
    ret 16
    
    



