; io.asm

global _write
global _read



section .text



; eax - hande
; ebx - buffer
; ecx - count
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
_read:
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
    ret
