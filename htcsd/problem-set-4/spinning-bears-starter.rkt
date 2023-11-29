#lang htdp/bsl
;; spinning-bears-starter.rkt

(require 2htdp/image)
(require 2htdp/universe)

; PROBLEM:
; 
; In this problem you will design another world program. In this program the changing 
; information will be more complex - your type definitions will involve arbitrary 
; sized data as well as the reference rule and compound data. But by doing your 
; design in two phases you will be able to manage this complexity. As a whole, this problem 
; will represent an excellent summary of the material covered so far in the course, and world 
; programs in particular.
; 
; This world is about spinning bears. The world will start with an empty screen. Clicking
; anywhere on the screen will cause a bear to appear at that spot. The bear starts out upright,
; but then rotates counterclockwise at a constant speed. Each time the mouse is clicked on the 
; screen, a new upright bear appears and starts spinning.
; 
; So each bear has its own x and y position, as well as its angle of rotation. And there are an
; arbitrary amount of bears.
; 
; To start, design a world that has only one spinning bear. Initially, the world will start
; with one bear spinning in the center at the screen. Clicking the mouse at a spot on the
; world will replace the old bear with a new bear at the new spot. You can do this part 
; with only material up through compound. 
; 
; Once this is working you should expand the program to include an arbitrary number of bears.


;; ====================
;; CONSTANTS
;; ====================
(define HEIGHT 500)
(define WIDTH 500)
(define MTS (empty-scene WIDTH HEIGHT "white"))
(define SPEED 0.5)
(define WNAME "World of Spinning")
;; you'll have to make an actual bear image
(define BIMG (underlay/offset (beside (overlay (circle 7 "solid" "lightorange") (circle 15 "solid" "lightbrown"))
                         (rectangle 10 0 "solid" "transparent")
                         (overlay (circle 7 "solid" "lightorange") (circle 15 "solid" "lightbrown")))
                  0 20
                  (underlay/offset (scene+curve (circle 25 "solid" "lightbrown")
                                                10 30 -90 1/3
                                                40 30 90 1/3
                                                "black")
                   0 -5
                   (underlay/offset (circle 5 "solid" "black")
                                   -20 0
                                   (circle 5 "solid" "black")))))


;; ====================
;; DATA DEFINITIONS
;; ====================
(define-struct bear (x y angle))
;; Type: Bear is (make-bear Integer Integer Integer[-360,0])
;; Interpretation: Position and current angle of rotation of a bear.
;; Examples:
;; somewhere in the canvas + start angle
(define B1 (make-bear 120 50 0))
;; middle of canvas + halfway rotation
(define B2 (make-bear (/ WIDTH 2) (/ HEIGHT 2) -180))
;; top corner of canvas + full rotation
(define B3 (make-bear 0 0 -360))

#;
;; Template:
(define (fn-for-bear b)
  (... (bear-x     b)   ; Integer
       (bear-y     b)   ; Integer
       (bear-angle b))) ; Integer[-360,0]

;; Template rules:
;;    - compount: 3 fields

;; --------------------

;; Type: ListOfBear is one of:
;;           - empty
;;           - (cons Bear ListOfBear)
;; Interpretation: A list of bears.
(define LOB1 empty)
(define LOB2 (cons B1 empty))
(define LOB3 (cons B2 (cons B1 empty)))
;; and just because there's one Bear example left
(define LOB4 (cons B3 (cons B2 (cons B1 empty))))

#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else
         (... (fn-for-bear (first lob))
              (fn-for-lob (rest lob)))]))

;; Template rules:
;;  - one of: 2 cases
;;      - atomic distinct: empty
;;      - compound: (cons Bear ListOfBear)
;;  - reference: (first lob) is Bear
;;  - self-reference: (rest lob) is ListOfBear


;; ====================
;; FUNCTION DEFINITIONS
;; ====================

;; ;; Main function
;; ;; ListOfBear -> ListOfBear
;; ;; Start the world with (main empty)
;; (define (main lob)
;;   (big-bang lob                          ; ListOfBear
;;             (name    WNAME)              ; WNAME
;;             (to-draw render-bears)       ; ListOfBear -> Image
;;             (on-tick rotate-bears SPEED) ; ListOfBear -> ListOfBear
;;             (on-key  handle-click)))     ; ListOfBear LOBKeyEvent -> ListOfBear         

