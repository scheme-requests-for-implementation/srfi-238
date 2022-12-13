(import (gambit))
(begin

  (define (strings->alist numbers symbols)
    (define (parse convert string)
      (let loop ((parts '()) (a 0) (b 0))
        (cond ((= b (string-length string))
               (reverse parts))
              ((char=? #\, (string-ref string b))
               (let ((part (convert (string-copy string a b))))
                 (loop (cons part parts) (+ b 1) (+ b 1))))
              (else
               (loop parts a (+ b 1))))))
    (list-sort
     (lambda (a b) (< (car a) (car b)))
     (map cons
          (parse string->number numbers)
          (parse string->symbol symbols))))

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
