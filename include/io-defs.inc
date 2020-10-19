%ifndef __IOD_DEFS_INC__
%define __IOD_DEFS_INC__

%define STDOUT  0x1
%define STDIN   0x0
%define STDERR  0x2

%define EOF     0xffffffff

%define O_READ_ONLY     00
%define O_WRITE_ONLY    01
%define O_READ_WRITE    02
%define O_APPEND        02000
%define O_TRUNCATE      01000
%define O_CREATE        0100
%define O_DIRECT        040000
%define O_NOATIME       01000000

%endif