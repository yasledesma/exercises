#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; traffic-light-starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a traffic light. 
; 
; Your program should show a traffic light that is red, then green, 
; then yellow, then red etc. For this program, your changing world 
; state data definition should be an enumeration.
; 
; Here is what your program might look like if the initial world 
; state was the red traffic light:
; <image of a traffict light showing red>
; Next:
; <image of a traffict light showing green>
; Next:
; <image of a traffict light showing yellow>
; Next is red, and so on.
; 
; To make your lights change at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, (on-tick next-color 1) 
; then big-bang will wait 1 second between calls to next-color.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Note: If you want to design a slightly simpler version of the program,
; you can modify it to display a single circle that changes color, rather
; than three stacked circles. 
; 

;; ====================
;; CONSTANTS
;; ====================
(define HEIGHT 300)
(define WIDTH 600)
(define BG-COLOR "teal")
(define MTS (empty-scene WIDTH HEIGHT BG-COLOR))
(define SPEED 0.8)
(define X-POSITION (/ WIDTH 2))
(define Y-POSITION (/ HEIGHT 2))

;; ====================
;; DATA DEFINITIONS
;; ====================

;; 1) Type: Color is one of:
;;      - "red"
;;      - "green"
;;      - "yellow"
;; 2) Interpretation: The color of a traffic light.
;; 3) Examples:
(define C1 "red") ; examples are redundant for enumerations

#;
;; 4) Template:
(define (fn-for-color c)
  (cond [(string=? "red" c) (...)]
        [...]
        [(string=? "yellow" c) (...)]))

;; 5) Template rules:
;;    - one of three cases:
;;      1. atomic distinct: "red"
;;      2. atomic distinct: "green"
;;      1. atomic distinct: "yellow"

;; ====================
;; FUNCTION DEFINITIONS
;; ====================

;; Main function
;; Color -> Image 
;; Start the world with (main "green")
(define (main c)
  (big-bang c                               ; Color
            (on-tick change-light SPEED)    ; Color -> Color 
            (to-draw render)))              ; Color -> Image         

;; Helpers
;; 1.1) Change Light function
;; a_ Signature: Color -> Color 
;; b_ Purpose statement: The function consumes a Color and returns the next
;;                       color in a traffic light.
;; c_ Stub: (define (change-light "red") "green")

;; 1.3) Examples
;; a_ Calling (change-light "red") should return the string "green".
;; b_ Calling (change-light "green") should return the string "yellow".
;; c_ Calling (change-light "yellow") should return the string "red".

;; 1.4) Template: <use template from Color>

;; 1.5) Definition
(define (change-light c)
  (cond
    [(string=? "red"    c) "green"]
    [(string=? "green"  c) "yellow"]
    [(string=? "yellow" c) "red"]))

;; 1.6) Testing
(check-expect (change-light "red")    "green") ; as per 1.3)a_
(check-expect (change-light "green")  "yellow") ; as per 1.3)b_
(check-expect (change-light "yellow") "red") ; as per 1.3)c_

;; 2.1) Render function
;; a_ Signature: Color -> Image
;; b_ Purpose statement: The function consumes a Color and returns an image.
;; c_ Stub: (define (render "red") (underlay
;;              (rectangle 150 50 "solid" "lightorange")
;;              (beside (circle 20 "solid" "red")
;;                  (circle 20 "solid" "gray")
;;                  (circle 20 "solid" "gray"))))

;; 2.3) Examples
;; a_ Calling (render "red") should return
;;    (place-image (underlay
;;              (rectangle 150 50 "solid" "lightorange")
;;              (beside (circle 20 "solid" "red")
;;                  (circle 20 "solid" "gray")
;;                  (circle 20 "solid" "gray")))
;;              X-POSITION
;;              Y-POSITION MTS)).
;; b_ Calling (render "green") should return
;;    (place-image (underlay
;;              (rectangle 150 50 "solid" "lightorange")
;;              (beside (circle 20 "solid" "gray")
;;                  (circle 20 "solid" "gray")
;;                  (circle 20 "solid" "green")))
;;              X-POSITION
;;              Y-POSITION MTS)).
;; c_ Calling (render "yellow") should return
;;    (place-image (underlay
;;              (rectangle 150 50 "solid" "lightorange")
;;              (beside (circle 20 "solid" "gray")
;;                  (circle 20 "solid" "yellow")
;;                  (circle 20 "solid" "gray")))
;;              X-POSITION
;;              Y-POSITION MTS)).

;; 2.4) Template: <use template from Color>

;; 2.5) Definition
(define (render c)
  (place-image (underlay
                (rectangle 150 50 "solid" "lightorange")
                (beside (circle 20 "solid"
                                (if (string=? "red" c) "red" "gray"))
                        (circle 20 "solid"
                                (if (string=? "yellow" c) "yellow" "gray"))
                        (circle 20 "solid"
                                (if (string=? "green" c) "green" "gray"))))
               X-POSITION Y-POSITION MTS))

;; 2.6) Testing
(check-expect
  (render "red") (place-image
                   (underlay
                     (rectangle 150 50 "solid" "lightorange")
                     (beside (circle 20 "solid" "red")
                             (circle 20 "solid" "gray")
                             (circle 20 "solid" "gray")))
                   X-POSITION
                   Y-POSITION MTS)) ; as per 2.3)a_
(check-expect
  (render "green") (place-image
                   (underlay
                     (rectangle 150 50 "solid" "lightorange")
                     (beside (circle 20 "solid" "gray")
                             (circle 20 "solid" "gray")
                             (circle 20 "solid" "green")))
                   X-POSITION
                   Y-POSITION MTS)) ; as per 2.3)b_
(check-expect
  (render "yellow") (place-image
                   (underlay
                     (rectangle 150 50 "solid" "lightorange")
                     (beside (circle 20 "solid" "gray")
                             (circle 20 "solid" "yellow")
                             (circle 20 "solid" "gray")))
                   X-POSITION
                   Y-POSITION MTS)) ; as per 2.3)c_
