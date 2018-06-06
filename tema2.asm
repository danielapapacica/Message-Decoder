
extern puts
extern printf

section .data
filename: db "./input.dat",0
inputlen: dd 2263
fmtstr: db "Key: %d",0xa,0

section .text
global main

; TODO: define functions and helper functions

; FUNCTION FOR A STRING LENGTH
STR_LENGTH:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    xor ecx, ecx
test_one_byte:
    mov bl, byte [eax]
    test bl, bl
    je out
    inc eax
    inc ecx
    jmp test_one_byte

out:
    mov eax, ecx

    leave
    ret


; FUNCTION FOR XOR BETWEEN 2 STRINGS. TASK 1
xor_strings:
   push ebp
   mov ebp, esp

    mov eax, [ebp + 8]      ; string to decript
    mov ebx, [ebp + 12]     ; key_string
    
xor_on_byte:
    mov dh, byte[ebx]
    mov dl, byte[eax]
    xor dl, dh
    mov byte[eax], dl
    inc eax
    inc ebx
    mov dl, byte[eax]
    test dl, dl
    jnz xor_on_byte

    leave
    ret

; FUNTION FOR ROLLING XOR. TASK 2
rolling_xor:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    
rol_xor_on_byte:
    mov ch, byte[eax]
    dec eax
    mov cl, byte[eax]
    xor ch, cl
    inc eax
    mov byte[eax], ch
    dec eax
    mov dl, byte[eax]
    test dl, dl
    jnz rol_xor_on_byte
    
    leave 
    ret    


; FUNCTION FOR CONVERTING FROM HEX. TASK 3
convert_binary:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    mov eax, ebx
convert_on_byte:
    xor ch,ch
    mov dl, byte[ebx]   ; Convert first character
    test dl,dl
    jz convert_out
    cmp dl, 97
    jge litere_task3
    jl cifre_task3
continue_conv:
    push eax
    mov al, dl
    mov dh, 16          ; Multiply by 16
    mul dh
    mov dh, al          ; dh contains the result
    pop eax
    inc ebx
    
    mov dl, byte[ebx]   ; Convert second character
    test dl,dl
    jz convert_out
    mov ch, 1
    cmp dl, 97
    jge litere_task3
    jl cifre_task3
continue_conv2:
    add dl, dh
    mov byte[eax], dl
    inc eax
    inc ebx
    jmp convert_on_byte
    
litere_task3:
    sub dl, 87
    cmp ch, 1
    je continue_conv2
    jmp continue_conv
    
cifre_task3:
    sub dl, 48
    cmp ch, 1
    je continue_conv2
    jmp continue_conv
    
convert_out:
    leave
    ret



; FUNCTION FOR DECODING BASE32. TASK 4
base32_decode:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    sub esp,2000    ; alloc memory
    xor edx, edx
    xor eax, eax
    xor esi, esi
    
    dec ebx
save_groups_of_5:
    inc ebx
    mov al, byte[ebx]
    cmp al, 0
    je next_task4
    cmp al, 61
    je equal_sign
    cmp al, 65
    jl cifre_task4
    jge litere_task4
    
; put each of the 5 bits on stack
continue_task4:
    mov edi, 5
find_bits_task4:
    xor edx, edx
    mov ecx, 2
    div ecx
    mov ecx, esi
    add ecx, edi
    mov byte[esp + ecx], dl
    dec edi
    cmp edi, 0
    jg find_bits_task4
   
    add esi, 5 ; esi is the number of bits on stack
    jmp save_groups_of_5
    
equal_sign:
    mov al,0
    jmp continue_task4
cifre_task4:   
    sub al, 24
    jmp continue_task4
litere_task4:
    sub al,65
    jmp continue_task4


next_task4:
    mov ebx, [ebp + 8]
    xor edi,edi
    add esp, 1
    
put_from_stack_on_string:
    xor edx, edx
    mov ecx,1
    mov dl, byte[esp]
    inc edi
for_each_8_bits:
    mov al, byte[esp + ecx]
    inc edi
    shl edx, 1
    add dl, al
    inc ecx
    cmp ecx, 8
    jl for_each_8_bits
    
    mov byte[ebx], dl
    inc ebx
    add esp, 8
    
    cmp edi, esi
    jl put_from_stack_on_string
    
    leave
    ret


; ADDITIONAL FUNCTION FOR TASK 5. XOR WITH BYTE KEY 
xor_with_byte_key:
    push ebp
    mov ebp, esp
    
    mov ebx, [ebp + 8]      ; string to decript
    mov ecx, [ebp + 12]     ; key_string
    
xor_on_byte_task5:
    mov dl, byte[ebx]
    xor dl, cl
    mov byte[ebx], dl
    inc eax
    inc ebx
    mov dl, byte[ebx]
    test dl, dl
    jnz xor_on_byte_task5

    leave
    ret
    

; FUNCTION FOR BRUTEFORCE XOR. TASK 5
bruteforce_singlebyte_xor:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 12] ; key address
    xor ecx, ecx
    xor edx, edx
    mov cl, 255
    
