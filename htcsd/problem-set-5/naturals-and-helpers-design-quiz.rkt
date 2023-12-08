#lang htdp/bsl
(require 2htdp/image)
;; SPD2-Design-Quiz-1.rkt


;; ======================================================================
;; Constants
(define COOKIE (overlay (circle 24 "outline" "black")
                        (place-images
                         (list (circle 5 "solid" "black")
                               (circle 4 "solid" "black")
                               (circle 4 "solid" "black")
                               (circle 4 "solid" "black"))
                         (list (make-posn 18 20)
                               (make-posn 30 8)
                               (make-posn 19 33)
                               (make-posn 35 35))
                         (circle 24 "solid" "light brown"))))

;; ======================================================================
;; Data Definitions

;; Natural is one of:
;;  - 0
;;  - (add1 Natural)
;; interp. a natural number
(define N0 0)         ;0
(define N1 (add1 N0)) ;1
(define N2 (add1 N1)) ;2

#;
(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n   ; n is added because it's often useful                   
              (fn-for-natural (sub1 n)))]))

;; Template rules used:
;;  - one-of: two cases
;;  - atomic distinct: 0
;;  - compound: 2 fields
;;  - self-reference: (sub1 n) is Natural


; PROBLEM 1:
; 
; Complete the design of a function called pyramid that takes a natural
; number n and an image, and constructs an n-tall, n-wide pyramid of
; copies of that image.
; 
; For instance, a 3-wide pyramid of cookies.


;; Natural Image -> Image
;; produce an n-wide pyramid of the given image
;; (define (pyramid n i) empty-image) ; stub
(check-expect (pyramid 0 COOKIE) empty-image)
(check-expect (pyramid 1 COOKIE) COOKIE)
(check-expect (pyramid 3 COOKIE)
              (above COOKIE
                     (beside COOKIE COOKIE)
                     (beside COOKIE COOKIE COOKIE)))

;; use template for Natural

(define (pyramid n i)
  (cond [(zero? n) empty-image]
        [else
         (above (pyramid (sub1 n) i)
                (line-of-cookies n i))]))


;; Natural Image -> Image
;; produce an image of n cookies beside each other.
;; (define (line-of-cookies n i) empty-image) ; stub

(check-expect (line-of-cookies 0 COOKIE)
              empty-image)
(check-expect (line-of-cookies 1 COOKIE)
              COOKIE)
(check-expect (line-of-cookies 3 COOKIE)
              (beside COOKIE COOKIE COOKIE))

;; use template for Natural

(define (line-of-cookies n i)
  (cond [(zero? n) empty-image]
        [else
         (beside i (line-of-cookies (sub1 n) i))]))


; Problem 2:
; Consider a test tube filled with solid blobs and bubbles.  Over time the
; solids sink to the bottom of the test tube, and as a consequence the bubbles
; percolate to the top.  Let's capture this idea in BSL.
; 
; Complete the design of a function that takes a list of blobs and sinks each
; solid blob by one. It's okay to assume that a solid blob sinks past any
; neighbor just below it.
; 
; To assist you, we supply the relevant data definitions.


;; Blob is one of:
;; - "solid"
;; - "bubble"
;; interp.  a gelatinous blob, either a solid or a bubble
;; Examples are redundant for enumerations
#;
(define (fn-for-blob b)
  (cond [(string=? b "solid") (...)]
        [(string=? b "bubble") (...)]))

;; Template rules used:
;; - one-of: 2 cases
;; - atomic distinct: "solid"
;; - atomic distinct: "bubble"


;; ListOfBlob is one of:
;; - empty
;; - (cons Blob ListOfBlob)
;; interp. a sequence of blobs in a test tube, listed from top to bottom.
(define LOB0 empty) ; empty test tube
(define LOB2 (cons "solid" (cons "bubble" empty))) ; solid blob above a bubble

#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else
         (... (fn-for-blob (first lob))
              (fn-for-lob (rest lob)))]))

;; Template rules used
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: 2 fields
;; - reference: (first lob) is Blob
;; - self-reference: (rest lob) is ListOfBlob

;; ListOfBlob -> ListOfBlob
;; produce a list of blobs that sinks the given solid blobs by one

(check-expect (sink empty) empty)
(check-expect (sink (cons "bubble" (cons "solid" (cons "bubble" empty))))
              (cons "bubble" (cons "bubble" (cons "solid" empty))))
(check-expect (sink (cons "solid" (cons "solid" (cons "bubble" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))
(check-expect (sink (cons "solid" (cons "bubble" (cons "bubble" empty))))
              (cons "bubble" (cons "solid" (cons "bubble" empty))))
(check-expect (sink (cons "solid" (cons "bubble" (cons "solid" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))
(check-expect (sink (cons "bubble" (cons "solid" (cons "solid" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))
(check-expect (sink (cons "solid"
                          (cons "solid"
                                (cons "bubble" (cons "bubble" empty)))))
              (cons "bubble" (cons "solid" 
                                   (cons "solid" (cons "bubble" empty)))))
;; (define (sink lob) empty) ; stub

;; use template for ListOfBubble

(define (sink lob)
  (cond [(empty? lob) empty]
        [else
         (swap (first lob)
               (sink (rest lob)))]))


;; Blob ListOfBlob -> ListOfBlob
;; check and if a blob is "solid", and push it one place deeper into the list.
;; (define (swap b lob) empty) ; stub

(check-expect (swap "solid" empty) (cons "solid" empty)) ; should be put first
(check-expect (swap "solid"                              ; move one place
                    (cons "bubble" (cons "solid" empty)))
              (cons "bubble" (cons "solid" (cons "solid" empty))))

;; use template for Blob

(define (swap b lob)
  (cond [(and (string=? b "solid") (not (empty? lob)))
         (cons (first lob) (cons b (rest lob)))]
        [else
         (cons b lob)]))

