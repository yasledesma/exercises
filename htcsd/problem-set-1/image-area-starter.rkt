#lang htdp/bsl
;; image-area-starter.rkt

; 
; PROBLEM:
; 
; DESIGN a function called image-area that consumes an image and produces
; the area of that image. For the area it is sufficient to just multiply
; the image's width by its height.Follow the HtDF recipe and leave behind
; commented out versions of the stub and template.
; 

(require 2htdp/image)
;; 2)
;;   Signature: Image -> Integer
;;   Purpose Statement: This functions consumes an image and produces a number,
;;                      which is the product of the image's height by its width
;;                      (or area of that image.)
;;   Stub: (define (image-area img)) -> num

;; 3) Examples
;; a_ Calling (image-area (square 10 "solid" "red")) should return
;;    the number 100.
;; a_ Calling (image-area (triangle 25 "solid" "blue")) should return
;;    the number 550.
;; a_ Calling (image-area (circle 40 "solid" "green"))) should return
;;    the number 6400, since 40 is the length of its radius.

;; 4) Template
;;    (define (image-area img)
;;     (...img)
;;    )

;; 5) Definition:
      (define (image-area img)
        (* (image-width img) (image-height img))
      )

;; 6) Tests:
      (check-expect (image-area (square 10 "solid" "red")) 100)
      (check-expect (image-area (triangle 25 "solid" "blue")) 550)
      (check-expect (image-area (circle 40 "solid" "green")) 6400)
