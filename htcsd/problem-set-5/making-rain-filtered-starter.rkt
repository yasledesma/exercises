#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

;; making-rain-filtered-starter.rkt

; 
; PROBLEM:
; 
; Design a simple interactive animation of rain falling down a screen.
; Wherever we click, a rain drop should be created and as time goes by
; it should fall. Over time the drops will reach the bottom of the screen
; and "fall off". You should filter these excess drops out of the world state.
; Otherwise your program is continuing to tick and and draw them long after
; they are invisible.
; 
; In your design pay particular attention to the helper rules. In our solution
; we use these rules to split out helpers:
;   - function composition
;   - reference
;   - knowledge domain shift
;   
;   
; NOTE: This is a fairly long problem.  While you should be getting more
; comfortable with world problems there is still a fair amount of work to do here.
; Our solution has 9 functions including main. If you find it is taking you
; too long then jump ahead to the next homework problem and finish this later.
; 
; 


;; Make it rain where we want it to.

;; =================
;; Constants:

(define WIDTH  300)
(define HEIGHT 300)

(define SPEED 0.5)

(define DROP (ellipse 4 8 "solid" "blue"))

(define MTS (rectangle WIDTH HEIGHT "solid" "light gray"))

;; =================
;; Data definitions:

(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. A raindrop on the screen, with x and y coordinates.

(define D1 (make-drop 10 30))

#;
(define (fn-for-drop d)
  (... (drop-x d) 
       (drop-y d)))

;; Template Rules used:
;; - compound: 2 fields


;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops

(define LOD1 empty)
(define LOD2 (cons (make-drop 10 20) (cons (make-drop 3 6) empty)))

#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))

;; Template Rules used:
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Drop ListOfDrop)
;; - reference: (first lod) is Drop
;; - self reference: (rest lod) is ListOfDrop

;; =================
;; Functions:

;; ListOfDrop -> ListOfDrop
;; start rain program by evaluating (main empty)
(define (main lod)
  (big-bang lod
    (on-mouse handle-mouse)     ; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
    (on-tick  next-drops SPEED) ; ListOfDrop -> ListOfDrop
    (to-draw  render-drops)))   ; ListOfDrop -> Image


;; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
;; if mevt is "button-down" add a new drop at that position
;(define (handle-mouse lod x y mevt) empty) ; stub

(check-expect (handle-mouse empty 25 60 "drag")            ; wrong mouse event
              empty)
(check-expect (handle-mouse empty 25 60 "button-down")     ; add to empty list
              (cons (make-drop 25 60) empty))
(check-expect (handle-mouse (cons (make-drop 25 30) empty) ; add to list with
                            150                            ; a single value
                            12
                            "button-down")
              (cons (make-drop 150 12)
                    (cons (make-drop 25 30)
                          empty)))
(check-expect (handle-mouse (cons (make-drop 150 12)       ; add to list with
                                  (cons (make-drop 25 30)  ; multiple values
                                        empty))
                            55
                            250
                            "button-down")
              (cons (make-drop 55 250)
                    (cons (make-drop 150 12)
                          (cons (make-drop 25 30)
                                empty))))

; use template from MouseEvent large enumeration

(define (handle-mouse lod x y mevt)
  (cond [(string=? mevt "button-down") (cons (make-drop x y) lod)]
        [else lod]))


;; ListOfDrop -> ListOfDrop
;; produce filtered and ticked list of drops
; (define (next-drops lod) empty) ; stub

(check-expect (next-drops empty) empty) ; filter and ticked an empty list
(check-expect (next-drops (cons (make-drop 45 HEIGHT)       ; list with a single
                                empty))                     ; filterable drop
              empty)
(check-expect (next-drops (cons (make-drop 5 125)           ; single element
                                (cons (make-drop 45 HEIGHT)
                                      empty)))
              (cons (make-drop 5 126) empty))
(check-expect (next-drops (cons (make-drop 5 HEIGHT)              ; keep middle
                                (cons (make-drop 125 125)         ; element +
                                      (cons (make-drop 45 HEIGHT) ; tick y
                                            empty))))
              (cons (make-drop 125 126) empty))
(check-expect (next-drops (cons (make-drop 5 HEIGHT)              ; keep the
                                (cons (make-drop 125 HEIGHT)      ; last element
                                      (cons (make-drop 45 125)    ; + tick y
                                            empty))))
              (cons (make-drop 45 126) empty))
(check-expect (next-drops (cons (make-drop 5 125)            ; keep all elements
                                (cons (make-drop 125 25)     ; and tick
                                      (cons (make-drop 45 100)
                                            empty))))
              (cons (make-drop 5 126)
                    (cons (make-drop 125 26)
                          (cons (make-drop 45 101)
                                empty))))

; use template from Function Composition

(define (next-drops lod)
  (tick-drops(remove-drops lod)))


;; ListOfDrop -> ListOfDrop
;; add 1 to the height (y) of all drops in a list.
; (define (tick-drops lod) lod) ; stub