try_keys:
    mov ebx, [ebp + 8]  ; my string
try_on_byte:
    mov dl, byte[ebx]
    test dl, dl
    jz continue_task5
continue_with_this_key:
    xor dl, cl
    cmp dl, 102
    je found_f      ; Found "f" letter  
    inc ebx
    jmp try_on_byte

continue_task5:  
    loop try_keys

found_f:        ; Founf "f", now searching for the rest of the substring
    inc ebx 
    mov dl, byte[ebx]
    test dl, dl
    jz continue_task5
    xor dl, cl
    cmp dl, 111         ; search for "o"
    jne continue_with_this_key
    
    inc ebx 
    mov dl, byte[ebx]
    xor dl, cl
    test dl, dl
    jz continue_task5
    cmp dl, 114         ; search for "r"
    jne continue_with_this_key
    
    inc ebx 
    mov dl, byte[ebx]
    xor dl, cl
    test dl, dl
    jz continue_task5
    cmp dl, 99        ; search for "c"
    jne continue_with_this_key
    
    inc ebx 
    mov dl, byte[ebx]
    xor dl, cl
    test dl, dl
    jz continue_task5
    cmp dl, 101         ; search for "e"
    jne continue_with_this_key
    
    ; Now that we found the key, we can decode the string
    mov byte[eax], cl
    push eax
    push ecx
    mov ebx,[ebp + 8]
    push ebx
    call xor_with_byte_key
    pop ebx
    add esp, 4
    
    pop eax
    leave
    ret
    

; FUNCTION WHICH CREATES SUBSTITUTION TABLE FOR TASK 6
create_substitution_table:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8] ; table address
    
    ; Put each letter
    mov byte[ebx], 'a'
    inc ebx
    mov byte[ebx], 'q'
    inc ebx
    mov byte[ebx], 'b'
    inc ebx
    mov byte[ebx], 'r'
    inc ebx
    mov byte[ebx], 'c'
    inc ebx
    mov byte[ebx], 'w'
    inc ebx
    mov byte[ebx], 'd'
    inc ebx
    mov byte[ebx], 'e'
    inc ebx
    mov byte[ebx], 'e'
    inc ebx
    mov byte[ebx], ' '
    inc ebx
    mov byte[ebx], 'f'
    inc ebx
    mov byte[ebx], 'u'
    inc ebx
    mov byte[ebx], 'g'
    inc ebx
    mov byte[ebx], 't'
    inc ebx
    mov byte[ebx], 'h'
    inc ebx
    mov byte[ebx], 'y'
    inc ebx
    mov byte[ebx], 'i'
    inc ebx  
    mov byte[ebx], 'i'
    inc ebx   
    mov byte[ebx], 'j'
    inc ebx
    mov byte[ebx], 'o'
    inc ebx   
    mov byte[ebx], 'k'
    inc ebx      
    mov byte[ebx], 'p'
    inc ebx    
    mov byte[ebx], 'l'
    inc ebx
    mov byte[ebx], 'f'
    inc ebx   
    mov byte[ebx], 'm'
    inc ebx               
    mov byte[ebx], 'h'
    inc ebx          
    mov byte[ebx], 'n'
    inc ebx 
    mov byte[ebx], '.'
    inc ebx
    mov byte[ebx], 'o'
    inc ebx                              
    mov byte[ebx], 'g'
    inc ebx
    mov byte[ebx], 'p'
    inc ebx    
    mov byte[ebx], 'd'
    inc ebx
    mov byte[ebx], 'q'
    inc ebx
    mov byte[ebx], 'a'
    inc ebx
    mov byte[ebx], 'r'
    inc ebx  
    mov byte[ebx], 's'
    inc ebx     
    mov byte[ebx], 's'
    inc ebx          
    mov byte[ebx], 'l'
    inc ebx      
    mov byte[ebx], 't'
    inc ebx  
    mov byte[ebx], 'k'
    inc ebx
    mov byte[ebx], 'u'
    inc ebx      
    mov byte[ebx], 'm'
    inc ebx
    mov byte[ebx], 'v'
    inc ebx    
    mov byte[ebx], 'j'
    inc ebx
    mov byte[ebx], 'w'
    inc ebx       
    mov byte[ebx], 'n'
    inc ebx
    mov byte[ebx], 'x'
    inc ebx        
    mov byte[ebx], 'b'
    inc ebx        
    mov byte[ebx], 'y'
    inc ebx       
    mov byte[ebx], 'z'
    inc ebx
    mov byte[ebx], 'z'
    inc ebx     
    mov byte[ebx], 'v'
    inc ebx
    mov byte[ebx], ' '
    inc ebx     
    mov byte[ebx], 'c'
    inc ebx
    mov byte[ebx], '.'
    inc ebx      
    mov byte[ebx], 'x'
    inc ebx
    mov byte[ebx],0
    
    leave
    ret
    
; FUNCTION FOR TASK 6
break_substitution:
    push ebp
    mov ebp, esp
    
    mov ecx, [ebp + 8]      ; my string
    mov ebx, [ebp + 12]     ; substitution table

    
    xor edx, edx
