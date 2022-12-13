(define-library (codesets)
  (export
   codeset?
   codeset-symbols
   codeset-symbol
   codeset-number
   codeset-message)
  (import (scheme base)
          (scheme case-lambda))
  (begin

    (define (codeset? object)
      #f)

    (define (codeset-symbols codeset)
      '())

    (define (return code when-symbol when-integer)
      (cond ((symbol? code)
             when-symbol)
            ((integer? code)
             when-integer)
            (else
             (error "Bad codeset code" code))))

    (define (codeset-symbol codeset code)
      (return code code #f))

    (define (codeset-number codeset code)
      (return code #f code))

    (define codeset-message
      (case-lambda
       ((codeset code)
        (return code #f #f))
       ((codeset code locale)
        (return code #f #f))))))
