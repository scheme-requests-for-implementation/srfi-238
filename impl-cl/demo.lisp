(load "codesets")
(use-package '#:codesets)

(defun newline ()
  (terpri))

(defmacro show (expr)
  `(format t "~S => ~S~%" ',expr ,expr))

(defun numbers (codeset)
  (map 'list
       (lambda (code) (codeset-number codeset code))
       (codeset-symbols codeset)))

(show (numbers :errno))
(show (codeset-symbols :errno))
(show (codeset-symbol :errno 2))
(show (codeset-symbol :errno :ENOENT))
(show (codeset-number :errno 2))
(show (codeset-number :errno :ENOENT))
(show (codeset-message :errno 2))
(show (codeset-message :errno :ENOENT))
(newline)
(show (numbers :signal))
(show (codeset-symbols :signal))
(show (codeset-symbol :signal :SIGINT))
(show (codeset-symbol :signal 2))
(show (codeset-number :signal :SIGINT))
(show (codeset-number :signal 2))
(show (codeset-message :signal 2))
(show (codeset-message :signal 2))
