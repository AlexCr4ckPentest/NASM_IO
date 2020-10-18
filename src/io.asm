; io.asm

%include "../include/io-defs.inc"



global _open
global _close

global _write
global _read
global _fputchar
global _fgetchar
global _putchar
global _getchar
global _fputs
global _fgets
global _puts
global _gets
global _fsetw
global _setw



section .text



; eax - filename
; ebx - flags
_open:
    push ebx
    push ecx
 
    mov ecx, ebx
    mov ebx, eax
    mov eax, 0x5 ; sys_open
    int 0x80

    pop ecx
    pop ebx
    ret



; eax - handle
_close:
    push ebx
    mov ebx, eax
    int 0x80
    pop ebx
    ret



; eax - string
; output: eax - string length
__strlen:
    push ebx
    xor ebx, ebx

    .next:
        cmp [eax+ebx], byte 0x0
        je .end
        inc ebx
        jmp .next

    .end:
        mov eax, ebx
        pop ebx
        ret



; eax - hande
; ebx - buffer
; ecx - count
_write:
    push eax
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
    pop eax
    ret



; eax - handle
; ebx - buffer
; ecx - count
_read:
    push eax
    push ebx
    push ecx
    push edx

    mov edx, ecx ; count
    mov ecx, ebx ; buffer
    mov ebx, eax ; handle
    mov eax, 0x3 ; sys_read
    int 0x80

    mov [ecx + eax - 1], byte 0x0 ; because NULL-terminated string

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret



; eax - handle
; ebx - char
_fputchar:
    push eax
    push ebx

    mov ebx, esp
    mov ecx, 0x1
    call _write

    pop ebx
    pop eax
    ret



; eax - handle
; output: eax - char code
_fgetchar:
    push ebx
    push ecx
    push edx

    mov ebx, eax
    mov eax, 0x3
    push ebx
    mov ecx, esp
    mov edx, 0x1
    int 0x80
    mov eax, [esp]
    pop ebx

    pop edx
    pop ecx
    pop ebx
    ret



; eax - char
_putchar:
    push eax
    push ebx

    mov ebx, eax
    mov eax, STDOUT
    call _fputchar

    pop ebx
    pop eax
    ret



; output: eax - char code
_getchar:
    push ebx

    mov ebx, eax
    mov eax, STDIN
    call _fgetchar

    pop ebx
    ret



; eax - handle
; ebx - string
_fputs:
    push eax
    push ebx
    push ecx

    push eax
    mov eax, ebx
    call __strlen
    mov ecx, eax
    pop eax

    call _write

    ; eax already contains handle after _write
    mov ebx, 0xa
    call _fputchar

    pop ecx
    pop ebx
    pop eax
    ret



; eax - handle
; ebx - buffer
_fgets:
    push eax
    push ebx
    push ecx
    push edx

    xor ecx, ecx
    mov edx, eax

    .read_next:
        mov eax, edx
        call _fgetchar
        cmp eax, 0xa
        je .end
        mov [ebx+ecx], eax
        inc ecx
        jmp .read_next

    .end:
        mov [ebx+ecx], byte 0x0
        pop eax
        pop edx
        pop ecx
        pop ebx
        ret



; eax - string
_puts:
    push eax
    push ebx

    mov ebx, eax
    mov eax, STDIN
    call _fputs

    pop ebx
    pop eax
    ret



; eax - buffer
_gets:
    push eax
    push ebx

    mov ebx, eax
    mov eax, STDOUT
    call _fgets

    pop ebx
    pop eax
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



; eax - count
_setw:
    push eax
    push ebx

    mov ebx, eax
    mov eax, STDOUT
    call _fsetw

    pop ebx
    pop eax
    ret
