; io.asm

%include "../include/io-defs.inc"



global _open
global _close
global _lseek

global _write
global _read

global _fputchar
global _fgetchar

global _fputs
global _fgets

global _fsetw



section .text



; eax - filename
; ebx - flags
; ecx - mode
; output: eax - handle
_open:
    push ebx
    push ecx
    push edx
 
    mov edx, ecx
    mov ecx, ebx
    mov ebx, eax
    mov eax, 0x5 ; sys_open
    int 0x80

    pop edx
    pop ecx
    pop ebx
    ret



; eax - handle
_close:
    push eax
    push ebx

    mov ebx, eax
    mov eax, 0x6
    int 0x80

    pop ebx
    pop eax
    ret



; eax - handle
; ebx - offset
; ecx - from where
_lseek:
    push ebx
    push ecx
    push edx

    mov edx, ecx ; from where
    mov ecx, ebx ; offset
    mov ebx, eax ; handle
    mov eax, 0x13 ; sys_lseek
    int 0x80

    pop edx
    pop ecx
    pop ebx
    ret



; eax - hande
; ebx - buffer
; ecx - count
; output: eax - written bytes count
_write:
    push ebx
    push ecx
    push edx
    
    mov edx, ecx ; count
    mov ecx, ebx ; buffer
    mov ebx, eax ; handle
    mov eax, 0x4 ; sys_write
    int 0x80

    pop edx
    pop ecx
    pop ebx
    ret



; eax - handle
; ebx - buffer
; ecx - count
; output: eax - read bytes count
_read:
    push ebx
    push ecx
    push edx

    mov edx, ecx ; count
    mov ecx, ebx ; buffer
    mov ebx, eax ; handle
    mov eax, 0x3 ; sys_read
    int 0x80

    pop edx
    pop ecx
    pop ebx
    ret



; eax - handle
; ebx - char
; output: eax - written bytes count (1)
_fputchar:
    push ecx
    push edx
    push ebx

    mov ecx, esp
    mov ebx, eax
    mov eax, 0x4
    mov edx, 0x1 ; one byte to write
    int 0x80

    pop ebx
    pop edx
    pop ecx
    ret



; eax - handle
; output: eax - char code
_fgetchar:
    push ebx
    push ecx
    push edx

    sub esp, 0x1

    lea ecx, [esp-1]
    mov ebx, eax
    mov eax, 0x3
    mov edx, 0x1
    int 0x80

    movzx eax, byte [esp-1]
    add esp, 0x1

    pop edx
    pop ecx
    pop ebx
    ret



; eax - handle
; ebx - string
; output: eax - written bytes count
_fputs:
    push ebx
    push edx
    push esi

    mov edx, eax ; handle
    lea esi, dword [ebx]

    .write_next:
        mov eax, edx
        movzx ebx, byte [esi]
        call _fputchar
        inc esi
        test bl, bl ; while (*ptr)
        jne .write_next

    mov eax, edx
    mov ebx, 0xa
    call _fputchar

    mov eax, 0x1

    pop esi
    pop edx
    pop ebx
    ret



; eax - handle
; ebx - buffer
; output: eax - read bytes count
_fgets:
    push ebx
    push edi

    lea edi, dword [ebx]
    mov ebx, eax

    .read_next:
        mov eax, ebx
        call _fgetchar
        cmp eax, 0xa
        je .end
        mov [edi], eax
        inc edi
        jmp .read_next

    .end:
        mov [edi], byte 0x0

    mov eax, 0x1

    pop edi
    pop ebx
    ret



; eax - handle
; ebx - count
_fsetw:
    push eax
    push ebx
    push ecx

    mov ecx, eax

    .next:
        cmp ebx, 0x0
        je .end
        mov eax, ecx
        push ebx
        mov ebx, 0x20 ; space
        call _fputchar
        pop ebx
        dec ebx
        jmp .next

    .end:
        pop ecx
        pop ebx
        pop eax
        ret
