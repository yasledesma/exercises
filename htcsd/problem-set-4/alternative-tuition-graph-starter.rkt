#lang htdp/bsl
(require 2htdp/image)
;; alternative-tuition-graph-starter.rkt

; 
; Consider the following alternative type comment for Eva's school tuition 
; information program. Note that this is just a single type, with no reference, 
; but it captures all the same information as the two types solution in the 
; videos.
; 
; (define-struct school (name tuition next))
; ;; School is one of:
; ;;  - false
; ;;  - (make-school String Natural School)
; ;; interp. an arbitrary number of schools, where for each school we have its
; ;;         name and its tuition in USD
; 
; (A) Confirm for yourself that this is a well-formed self-referential data 
;     definition.
; 
; (B) Complete the data definition making sure to define all the same examples as 
;     for ListOfSchool in the videos.
; 
; (C) Design the chart function that consumes School. Save yourself time by 
;     simply copying the tests over from the original version of chart.
; 
; (D) Compare the two versions of chart. Which do you prefer? Why?
; 


;; (A) Confirm for yourself that this is a well-formed self-referential data 
;;     definition:
;;     It looks like a well-formed, short-hand data definition that combines School
;;     with ListOfSchool via adding an aditional parameter in the School struct
;;     that takes another School struct as an argument, making the struct definition
;;     self-referential (and list-like, since it appends a School at the end of its
;;     definition.)


;; (B) Complete the data definition making sure to define all the same examples
;;     as for ListOfSchool in the videos.

;; ====================
;; CONSTANTS
;; ====================
(define BHEIGHT 30)
(define DENOMINATOR 100)


;; ====================
;; DATA DEFINITIONS
;; ====================
(define-struct school (name tuition))
;; Type: School is (make-school String Natural)
;; Interpretation: Name of a school, and how much tuition costs there.
;; Examples:
(define S1 (make-school "Nevermore" 35000))
(define S2 (make-school "Sunnydale" 15580))

#;
;; Template:
(define (fn-for-school s)
  (... (school-name    s)     ; String
       (school-tuition s)))   ; Natural

;; Template rules:
;;    - compount: 2 fields

;; --------------------

;; Type: ListOfSchool is one of:
;;           - empty
;;           - (cons School ListOfSchool)
;; Interpretation: A list of schools.
(define LOS1 empty)
(define LOS2 (cons S1 empty))
(define LOS3 (cons S2 (cons S1 empty)))

#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los))
              (fn-for-loi (rest los)))]))

;; Template rules:
;;  - one of: 2 cases
;;      - atomic distinct: empty
;;      - compound: (cons School ListOfSchool)
;;  - reference: (first los) is School
;;  - self-reference: (rest los) is ListOfSchool


;; (C) Design the chart function that consumes School. Save yourself time
;;     by simply copying the tests over from the original version of chart.

;; Define: draw-chart
;; Signature: ListOfSchool -> Image
;; Purpose statement: The function consumes a list of schools and returns
;;                    an informational chart with each school's name and
;;                    tuition costs.
;; Stub: (define (draw-chart (cons ((make-school "" 0) empty)))
;;         (rectangle 0 0 "solid" "white"))

;; Examples/Tests:
(check-expect (draw-chart LOS1)
              (rectangle 0 0 "solid" "white")) ; empty case
(check-expect (draw-chart LOS2)
              (above/align "left"
               (overlay/align "left" "center"
                              (text
                                (string-append (school-name S1)
                                               " $"
                                               (number->string
                                                 (school-tuition S1)))
                                15
                                "black")
                              (rectangle
                                (/ (school-tuition S1) DENOMINATOR)
                                BHEIGHT
                                "solid"
                                "lightgreen")
                              (rectangle
                                (/ (school-tuition S1) DENOMINATOR)
                                BHEIGHT
                                "outline"
                                "blue"))
               (rectangle 0 0 "solid" "white"))) ; single element
(check-expect (draw-chart LOS3)
              (above/align "left"
               (overlay/align "left" "center"
                              (text
                                (string-append (school-name S2)
                                               " $"
                                               (number->string
                                                 (school-tuition S2)))
                                15
                                "black")
                              (rectangle
                                (/ (school-tuition S2) DENOMINATOR)
                                BHEIGHT
                                "solid"
                                "lightgreen")
                              (rectangle
                                (/ (school-tuition S2) DENOMINATOR)
                                BHEIGHT
                                "outline"
                                "blue"))
               (overlay/align "left" "center"
                              (text
                                (string-append (school-name S1)
                                               " $"
                                               (number->string
                                                 (school-tuition S1)))
                                15
                                "black")
                              (rectangle
                                (/ (school-tuition S1) DENOMINATOR)
                                BHEIGHT
                                "solid"
                                "lightgreen")
                              (rectangle
                                (/ (school-tuition S1) DENOMINATOR)
                                BHEIGHT
                                "outline"
                                "blue"))
               (rectangle 0 0 "solid" "white"))) ; multi element

;; Template: <use template from ListOfSchool 

;; Definition:
(define (draw-chart los)
  (cond [(empty? los) (rectangle 0 0 "solid" "white")]
        [else
         (above/align "left"
                      (draw-bar (first los))
                      (draw-chart (rest los)))]))

;; --------------------

;; Define: draw-bar
;; Signature: School -> Image
;; Purpose statement: The function consumes a School and returns an scaled-down
;;                    image of an information bar.
;; Stub: (define (draw-bar s)
;;         (overlay/align "left" "center"
;;                        (text (string-append " $"
;;                                             (number->string 0))
;;                                             15
;;                                             "black")
;;                        (rectangle 0 0 "solid" "lightgreen")
;;                        (rectangle 0 0 "outline" "blue")))

;; Examples/Tests:
(check-expect (draw-bar S1)
              (overlay/align "left" "center"
                             (text
                               (string-append (school-name S1)
                                              " $"
                                              (number->string
                                              (school-tuition S1)))
                               15
                               "black")
                             (rectangle
                               (/ (school-tuition S1) DENOMINATOR)
                               BHEIGHT
                               "solid"
                               "lightgreen")
                             (rectangle
                               (/ (school-tuition S1) DENOMINATOR)
                               BHEIGHT
                               "outline"
                               "blue")))

;; Template: <use template from School> 

;; Definition:
(define (draw-bar s)
  (overlay/align "left" "center"
                 (text
                   (string-append (school-name s)
                                  " $"
                                  (number->string (school-tuition s)))
                   15
                   "black")
                 (rectangle
                   (/ (school-tuition s) DENOMINATOR)
                   BHEIGHT
                   "solid"
                   "lightgreen")
                 (rectangle
                   (/ (school-tuition s) DENOMINATOR)
                   BHEIGHT
                   "outline"
                   "blue")))

