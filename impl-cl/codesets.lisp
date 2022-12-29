(defpackage #:codesets
  (:use #:cl
        #+clisp #:posix)
  (:export
   #:codeset?
   #:codeset-symbols
   #:codeset-symbol
   #:codeset-number
   #:codeset-message))
(in-package #:codesets)

(defun codeset-symbol? (sym)
  ;; Not sure whether using keywords is the best idea.
  (keywordp sym))

#+clisp
(defun errno-alist ()
  (let ((alist '()))
    (dotimes (num 1000 (reverse alist))
      (let ((sym (posix:errno num)))
        (when (codeset-symbol? sym)
          (push (cons num sym) alist))))))

#+clisp
(defun errno-message (num)
  (posix:strerror num))

(defconstant +global-codesets+
  (list (list :errno (errno-alist) #'errno-message)))

(defun codeset-entry (codeset)
  (if (codeset-symbol? codeset)
      (assoc codeset +global-codesets+)
      (error "Not a codeset: ~S" codeset)))

(defun codeset-alist (codeset)
  (let ((entry (codeset-entry codeset)))
    (if entry (elt entry 1) '())))

(defun codeset? (object)
  (and (codeset-symbol? object)
       (not (not (codeset-entry object)))))

(defun codeset-symbols (codeset)
  (map 'list #'cdr (codeset-alist codeset)))

(defun bad-code (code)
  (error "Bad codeset code: ~S" code))

(defun codeset-number->symbol (codeset number)
  (let ((alist (codeset-alist codeset)))
    (loop (cond ((null alist)
                 (return nil))
                ((= number (caar alist))
                 (return (cdar alist)))
                (t
                 (setf alist (cdr alist)))))))

(defun codeset-symbol->number (codeset symbol)
  (let ((alist (codeset-alist codeset)))
    (loop (cond ((null alist)
                 (return nil))
                ((eql symbol (cdar alist))
                 (return (caar alist)))
                (t
                 (setf alist (cdr alist)))))))

(defun codeset-number->message (codeset)
  (let ((entry (codeset-entry codeset)))
    (and entry (elt entry 2))))

(defun codeset-symbol (codeset code)
  (cond ((codeset-symbol? code)
         code)
        ((integerp code)
         (codeset-number->symbol codeset code))
        (t
         (bad-code code))))

(defun codeset-number (codeset code)
  (cond ((codeset-symbol? code)
         (codeset-symbol->number codeset code))
        ((integerp code)
         code)
        (t
         (bad-code code))))

(defun codeset-message (codeset code)
  (let ((number (codeset-number codeset code)))
    (and number
         (let ((number->message (codeset-number->message codeset)))
           (and number->message
                (funcall number->message number))))))
