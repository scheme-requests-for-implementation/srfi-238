(import (only (srfi 1)
              filter-map
              iota)
        (only (gauche base)
              sys-errno->symbol
              sys-signal-name
              sys-strerror))
(begin

  (define (signal-alist)
    (filter-map (lambda (num)
                  (let ((str (sys-signal-name num)))
                    (and str (cons num (string->symbol str)))))
                (iota 100)))

  (define (errno-alist)
    (filter-map (lambda (num)
                  (let ((sym (sys-errno->symbol num)))
                    (and sym (cons num sym))))
                (iota 200)))

  (define (signal-message num)
    #f)

  (define (errno-message num)
    (sys-strerror num)))
