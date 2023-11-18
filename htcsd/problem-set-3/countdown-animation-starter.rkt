#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; countdown-animation starter.rkt

; 
; PROBLEM:
; 
; Design an animation of a simple countdown. 
; 
; Your program should display a simple countdown, that starts at ten, and
; decreases by one each clock tick until it reaches zero, and stays there.
; 
; To make your countdown progress at a reasonable speed, you can use the 
; rate option to on-tick. If you say, for example, 
; (on-tick advance-countdown 1) then big-bang will wait 1 second between 
; calls to advance-countdown.
; 
; Remember to follow the HtDW recipe! Be sure to do a proper domain 
; analysis before starting to work on the code file.
; 
; Once you are finished the simple version of the program, you can improve
; it by reseting the countdown to ten when you press the spacebar.
; 

;; ====================
;; CONSTANTS
;; ====================
(define HEIGHT 100)
(define WIDTH 200)
(define BG-COLOR "green")
(define MTS (empty-scene WIDTH HEIGHT BG-COLOR))
(define SPEED 1)
(define X-POSITION (/ WIDTH 2))
(define Y-POSITION (/ HEIGHT 2))

;; ====================
;; DATA DEFINITIONS
;; ====================

;; 1) Type: Count is Natural[0, 10]
;; 2) Interpretation: The amount of seconds remaining in a countdown.
;; 3) Examples:
(define C1 10) ; start
(define C2 5)  ; middle
(define C3 0)  ; end

#;
;; 4) Template:
(define (fn-for-count c)
  (... c))

;; 5) Template rules:
;;    - atomic non-distinct: Natural[0, 10]

;; ====================
;; FUNCTION DEFINITIONS
;; ====================

;; Main function
;; Count -> Count
;; Start the world with (main 11)
(define (main c)
  (big-bang c                           ; Count
            (on-tick countdown SPEED)   ; Count -> Count
            (to-draw render)            ; Count -> Image
            (on-key  handle-key)))      ; KeyEvent -> Count         

;; Helpers
;; 1.1) Countdown function
;; a_ Signature: Count -> Count
;; b_ Purpose statement: The function consumes the current countdown number,
;;                       substracks one, and returns the new count.
;; c_ Stub: (define (countdown 0) 0)

;; 1.3) Examples
;; a_ Calling (countdown 10) should return the number 9.
;; b_ Calling (countdown 5) should return the number 4.
;; c_ Calling (countdown 0) should return the number 0.
;; d_ Calling (countdown 33) should return the number 10.

;; 1.4) Template: <use template from Count>

;; 1.5) Definition
(define (countdown c)
  (cond
    [(= c 0) 0]
    [(> c 10) 10]
    [else (- c 1)]))

;; 1.6) Testing
(check-expect (countdown 10) 9) ; as per 1.3)a_
(check-expect (countdown 5) 4) ; as per 1.3)b_
(check-expect (countdown 0) 0) ; as per 1.3)c_
(check-expect (countdown 33) 10) ; as per 1.3)d_

;; 2.1) Render function
;; a_ Signature: Count -> Image
;; b_ Purpose statement: The function consumes the current number in a countdown
;;                       and returns an image.
;; c_ Stub: (define (render 0) 0)

;; 2.3) Examples
;; a_ Calling (render 9) should return
;;    (place-image (text (number->string 9) 50 "black") X-POSITION Y-POSITION MTS)).

;; 2.4) Template: <use template from Count>

;; 2.5) Definition
(define (render c)
  (place-image (text (number->string c) 50 "black") X-POSITION Y-POSITION MTS))

;; 2.6) Testing
(check-expect
  (render 9) (place-image
               (text (number->string 9) 50 "black")
               X-POSITION
               Y-POSITION MTS)) ; as per 2.3)a_

;; 3.1) Handle Key function
;; a_ Signature: KeyEvent -> Count
;; b_ Purpose statement: The function listens for a key-press, specifically
;;                       the space key, and resets the counter to 10.
;; c_ Stub: (define (handle-key "a") 10)

;; 3.3) Examples
;; a_ Calling (handle-key 0 " ") should return 10.
;; b_ Calling (handle-key 6 "a") should return 6.

;; 3.4) Template: <use template from Count>

;; 3.5) Definition
(define (handle-key c ke)
  (if (key=? ke " ") 10 c))

;; 3.6) Testing
(check-expect (handle-key 0 " ") 10) ; as per 3.3)a_
(check-expect (handle-key 5 "a") 5)   ; as per 3.3)b_
