; strlen.asm

global _strlen

section .text

; eax - string
; output: eax - length
_strlen:
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
