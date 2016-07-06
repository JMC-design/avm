#|
  This file is a part of foo project.
  Copyright (c) 2016 Masayuki Takagi (kamonama@gmail.com)
|#

(in-package :cl-user)
(defpackage foo.lang.typenv
  (:use :cl
        :foo.lang.symbol
        :foo.lang.type
        :foo.lang.unienv)
  (:export :empty-typenv
           :extend-typenv
           :query-typenv
           :subst-typenv))
(in-package :foo.lang.typenv)


;;
;; Type environment

(defun empty-typenv ()
  nil)

(defun extend-typenv (var type tenv)
  (check-type var foo-symbol)
  (check-type type foo-type)
  (acons var type tenv))

(defun query-typenv (var tenv)
  (or (cdr (assoc var tenv))
      (error "The variable ~S not found." var)))

(defun subst-typenv (unienv tenv)
  (loop for (var . type) in tenv
     collect
       (let ((type1 (query-unienv type unienv)))
         (cons var type1))))