(check-expect (tick-drops empty) empty)                   ; don't do anything
(check-expect (tick-drops (cons (make-drop 154 234)       ; single element list
                                empty))
              (cons (make-drop 154 235) 
                    empty))
(check-expect (tick-drops (cons (make-drop 5 125)         ; multi-element list
                                (cons (make-drop 45 88)
                                      empty)))
              (cons (make-drop 5 126)
                    (cons (make-drop 45 89)
                          empty)))

; use template from ListOfDrop (without reference, maybe?)

(define (tick-drops lod)
  (cond [(empty? lod) lod]
        [else
         (cons (tick-drop (first lod))
               (tick-drops (rest lod)))]))


;; Drop -> Drop
;; add 1 to the height (y) of a Drop.
; (define (tick-drop d) d) ; stub

(check-expect (tick-drop (make-drop 154 234))
              (make-drop 154 235))

; use template from Drop

(define (tick-drop d)
  (make-drop (drop-x d) (add1 (drop-y d))))


;; ListOfDrop -> ListOfDrop
;; remove from a list drops that have "fallen down".
;; ASSUME: a Drop has "fallen down" when it is at the bottom
;; of the screen (y = HEIGHT)
; (define (remove-drops lod) empty) ; stub

(check-expect (remove-drops empty) empty)      ; filter and ticked an empty list
(check-expect (remove-drops (cons (make-drop 45 HEIGHT)       ; list with a single
                                  empty))                     ; filterable drop
              empty)
(check-expect (remove-drops (cons (make-drop 5 HEIGHT)         ; list with multiple
                                  (cons (make-drop 125 HEIGHT) ; filterable drops
                                        (cons (make-drop 45 HEIGHT)
                                              empty))))
              empty)
(check-expect (remove-drops (cons (make-drop 5 125)            ; only keep
                                  (cons (make-drop 125 HEIGHT) ; the first element
                                        (cons (make-drop 45 HEIGHT)
                                              empty))))
              (cons (make-drop 5 125) empty))
(check-expect (remove-drops (cons (make-drop 5 HEIGHT)         ; keep the
                                  (cons (make-drop 125 125)    ; middle element
                                        (cons (make-drop 45 HEIGHT)
                                              empty))))
              (cons (make-drop 125 125) empty))
(check-expect (remove-drops (cons (make-drop 5 HEIGHT)         ; keep the
                                  (cons (make-drop 125 HEIGHT) ; last element
                                        (cons (make-drop 45 125)
                                              empty))))
              (cons (make-drop 45 125) empty))
(check-expect (remove-drops (cons (make-drop 5 125)          ; keep all elements
                                  (cons (make-drop 125 25)
                                        (cons (make-drop 45 100)
                                              empty))))
              (cons (make-drop 5 125)
                    (cons (make-drop 125 25)
                          (cons (make-drop 45 100)
                                empty))))

;; use template from ListOfDrop

(define (remove-drops lod)
  (cond [(empty? lod) lod]
        [else
         (if (fallen-drop? (first lod))   ; maybe this needs to be turned into
             (remove-drops (rest lod))    ; another helper?
             (cons (first lod) (remove-drops (rest lod))))]))


;; Drop -> Boolean
;; returns true if the drop has fallen (y = HEIGHT).
;(define (fallen-drop? d) false) ; stub

(check-expect (fallen-drop? (make-drop 24 HEIGHT)) true)
(check-expect (fallen-drop? (make-drop 55 125)) false)

;; use template from Drop

(define (fallen-drop? d)
  (>= (drop-y d) HEIGHT))


;; ListOfDrop -> Image
;; render the drops onto MTS
;(define (render-drops lod) MTS) ; stub

(check-expect (render-drops empty) MTS) ; render empty list
(check-expect (render-drops
               (cons (make-drop 56 125)
                     (cons (make-drop 25 25)
                           empty)))
              (place-image
               DROP
               (drop-x (make-drop 56 125))
               (drop-y (make-drop 56 125))
               (place-image
                DROP
                (drop-x (make-drop 25 25))
                (drop-y (make-drop 25 25))
                MTS))) ; render list with multiple elements

;; use template from ListOfDrop

(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else 
         (render-drop (first lod) (render-drops (rest lod)))]))


;; Drop -> Image
;; render a single Drop onto MTS
;(define (render-drop d) MTS) ; stub

(check-expect (render-drop (make-drop 56 125) MTS)        ; standard
              (place-image
               DROP
               (drop-x (make-drop 56 125))
               (drop-y (make-drop 56 125))
               MTS))
(check-expect (render-drop (make-drop WIDTH HEIGHT) MTS)  ; edge of canvas
              (place-image
               DROP
               (drop-x (make-drop WIDTH HEIGHT))
               (drop-y (make-drop WIDTH HEIGHT))
               MTS))

;; use template from Drop

(define (render-drop d img)
  (place-image
   DROP
   (drop-x d)
   (drop-y d)
   img))
