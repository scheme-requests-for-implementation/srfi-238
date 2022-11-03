(c-declare "#include \"glue.h\"")

(define-macro (retrieve-strings which proc)
  (let ((num (string-append which "_numbers"))
        (sym (string-append which "_symbols")))
    `(,proc
      ((c-lambda () nonnull-char-string ,num))
      ((c-lambda () nonnull-char-string ,sym)))))
