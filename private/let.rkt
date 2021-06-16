#lang racket/base

(provide let
         let*
         letrec)

(require (rename-in racket/base [let -let]
                                [let* -let*]
                                [letrec -letrec])
         syntax/parse/define
         (for-syntax racket/base
                     syntax/parse/class/paren-shape))

(define-syntax-parser let
  [(_ (~optional name:id) (~brackets (~seq id:id expr:expr) ...) body ...+)
   #'(-let (~? name) ((id expr) ...)
        body ...)]
  [(_ (~optional name:id) ((id:id expr:expr) ...) body ...+)
   #'(-let (~? name) ((id expr) ...)
        body ...)])
  
(define-syntax-parser let*
  [(_ (~brackets (~seq id:id expr:expr) ...) body ...+)
   #'(-let* ((id expr) ...)
        body ...)]
  [(_ ((id:id expr:expr) ...) body ...+)
   #'(-let* ((id expr) ...)
        body ...)])
  
(define-syntax-parser letrec
  [(_ (~brackets (~seq id:id expr:expr) ...) body ...+)
   #'(-letrec ((id expr) ...)
        body ...)]
  [(_ ((id:id expr:expr) ...) body ...+)
   #'(-letrec ((id expr) ...)
        body ...)])
  
(module+ test
  (require rackunit/chk)
  (chk
   (let [x 3
         y 4]
     (+ x y))
   7
   
   (let ([x 3]
         [y 4])
     (+ x y))
   7
   
   (let* [x 3
          y (+ x 5)]
     (+ x y))
   11
   
   (let* ([x 3]
          [y (+ x 5)])
     (+ x y))
   11
   
   (let loop [x 0]
     (if (< x 10)
       (loop (add1 x))
       x))
   10

   (letrec
       [is-even? (lambda (n)
                   (or (zero? n)
                       (is-odd? (sub1 n))))
        is-odd? (lambda (n)
                  (and (not (zero? n))
                       (is-even? (sub1 n))))]
     (is-odd? 11))
   #t

   (letrec
       ([is-even? (lambda (n)
                    (or (zero? n)
                        (is-odd? (sub1 n))))]
        [is-odd? (lambda (n)
                   (and (not (zero? n))
                        (is-even? (sub1 n))))])
     (is-odd? 11))
   #t
   ))
