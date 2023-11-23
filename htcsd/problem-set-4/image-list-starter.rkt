#lang htdp/bsl
(require 2htdp/image)

;; image-list-starter.rkt

;; =================
;; Constants:
(define RCIRCLE (circle 20 "solid" "red"))
(define BSQUARE (square 20 "outline" "blue"))


;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to represent a list of images. Call it ListOfImage. 
; 


;; Type: ListOfImage is one of:
;;           - empty
;;           - (cons Image ListOfImage)
;; Interpretation: A list of images.
(define LOI1 empty)
(define LOI2 (cons RCIRCLE empty))
(define LOI3 (cons BSQUARE (cons RCIRCLE empty)))

#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; Template rules:
;;  - one of: 2 cases
;;      - atomic distinct: empty
;;      - compound: (cons Image ListOfImage)
;;  - self-reference: (rest loi) is ListOfImage


;; =================
;; Functions:

; 
; PROBLEM B:
; 
; Design a function that consumes a list of images and produces a number 
; that is the sum of the areas of each image. For area, just use the image's 
; width times its height.
; 


;; Signature: ListOfImage -> Number
;; Purpose statement: The function consumes a list of images and returns
;;                    the sum of its areas.
;; Stub: (define (sum-images-areas loi) 0)

;; Examples/Tests:
; empty list case
(check-expect (sum-images-areas LOI1) 0)
; single element case
(check-expect (sum-images-areas LOI2) (* (image-width RCIRCLE)
                                         (image-height RCIRCLE)))
; multi element case
(check-expect (sum-images-areas LOI3) (+ (* (image-width BSQUARE)
                                            (image-height BSQUARE))
                                         (* (image-width RCIRCLE)
                                            (image-height RCIRCLE))))

;; Template: <use template from ListOfNumber> 

;; Definition:
(define (sum-images-areas loi)
  (cond [(empty? loi) 0]
        [else
         (+ (* (image-width (first loi)) (image-height (first loi)))
              (sum-images-areas (rest loi)))]))

