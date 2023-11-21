#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
;; design-quiz.rkt

; PROBLEM:
; 
; Design a World Program with Compound Data. You can be as creative as you like,
; but keep it simple. Above all, follow the recipes! You must also stay within
; the scope of the first part of the course. Do not use language features
; we have not seen in the videos. 
; 
; If you need inspiration, you can choose to create a program that allows you
; to click on a spot on the screen to create a flower, which then grows over time.
; If you click again the first flower is replaced by a new one at the new position.
; 
; You should do all your design work in DrRacket. Following the step-by-step
; recipe in DrRacket will help you be sure that you have a quality solution.


;; ====================
;; CONSTANTS
;; ====================
(define HEIGHT 500)
(define WIDTH 500)
(define MTS (empty-scene WIDTH HEIGHT "white"))
(define SPEED 0.5)
(define GROW 5)
(define FLOWER-IMG (pulled-regular-polygon 50 5 1 140 "solid" "red"))

;; ====================
;; DATA DEFINITIONS
;; ====================

(define-struct flower (x y stem-length))
;; Type: Flower is (make-flower Integer Integer Integer)
;; Interpretation: Position of a flower and lenght of its stem.
;; Examples:
;; initial state of a flower, middle of canvas
(define F1 (make-flower (/ WIDTH 2) (/ HEIGHT 2) 0))
;; flower with stem
(define F2 (make-flower 50 100 50))

#;
;; Template:
(define (fn-for-flower f)
  (... (flower-x           f)   ; Integer
       (flower-y           f)   ; Integer
       (flower-stem-length f))) ; Integer

;; Template rules:
;;    - compount: 3 fields


;; ====================
;; FUNCTION DEFINITIONS
;; ====================

;; Main function
;; Flower -> Flower
;; Start the world with (main F1)
(define (main f)
  (big-bang f                              ; Flower
            (on-mouse handle-click)        ; Flower MouseEvent -> Flower
            (to-draw  render)              ; Flower -> Image
            (on-tick  grow-flower SPEED))) ; Flower -> Flower

;;; Helpers
;;; ====================
;; Define: handle-click
;; Signature: Flower MouseEvent -> Flower
;; Purpose statement: The function consumes a MouseEvent and returns a Flower
;;                    with no stem.
;; Stub: (define (handle-click
;;                (make-flower 0 0 0)
;;                0
;;                0
;;                "button-down")
;;         (make-flower 0 0 0))

;; Examples/Tests:
(check-expect (handle-click (make-flower 0 0 0)
                            (/ WIDTH 2)
                            (/ HEIGHT 2)
                            "button-down")(make-flower
               (/ WIDTH 2)
               (/ HEIGHT 2)
               0)) ; create a new flower in the middle of the canvas
(check-expect (handle-click (make-flower 0 0 0)
                            (/ WIDTH 2)
                            (/ HEIGHT 2)
                            "drag")
              (make-flower 0 0 0)) ; don't do anything

;; Template: <use template from Flower> 

;; Definition:
(define (handle-click f x y me)
  (if (string=? me "button-down")
      (make-flower x y 0)
      f))


;; Define: render
;; Signature: Flower -> Image
;; Purpose statement: The function consumes a Flower and returns
;;                    an image of its current position in the canvas.
;; Stub: (define (render (make-flower 0 0 0)) (make-flower 0 0 0))

;; Examples/Tests:
(check-expect (render F1)
              (place-image
               (above FLOWER-IMG (line 0 0 "black"))
               (flower-x F1)
               (flower-y F1)
               MTS)) ; flower is at middle of canvas, no stem
(check-expect (render F2)
              (place-image
               (above FLOWER-IMG (line 0 50 "black"))
               (flower-x F2)
               (flower-y F2)
               MTS)) ; flower at random point in the canvas, has stem

;; Template: <use template from Flower> 

;; Definition:
(define (render f)
  (place-image
   (above FLOWER-IMG(line 0 (flower-stem-length f) "black"))
   (flower-x f)
   (flower-y f)
   MTS))


;; Define: grow-flower
;; Signature: Flower -> Flower
;; Purpose statement: The function consumes a Flower and adds GROW
;;                    to its stem length.
;; Stub: (define (grow-flower (make-flower 0 0 0)) (make-flower 0 0 0))

;; Examples/Tests:
(check-expect (grow-flower F2) (make-flower 50 100 55))

;; Template: <use template from Flower> 

;; Definition:
(define (grow-flower f)
  (make-flower
   (flower-x f)
   (flower-y f)
   (+ (flower-stem-length f) GROW)))

