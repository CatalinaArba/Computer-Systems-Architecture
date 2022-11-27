bits 32 ; assembling for the 32 bits architecture

global MMCfunction

MMCfunction:
    mov esi,[esp+4];s1
    mov edi,[esp+8];s2
    mov ecx,[esp+12];len
    mov eax,[esp+16];rez
    
    .do:
        mov bl, [esi]
        mov [eax], bl
        inc eax
        
        inc esi
        mov bl, 0
        mov bl, [edi]
        mov [eax], bl
        inc edi
        inc eax
        
    loop .do
    
    ret 16