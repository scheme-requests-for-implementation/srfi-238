(import (gambit))
(begin

  (c-declare "#include \"glue.h\"")

  (define-macro (retrieve-strings which proc)
    (let ((num (string-append which "_numbers"))
          (sym (string-append which "_symbols")))
      `(,proc
        ((c-lambda () nonnull-char-string ,num))
        ((c-lambda () nonnull-char-string ,sym)))))

  (define (signal-alist) (retrieve-strings "signal" strings->alist))
  (define (errno-alist) (retrieve-strings "errno" strings->alist))
  (define errno-message (c-lambda (int) char-string "strerror")))
