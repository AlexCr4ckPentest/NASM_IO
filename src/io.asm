; io.asm

%include "../include/io-defs.inc"
%include "../include/strlen.inc"



global _write
global _read
global _fputchar
global _fgetchar
global _putchar
global _getchar
global _fputs
;global _fgets
global _puts
;global _gets



section .text



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
    push edx

    mov edx, eax

    mov eax, ebx
    call _strlen
    mov ecx, eax

    mov eax, edx
    call _write

    mov eax, edx
    mov ebx, 0xa
    call _fputchar

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret



; eax - handle
; ebx - buffer
_fgets:
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
    ret
