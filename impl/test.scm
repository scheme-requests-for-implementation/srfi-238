(import (scheme base)
        (srfi 64)
        (codesets))

(test-begin "codesets")

(test-equal #t
            (codeset? 'errno))
(test-equal #f
            (codeset? "a"))

(test-assert (member 'EPERM (codeset-symbols 'errno)))
(test-assert (member 'ENXIO (codeset-symbols 'errno)))
(test-error (codeset-symbols "a"))

(test-equal 'EPERM
            (codeset-symbol 'errno 'EPERM))
(test-equal 'EPERM
            (codeset-symbol 'errno 1))
(test-error (codeset-symbol 'errno "a"))
(test-error (codeset-symbol "a" 'EPERM))

(test-equal 1
            (codeset-number 'errno 'EPERM))
(test-equal 1
            (codeset-number 'errno 1))
(test-error (codeset-number 'errno "a"))
(test-error (codeset-number "a" 'EPERM))

(test-assert (string? (codeset-message 'errno 'EPERM)))
(test-assert (not (equal? "" (codeset-message 'errno 'EPERM))))
(test-assert (equal? (codeset-message 'errno 'EPERM)
                     (codeset-message 'errno 1)))
(test-error (codeset-message "a" 'EPERM))

(test-end)
