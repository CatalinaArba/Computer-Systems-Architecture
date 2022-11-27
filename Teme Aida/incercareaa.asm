bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
	format_string db "%s", 0
	sir1 db 'a', 'b', 'c', 'd', 0
    sir2 db 'e', 'f', 'g', 'h', 0
    len equ ($-sir2)
    
    rez times 2*len db 0
	
; our code starts here
segment code use32 class=code
    start:
        ; ...

		mov ecx, len
		mov esi, sir2
		mov eax, sir1
		mov edi, rez
		do:
			mov bl, [esi]
			mov [edi], bl
			inc edi
			
			inc esi
			mov bl, 0
			mov bl, [eax]
			mov [edi], bl
			inc edi
			inc eax
			
		loop do
		;mov [rez], edi
		
		;mov eax, 0
		;mov eax, rez
		
		push dword eax
		push dword format_string
		call [printf]
		add esp, 4*2

		
		
		
		


		


		
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
