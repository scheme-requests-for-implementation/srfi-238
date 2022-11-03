(import (scheme base)
        (scheme file)
        (scheme read)
        (scheme write))

(define disp
  (lambda args
    (for-each display args)
    (newline)))

(define (read-all)
  (let loop ((xs '()))
    (let ((x (read)))
      (if (eof-object? x)
          (reverse xs)
          (loop (cons x xs))))))

(define (gen out in)
  (let ((symbols (with-input-from-file in read-all)))
    (with-output-to-file out
      (lambda ()
        (for-each (lambda (symbol)
                    (disp "#ifdef " symbol)
                    (disp "    XX(" symbol ")")
                    (disp "#endif"))
                  symbols)))))

(define main
  (lambda ignored
    (gen "errnolist.h"
         "errnolist.txt")
    (gen "signallist.h"
         "signallist.txt")))

(main)
