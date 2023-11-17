;; movie-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to represent a movie, including  
; title, budget, and year released.
; 
; To help you to create some examples, find some interesting movie facts below: 
; "Titanic" - budget: 200000000 released: 1997
; "Avatar" - budget: 237000000 released: 2009
; "The Avengers" - budget: 220000000 released: 2012
; 
; However, feel free to resarch more on your own!
; 


;; Definition:
(define-struct movie (title budget year))
;; Type: Movie is (make-movie String Integer Natural)
;; Interpretation: Info of a movie.
;; Examples:
(define M1 (make-movie "Return of the Living Dead" 4000000 1985))
(define M2 (make-movie "Resident Evil" 33000000 2002))

#;
;; Template:
(define (fn-for-movie m)
  (... (movie-title  m)     ; String
       (movie-budget m)     ; Integer
       (movie-year   m)))   ; Natural

;; Template rules:
;;    - compount: 3 fields


;; =================
;; Functions:

; 
; PROBLEM B:
; 
; You have a list of movies you want to watch, but you like to watch your 
; rentals in chronological order. Design a function that consumes two movies 
; and produces the title of the most recently released movie.
; 
; Note that the rule for templating a function that consumes two compound data 
; parameters is for the template to include all the selectors for both 
; parameters.
; 


;; Signature: Movie -> String
;; Purpose statement: The function consumes two movies and returns the most recently released one.
;; Stub: (define (pick-movie M1 M2) "Resident Evil")

;; Examples/Tests:
(check-expect (pick-movie M1 M2) "Resident Evil") ; using both example movies

;; Template: <use template from Movie> 

;; Definition:
(define (pick-movie m1 m2)
  (if (< (movie-year M1) (movie-year M2))
      (movie-title M2)
      (movie-title M1)))
