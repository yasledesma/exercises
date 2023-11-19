#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
;; water-balloon-starter.rkt

; PROBLEM:
; 
; In this problem, we will design an animation of throwing a water balloon.  
; When the program starts the water balloon should appear on the left side 
; of the screen, half-way up.  Since the balloon was thrown, it should 
; fly across the screen, rotating in a clockwise fashion. Pressing the 
; space key should cause the program to start over with the water balloon
; back at the left side of the screen. 
; 
; NOTE: Please include your domain analysis at the top in a comment box. 
; 
; NOTE: The rotate function wants an angle in degrees as its first 
; argument. By that it means Number[0, 360). As time goes by your balloon 
; may end up spinning more than once, for example, you may get to a point 
; where it has spun 362 degrees, which rotate won't accept. 
; 
; The solution to that is to use the modulo function as follows:
; 
; (rotate (modulo ... 360) (text "hello" 30 "black"))
; 
; where ... should be replaced by the number of degrees to rotate.
; 
; NOTE: It is possible to design this program with simple atomic data, 
; but we would like you to use compound data.


;; ====================
;; CONSTANTS
;; ====================
(define HEIGHT 500)
(define WIDTH 500)
(define MTS (empty-scene WIDTH HEIGHT "white"))
(define SPEED 0.1)
(define WATERBALLOON (ellipse 60 75 "solid" "yellow"))


;; ====================
;; DATA DEFINITIONS
;; ====================

(define-struct water-balloon (x y angle))
;; Type: WaterBalloon is (make-water-balloon Natural Integer Natural[0,360])
;; Interpretation: Position and angle of a water balloon.
;; Examples:
(define WB1 (make-water-balloon 0 0 0)) ; start + top of canvas
(define WB2 (make-water-balloon
              (/ WIDTH 2) (/ HEIGHT 2) 180)) ; middle of canvas
(define WB3 (make-water-balloon WIDTH HEIGHT 360)) ; end + bottom of canvas

#;
;; Template:
(define (fn-for-water-balloon wb)
  (... (water-balloon-x     wb)     ; Integer
       (water-balloon-y     wb)     ; Integer
       (water-balloon-angle wb)))   ; Natural[0,360]

;; Template rules:
;;    - compount: 3 fields


;; ====================
;; FUNCTION DEFINITIONS
;; ====================

;; Main function
;; WaterBalloon -> WaterBalloon
;; Start the world with (main WB1)
(define (main wb)
  (big-bang wb                                 ; WaterBalloon
            (on-tick next-water-balloon SPEED) ; WaterBalloon -> WaterBalloon
            (to-draw render)                   ; WaterBalloon -> Image
            (on-key  handle-key)))             ; WaterBalloon WBKeyEvent -> WaterBalloon         

;; Helpers
;; ====================
;; Define: next-water-balloon
;; Signature: WaterBalloon -> WaterBalloon
;; Purpose statement: The function consumes a WaterBalloon and returns
;;                    its next position (x, y) and angle.
;; Stub: (define (next-water-balloon WB1) WB2)

;; Examples/Tests:
(check-expect (next-water-balloon
               (make-water-balloon 0 0 0))
              (make-water-balloon 1 1 1)) ; standard
(check-expect (next-water-balloon
               (make-water-balloon 1 1 360))
              (make-water-balloon 2 2 0)) ; full rotation of water balloon
(check-expect (next-water-balloon
               (make-water-balloon WIDTH HEIGHT 360))
              (make-water-balloon (+ WIDTH 1)
                                  (+ HEIGHT 1) 0)) ; water balloon off edge

;; Template: <use template from WaterBalloon> 

;; Definition:
(define (next-water-balloon wb)
  (if (>= (water-balloon-angle wb) 360)
      (make-water-balloon
        (+ (water-balloon-x wb) 1)
        (+ (water-balloon-y wb) 1) 0)
      (make-water-balloon
        (+ (water-balloon-x wb) 1)
        (+ (water-balloon-y wb) 1)
        (+ (water-balloon-angle wb) 1))))

;; Define: render
;; Signature: WaterBalloon -> Image
;; Purpose statement: The function consumes a WaterBalloon and returns
;;                    an image of its current position.
;; Stub: (define (render WB1) 0)

;; Examples/Tests (using previously defined variables):
(check-expect (render WB1)
              (place-image
               (rotate (water-balloon-angle WB1) WATERBALLOON)
               (water-balloon-x WB1)
               (water-balloon-y WB1)
               MTS)) ; water balloon is at start of canvas, first position
(check-expect (render WB2)
              (place-image
               (rotate (water-balloon-angle WB2) WATERBALLOON)
               (water-balloon-x WB2)
               (water-balloon-y WB2)
               MTS)) ; water balloon is at middle of canvas, next position
(check-expect (render WB3)
              (place-image
               (rotate (water-balloon-angle WB3) WATERBALLOON)
               (water-balloon-x WB3)
               (water-balloon-y WB3)
               MTS)) ; water balloon is at end of canvas, gets out of canvas

;; Template: <use template from WaterBalloon> 

;; Definition:
(define (render wb)
  (place-image
               (rotate (water-balloon-angle wb) WATERBALLOON)
               (water-balloon-x wb)
               (water-balloon-y wb)
               MTS))

;; Define: handle-key
;; Signature: WaterBalloon WBKeyEvent -> WaterBalloon
;; Purpose statement: The function consumes a KeyEvent and returns a WaterBalloon.
;; Stub: (define (handle-key WB1 "a") WB1)

;; Examples/Tests:
(check-expect (handle-key WB3 "a") WB3) ; press any key. does not do anything
(check-expect (handle-key WB2 " ") WB1) ; press space key. animation starts over

;; Template: <use template from WaterBalloon> 

;; Definition:
(define (handle-key wb ke)
  (if (key=? ke " ")
      (make-water-balloon 0 0 0)
      wb))

