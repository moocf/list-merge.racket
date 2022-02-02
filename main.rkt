#lang racket

; (list.merge-to pred loi1 loi2 to): F X L X L X L -> L
; merges loi1 and loi2 using pred to list "to"
; : loi1=null & loi2=null                             -> to
; : loi2=null | (loi1!=null & (pred loi1[0] loi2[0])) -> (loi1[0] . (list.merge-to pred loi1[1..end] loi2 to))
; : else                                              -> (loi2[0] . (list.merge-to pred loi1 loi2[1..end] to))
(define list.merge-to
  (lambda (pred loi1 loi2 to)
    (if (and (null? loi1) (null? loi2))
        to
        (if (or (null? loi2) (and (not (null? loi1)) (pred (car loi1) (car loi2))))
            (cons (car loi1) (list.merge-to pred (cdr loi1) loi2 to))
            (cons (car loi2) (list.merge-to pred loi1 (cdr loi2) to))))))

; (list.merge loi1 loi2): L X L -> L
; merge loi1 and loi2 in ascending order
(define list.merge
  (lambda (loi1 loi2)
    (list.merge-to <= loi1 loi2 (list))))