substitute_on_bye:  
    mov dl, byte[ecx]
    test dl,dl
    jz out_task6
    mov eax, ebx
    inc eax
search_byte_in_table:
    mov dh, byte[eax]
    cmp dh, dl
    je found_subst_letter
    add eax, 2
    jmp search_byte_in_table
 
continue_task6:   
    inc ecx
    jmp substitute_on_bye
    
found_subst_letter:
    dec eax
    mov dh, byte[eax]
    mov byte[ecx],dh
    jmp continue_task6
    
out_task6:
    leave
    ret

;--------------------------------------------------------------------------------------------------------------


; MAIN FUNCTION
main:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp
    sub esp, 2300
    
    ; fd = open("./input.dat", O_RDONLY);
    mov eax, 5
    mov ebx, filename
    xor ecx, ecx
    xor edx, edx
    int 0x80
    
	; read(fd, ebp-2300, inputlen);
	mov ebx, eax
	mov eax, 3
	lea ecx, [ebp-2300]
	mov edx, [inputlen]
	int 0x80

	; close(fd);
	mov eax, 6
	int 0x80

	; all input.dat contents are now in ecx (address on stack)
       

; TASK 1
    ; Get the length of string and key
        push ecx
        call STR_LENGTH
        pop ecx

    ; Perform xor between string and key
       push eax ; to save the value of the length
       mov edx, ecx
       add edx, eax
       inc edx
	push edx     ; push key string
	push ecx     ; push my string
	call xor_strings
       pop ecx
	add esp, 4
        

    ;Print the first resulting string
	push ecx
	call puts
	pop ecx

    ; Move ecx to the next string for Task2
       pop eax 
       add ecx, eax ; step over first string
       add ecx, eax ; step over second string
       add ecx, 2   ; step over spaces "0"
       
       
; TASK 2: Rolling XOR

    ; Get the length of string
        push ecx
        call STR_LENGTH
        pop ecx

    ; Perform rolling xor
       push eax
       add ecx, eax ; starting from the end of string
	push ecx
	call rolling_xor
	pop ecx

    ; Mov ecx back to the beginning of string
       mov byte[ecx], 0
       pop eax
       sub ecx, eax

    ; Print the second resulting string
	push ecx
	call puts
	pop ecx

    ; Move ecx to the next string for Task2
       add ecx, eax ; step over first string

	
; TASK 3: XORing strings represented as hex strings

        ; Get the length of string and key
        push ecx
        call STR_LENGTH
        pop ecx
        
        ; Convert to binary first string
	 push eax ; to save the value of the length   
	 push ecx     ; push my string
	 call convert_binary
        pop ecx
	 pop eax
        
        ; Convert to binary key
        push eax ; to save the value of the length
        push ecx ; to save the first string
        mov edx, ecx
        add edx, eax
        inc edx
	 push edx     ; push key string
        call convert_binary
        pop edx
        pop ecx
        pop eax   
        
       ; Perform xor between string and key
       push eax ; to save the value of the length
	push edx     ; push key string
	push ecx     ; push my string
	call xor_strings
       pop ecx
	add esp, 4
       
       
	;Print the resulting string
	push ecx
	call puts
	pop ecx

       ; Move ecx to the next string for Task4
       pop eax 
       add ecx, eax ; step over first string
       add ecx, eax ; step over second string
       add ecx, 2   ; step over spaces "0"
	
; TASK 4: decoding a base32-encoded string

        ; Get the length of string
        push ecx
        call STR_LENGTH
        pop ecx
        
        ;Perform base32 decoding
        push eax
        push ecx
        call base32_decode
        pop ecx 
        pop eax       

	; Print the string
       push eax
	push ecx
	call puts
	pop ecx
       pop eax
       
       ; Move ecx to the next string for Task5
       add ecx, eax ; step over string
       inc ecx ; step over space

; TASK 5: Find the single-byte key used in a XOR encoding
       
       ; Alloc memory for single-byte key
       sub esp, 4
       mov ebx, esp
       mov byte[ebx], 0
    
       ; Call function
	push ebx
	push ecx
	call bruteforce_singlebyte_xor
	pop ecx
       pop ebx


	; Print the fifth string and the found key value
	push ecx
	call puts
       
       xor edx, edx
       mov dl, byte[ebx]
	push edx
	push fmtstr
	call printf
	add esp, 8

       ; Get the length of string
       call STR_LENGTH
       pop ecx
       
       ; Move ecx to the next string for Task6
       add ecx, eax ; step over string
       inc ecx ; step over space
        
; TASK 6: Break substitution cipher

       ; Alloc memory for substitution table
       sub esp, 56
       mov ebx, esp
       
       ; Create the table
       push ebx
       call create_substitution_table
       pop ebx
       
       ; Decode the string
	push ebx
	push ecx
	call break_substitution
	pop ecx
       pop ebx

	; Print final solution (after some trial and error)
	push ecx
	call puts
	add esp, 4

	; Print substitution table
	push ebx
	call puts
	add esp, 4

	; Phew, finally done
    xor eax, eax
    leave
    ret
