#lang htdp/bsl
(require 2htdp/image)

;; compare-images-starter.rkt

; 
; PROBLEM:
; 
; Based on the two constants provided, write three expressions
; to determine whether: 
; 
; 1) IMAGE1 is taller than IMAGE2
; 2) IMAGE1 is narrower than IMAGE2
; 3) IMAGE1 has both the same width AND height as IMAGE2
; 


;; Initial data
(define IMAGE1 (rectangle 10 15 "solid" "red"))
(define IMAGE2 (rectangle 15 10 "solid" "red"))

;; 1)
;; What info must be represented? A value expressing the validity
;; of definitions 1, 2, and 3.
;; How is it represented in BSL? By a primitive called boolean.
;; Eg. "true" and "false".
;; 2)
;; What kind of data does the program need to consume? Images.
;; What kind of data does the program produces? Boolean values.
;; What does the program computes? The heigh and width of a single image,
;; at a time. The, a comparison of those two values between multiple images.

;; Calculations based on initial data
;; IMAGE1 definitions
(define IMAGE1_HEIGHT (image-height IMAGE1))
(define IMAGE1_WIDTH (image-width IMAGE1))

;; IMAGE2 definitions
(define IMAGE2_HEIGHT (image-height IMAGE2))
(define IMAGE2_WIDTH (image-width IMAGE2))

;; Comparisons
(if (> IMAGE1_HEIGHT IMAGE2_HEIGHT)
    true
    false
)

(if (< IMAGE1_WIDTH IMAGE2_WIDTH)
    true
    false
)

(if (and (= IMAGE1_HEIGHT IMAGE2_HEIGHT) (= IMAGE1_WIDTH IMAGE2_WIDTH))
    true
    false
)
