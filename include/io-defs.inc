%ifndef __IO_DEFS_INC__
%define __IO_DEFS_INC__

; std i/o file descriptors
%define STDOUT  0x1
%define STDIN   0x0
%define STDERR  0x2

; _open flags
%define O_READ_ONLY     0x0
%define O_WRITE_ONLY    0x1
%define O_READ_WRITE    0x2
%define O_APPEND        0x7D0
%define O_TRUNCATE      0x3E8
%define O_CREATE        0x64
%define O_DIRECT        0x9C40
%define O_NOATIME       0xF4240

; _lseek modes
%define SEEK_SET    0x0
%define SEEK_CUR    0x1
%define SEEK_END    0x2

; IO error codes
%define EBADF   0xffffffff

%endif ; __IO_DEFS_INC__