;; Helpers
;; ====================
;; Define: render-bears
;; Signature: ListOfBear -> Image
;; Purpose statement: The function consumes a ListOfBear and returns
;;                    an image rendering all bears on the list.
;; Stub: (define (render-bears empty) MTS)

;; Examples/Tests:
(check-expect (render-bears empty) MTS) ; render empty list
(check-expect (render-bears
               (cons (make-bear 56 125 0)
                    (cons (make-bear 25 25 -89)
                          empty)))
               (place-image
                (rotate (bear-angle (make-bear 56 125 0)) BIMG)
                (bear-x (make-bear 56 125 0))
                (bear-y (make-bear 56 125 0))
                (place-image
                 (rotate (bear-angle (make-bear 25 25 -89)) BIMG)
                 (bear-x (make-bear 25 25 -89))
                 (bear-y (make-bear 25 25 -89))
                 MTS))) ; render list with multiple elements

;; Template: <use template from ListOfBear> 

;; Definition:
(define (render-bears lob)
  (cond [(empty? lob) MTS]
        [else
          (place-image
          (bear-image (first lob)) ; perhaps is fine to
          (bear-x (first lob))     ; only have a function
          (bear-y (first lob))     ; for the image
          (render-bears (rest lob)))]))

;; Define: bear-image
;; Signature: Bear -> Image
;; Purpose statement: The function consumes a Bear and returns an image.
;; Stub: (define (bear-image (make-bear 0 0 0)) BIMG)

;; Examples/Tests:
;; standard image angle
(check-expect (bear-image B1) BIMG)
;; image rotated halfway
(check-expect (bear-image B2) (rotate (bear-angle B2) BIMG))
;; image fully rotated
(check-expect (bear-image B3) (rotate (bear-angle B3) BIMG))

;; Template: <use template from Bear> 

;; Definition:
(define (bear-image b)
  (rotate (bear-angle b) BIMG))

;; ;; Define: handle-click
;; ;; Signature: ListOfBear LOBKeyEvent -> ListOfBear
;; ;; Purpose statement: The function consumes a ListOfBear and add a new
;; ;;                    bear to the list.
;; ;; Stub: (define (handle-click empty) (const (make-bear 0 0 0) empty))
;; 
;; ;; Examples/Tests:
;; (check-expect (handle-click empty)
;;               (cons (make-bear 0 0 0)
;;                     empty)) ; add to empty list
;; (check-expect (handle-click (cons (make-bear 25 25 -89) empty))
;;               (cons (make-bear 56 125 0)
;;                     (cons (make-bear 25 25 -89)
;;                           empty))) ; add to list with one element
;; 
;; ;; Template: <use template from ListOfBear> 
;; 
;; ;; Definition:
;; (define (handle-click lob)
;;   (cond [(empty? lob) empty]
;;         [else
;;          (cons (fn-for-bear (first lob))
;;               (handle-click (rest lob)))]))

;; ;; Define: rotate-bears
;; ;; Signature: ListOfBear -> ListOfBear
;; ;; Purpose statement: The function consumes a ListOfBear and returns
;; ;;                    a list with all bears with a different angle.
;; ;; Stub: (define (rotate-bears empty) empty)
;; 
;; ;; Examples/Tests:
;; (check-expect (rotate-bears
;;                (cons (make-bear 0 0 0) empty))
;;               (cons (make-bear 0 0 -1) empty)) ; standard
;; (check-expect (rotate-bears
;;                (cons (make-bear 56 25 -179)
;;                      (cons (make-bear 0 0 0)
;;                            empty)))
;;               (cons (make-bear 56 25 -180)
;;                     (cons (make-bear 0 0 -1)
;;                           empty))) ; half LOB rotation
;; (check-expect (rotate-bears
;;                (cons (make-bear 125 400 -360)
;;                     (cons (make-bear 56 25 -180)
;;                     (cons (make-bear 0 0 -1)
;;                           empty))))
;;               (cons (make-bear 125 400 0)
;;                     (cons (make-bear 56 25 -180)
;;                     (cons (make-bear 0 0 -1)
;;                           empty)))) ; full LOB rotation
;; 
;; ;; Template: <use template from ListOfBear> 
;; 
;; ;; Definition:
;; (define (rotate-bears lob)
;;   (cond [(empty? lob) empty]
;;         [else
;;          (cons (fn-for-bear (first lob))
;;               (rotate-bears (rest lob)))]))
