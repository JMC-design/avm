#|
  This file is a part of foo project.
  Copyright (c) 2016 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage foo.lang.appenv
  (:use :cl
        :foo.lang.symbol
        :foo.lang.type
        :foo.lang.unienv)
  (:export :empty-appenv
           :extend-appenv
           :query-appenv
           :subst-appenv))
(in-package :foo.lang.appenv)


;;
;; Function application environment

(defun empty-appenv ()
  nil)

(defun extend-appenv (form type aenv)
  (check-type type function-type)
  (acons form type aenv))

(defun query-appenv (form aenv)
  (or (cdr (assoc form aenv))
      (error "The function application ~S not found." form)))

(defun subst-appenv (uenv aenv)
  (loop for (form . type) in aenv
     collect
       (let ((type1 (loop for type1 in type
                       collect
                         (query-unienv type1 uenv))))
         (cons form type1))))