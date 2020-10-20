%include "io-defs.inc"

%ifndef __IO_INC__
%define __IO_INC__

extern _open
extern _close

extern _write
extern _read

extern _fputchar
extern _fgetchar

extern _fputs
extern _fgets

extern _fsetw

%if 0
extern _putchar
extern _getchar
extern _puts
extern _gets
extern _setw
%endif

; linked to stdout
%macro _putchar 1
    mov ebx, %1
    mov eax, STDOUT
    call _fputchar
%endmacro

; linked to stdin
%macro _getchar 0
    mov eax, STDIN
    call _fgetchar
%endmacro

; linked to stdout
%macro _puts 1
    mov ebx, %1
    mov eax, STDOUT
    call _fputs
%endmacro

; linked to stdin
%macro _gets 1
    mov ebx, %1
    mov eax, STDIN
    call _fgets
%endmacro

; linked to stdout
%macro _setw 1
    mov ebx, %1
    mov eax, STDOUT
    call _fsetw
%endmacro

%endif ; __IO_INC__