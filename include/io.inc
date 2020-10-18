%include "io-defs.inc"

%ifndef __IO_INC__
%define __IO_INC__

extern _write
extern _read

extern _fputchar
extern _fgetchar

extern _putchar ; linked to stdout
extern _getchar ; linked to stdin

extern _fputs
extern _fgets

extern _puts ; linked to stdout
extern _gets ; linked to stdin

extern _fsetw
extern _setw ; linkend to stdout

%endif