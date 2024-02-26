#lang racket


#| 
Naive brute force approach.
This takes too much time.
|#


(define numbers '(1 2 3 4 5))
(define colors '(red green yellow blue white))
(define nationalities '(englishman spaniard ukrainian norwegian japanese))
(define beverages '(tea coffee milk water orange-juice))
(define cigarettes '(lucky-strike old-gold kools chesterfields parliaments))
(define pets '(dog snails fox horse zebra))


(define (get-number h) (car h))
(define (get-color h) (cadr h))
(define (get-nationality h) (caddr h))
(define (get-beverage h) (cadddr h))
(define (get-cigarette h) (car (cddddr h)))
(define (get-pet h) (cadr (cddddr h)))


(define (right-of? item1 item2 configuration) (= (get-number (assoc item1 configuration)) (+ (get-number (assoc item2 configuration)) 1)))
(define (left-of? item1 item2 configuration) (right-of? item2 item1 configuration))
(define (next-to? item1 item2 configuration) (or (right-of? item1 item2 configuration) (left-of? item1 item2 configuration)))

(define (same-house? item1 item2 configuration)
  (define (in-house item1 item2 house)
    (define (aux items item1found? item2found?)
      (cond
        [(null? items) #f]
        [(and item1found? item2found?) #t]
        [(eq? (car items) item1) (aux (cdr items) true item2found?)]
        [(eq? (car items) item2) (aux (cdr items) item1found? true)]
        [else (aux (cdr items) item1found? item2found?)]))
    (aux house #f #f))
  (or
   (in-house item1 item2 (car configuration))
   (in-house item1 item2 (cadr configuration))
   (in-house item1 item2 (caddr configuration))
   (in-house item1 item2 (cadddr configuration))
   (in-house item1 item2 (car (cddddr configuration)))))


(define (valid? configuration)
  (and
   (same-house? 'englishman 'red configuration)            ; The Englishman lives in the red house.
   (same-house? 'spaniard 'dog configuration)              ; The Spaniard owns the dog.
   (same-house? 'coffee 'green configuration)              ; Coffee is drunk in the green house.
   (same-house? 'ukrainian 'tea configuration)             ; The Ukrainian drinks tea.
   (right-of? 'green 'ivory configuration)                 ; The green house is immediately to the right of the ivory house.
   (same-house? 'old-gold 'snails configuration)           ; The Old Gold smoker owns snails.
   (same-house? 'kools 'yellow configuration)              ; Kools are smoked in the yellow house.
   (= 3 (get-number (assoc 'milk configuration)))          ; Milk is drunk in the middle house.
   (= 1 (get-number (assoc 'norwegian configuration)))     ; The Norwegian lives in the first house.
   (next-to? 'chesterfields 'fox configuration)            ; Chesterfields are smoked in the house next to the house where the fox is kept.
   (next-to? 'kools 'horse configuration)                  ; Kools are smoked in the house next to the house where the horse is kept.
   (same-house? 'lucky-strike 'orange-juice configuration) ; The Lucky Strike smoker drinks orange juice.
   (same-house? 'japanese 'parliaments configuration)      ; The Japanese smokes Parliaments.
   (next-to? 'norwegian 'blue configuration)))             ; The Norwegian lives next to the blue house.


(define (permutations xs)
  (for*/list ([a xs]
              [b xs]
              [c xs]
              [d xs]
              [e xs]
              #:when
              (not
               (or
                (eq? a b)
                (eq? a c)
                (eq? a d)
                (eq? a e)
                (eq? b c)
                (eq? b d)
                (eq? b e)
                (eq? c d)
                (eq? c e)
                (eq? d e))))
    (list a b c d e)))


(define (transpose lst)
  (apply map list lst))


(define (generate-houses)
  (let ([counter 1])
    (for*/list ([number (permutations numbers)]
                [color (permutations colors)]
                [nationality (permutations nationalities)]
                [beverage (permutations beverages)]
                [cigarette (permutations cigarettes)]
                [pet (permutations pets)])
      (let ([configuration (transpose (list number color nationality beverage cigarette pet))])
        (if (valid? configuration)
            (begin
              (displayln configuration)
              (exit))
            (begin
              (displayln (number->string counter))
              (set! counter (+ counter 1))))))))


(generate-houses)