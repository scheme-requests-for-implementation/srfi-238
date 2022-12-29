(import (scheme base)
        (srfi 64)
        (codesets))

(test-begin "codesets")

(test-equal #f
            (codeset? 'errno))
(test-equal #f
            (codeset? "a"))

(test-equal '()
            (codeset-symbols 'errno))
(test-error (codeset-symbols "a"))

(test-equal 'ENOENT
            (codeset-symbol 'errno 'ENOENT))
(test-equal #f
            (codeset-symbol 'errno 1))
(test-error (codeset-symbol "a" 'ENOENT))

(test-equal #f
            (codeset-number 'errno 'ENOENT))
(test-equal 1
            (codeset-number 'errno 1))
(test-error (codeset-number "a" 'ENOENT))


(test-equal #f
            (codeset-message 'errno 'ENOENT))
(test-equal #f
            (codeset-message 'errno 1))
(test-error (codeset-message "a" 'ENOENT))

(test-end)
