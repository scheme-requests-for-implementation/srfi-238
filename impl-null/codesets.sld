(define-library (codesets)
  (export
   codeset?
   codeset-symbols
   codeset-symbol
   codeset-number
   codeset-message)
  (import (scheme base))
  (begin

    (define (check-type object)
      (unless (symbol? object)
        (error "Bad codeset" object)))

    (define (return code when-symbol when-integer)
      (cond ((symbol? code) when-symbol)
            ((integer? code) when-integer)
            (else (error "Bad codeset code" code))))

    ;;

    (define (codeset? object)
      #f)

    (define (codeset-symbols codeset)
      (check-type codeset)
      '())

    (define (codeset-symbol codeset code)
      (check-type codeset)
      (return code code #f))

    (define (codeset-number codeset code)
      (check-type codeset)
      (return code #f code))

    (define (codeset-message codeset code)
      (check-type codeset)
      (return code #f #f))))
