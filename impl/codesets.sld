(define-library (codesets)
  (export
   codeset?
   codeset-symbols
   codeset-symbol
   codeset-number
   codeset-message)
  (import (scheme base))
  (cond-expand
   (gambit
    (include-library-declarations "codesets.gambit.scm"))
   (gauche
    (include-library-declarations "codesets.gauche.scm")))
  (begin

    (define (no-message _) #f)

    (define global-codesets
      (list (list 'errno (errno-alist) errno-message)
            (list 'signal (signal-alist) no-message)))

    (define (codeset-entry codeset)
      (if (symbol? codeset)
          (assq codeset global-codesets)
          (error "Not a codeset" codeset)))

    (define (codeset-alist codeset)
      (let ((entry (codeset-entry codeset)))
        (if entry (list-ref entry 1) '())))

    (define (codeset? object)
      (and (symbol? object) (not (not (codeset-entry object)))))

    (define (codeset-symbols codeset)
      (map cdr (codeset-alist codeset)))

    (define (bad-code code)
      (error "Bad codeset code" code))

    (define (codeset-number->symbol codeset number)
      (let loop ((alist (codeset-alist codeset)))
        (cond ((null? alist) #f)
              ((= number (caar alist)) (cdar alist))
              (else (loop (cdr alist))))))

    (define (codeset-symbol->number codeset symbol)
      (let loop ((alist (codeset-alist codeset)))
        (cond ((null? alist) #f)
              ((eq? symbol (cdar alist)) (caar alist))
              (else (loop (cdr alist))))))

    (define (codeset-number->message codeset)
      (let ((entry (codeset-entry codeset)))
        (and entry (list-ref entry 2))))

    (define (codeset-symbol codeset code)
      (cond ((symbol? code) code)
            ((integer? code) (codeset-number->symbol codeset code))
            (else (bad-code code))))

    (define (codeset-number codeset code)
      (cond ((symbol? code) (codeset-symbol->number codeset code))
            ((integer? code) code)
            (else (bad-code code))))

    (define (codeset-message codeset code)
      (let ((number (codeset-number codeset code)))
        (and number
             (let ((number->message (codeset-number->message codeset)))
               (and number->message
                    (number->message number))))))))
