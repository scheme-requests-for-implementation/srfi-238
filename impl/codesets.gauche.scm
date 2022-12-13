(import (only (srfi 1)
              filter-map
              iota)
        (only (gauche base)
              sys-errno-list
              sys-signal-name
              sys-strerror
              sys-symbol->errno))
(begin

  (define (signal-alist)
    (filter-map (lambda (num)
                  (let ((str (sys-signal-name num)))
                    (and str (cons num (string->symbol str)))))
                (iota 100)))

  (define (errno-alist)
    (map (lambda (sym)
           (cons (sys-symbol->errno sym)
                 sym))
         (sys-errno-list)))

  (define (errno-message num)
    (sys-strerror num)))
