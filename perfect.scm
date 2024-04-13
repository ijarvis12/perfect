#!/usr/bin/env guile -s
!#

;; program that finds perfect numbers

(newline)
(display "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~") (newline)
(display " This program finds perfect numbers using Mersenne Primes ") (newline)
(display "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~") (newline)
(newline)

;; Lucas-Lehmer prime test for odd p > 2
(define (LLT p s M) (while (> p 2) (set! s (modulo (- (* s s) 2) M ) )
                                        (if (= s 0) (break #t) )
                                        (set! p (- p 1) )
                )
)

(display "The perfect numbers:") (newline)
(display "6") (newline)

;; some useful variables
(define p 1)
(define M 1)
(define psum 1)
(define perfect 1)
(define sqrtp 1)
(define n 2)

(while '(#t)    (set! p (+ p 2) )
                (set! M (- (expt 2 p) 1) )
                (if (not (LLT p 4 M) ) (continue) )
                (set! psum 1)
                (set! perfect (* (expt 2 (- p 1)) (- (expt 2 p) 1) ) )
                (set! sqrtp (inexact->exact (ceiling (sqrt perfect)) ) )
                (set! n 2)
                (while (<= n sqrtp)
                                (if (= 0 (modulo perfect n))
                                        (set! psum (+ (+ psum n) (inexact->exact (/ perfect n)) ) )
                                )
                                (set! n (+ n 1) )
                )
                (if (= perfect (expt 2 sqrtp) )
                        (set! psum (- psum sqrtp) )
                )
                (if (= psum perfect) 
                        (display (string-append (number->string perfect) "\n") )
                )
)
