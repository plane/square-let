#lang info

(define collection "square-let")
(define pkg-authors '("crystal@panix.com"))
(define version "0.1")
(define scribblings
 '(("square-let.scrbl" () (library) "square-let")))
(define pkg-desc "(let [x 0 y 1] body ...) macro")
(define deps '("base"
               "reprovide-lang-lib"
               "syntax-classes-lib"))
(define build-deps '("rackunit-lib"
                     "rackunit-chk"
                     "racket-doc"
                     "scribble-lib"))
(define compile-omit-paths '("examples"))

