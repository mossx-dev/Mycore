    ;; Author:  Moss Gallagher
    ;; Date:    14-Oct-21

%ifndef _mxs_std_exception_
%define _mxs_std_exception_

%include "std/sys.asm"
%include "std/out.asm"


    exception~runtime~bad_exception_number:         equ 0
    exception~runtime~bad_exception_number_str:     db "Invalid Exception Number", 0xA
    exception~runtime~bad_exception_number_len:     equ $-exception~runtime~bad_exception_number_str
    exception~runtime~bad_arg:                      equ 1
    exception~runtime~bad_arg_str:                  db "Invalid Argument Index", 0xA
    exception~runtime~bad_arg_len:                  equ $-exception~runtime~bad_arg_str


; Args
;   rax: the exception number
; Returns
;   void
exception~runtime~throw:
    push    rax

    cmp     rax, exception~runtime~bad_arg
    je      .case_0

    jmp     .default

    .case_0:
        mov     rax, exception~runtime~bad_arg_str
        mov     rbx, exception~runtime~bad_arg_len
        call    out~puts
        jmp     .switch_end
    .default:
        mov     rax, exception~runtime~bad_exception_number_str
        mov     rbx, exception~runtime~bad_exception_number_len
        call    out~puts
    .switch_end:
    pop     rax
    call sys~exit
    ret


%endif                          ; ifdef guard