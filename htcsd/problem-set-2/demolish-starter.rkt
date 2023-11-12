#lang htdp/bsl
;; demolish-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; You are assigned to develop a system that will classify buildings in downtown
; Vancouver based on how old they are. 
; According to city guidelines, there are three different classification levels:
; new, old, and heritage.
; 
; Design a data definition to represent these classification levels. 
; Call it BuildingStatus.
; 

;; 1) Type: BuildingStatus is one of:
;;          - "new"
;;          - "old"
;;          - "heritage"
;; 2) Interpretation:  Classification according to the age of a building.
;; 3) Examples:
;;             <Examples for enumerations are redundant>
;; 4) Template:
#;
(define (fn-for-building-status bs)
  (cond [(= bs "new") (...bs)]
        [(= bs "new") (...bs)]
        [else (...bs)]))
;; 5) Template rules:
;;    - One of: 3 cases
;;              - atomic distinct "new".
;;              - atomic distinct "old".
;;              - atomic distinct "heritage"

;; =================
;; Functions:

; 
; PROBLEM B:
; 
; The city wants to demolish all buildings classified as "old". 
; You are hired to design a function called demolish? 
; that determines whether a building should be torn down or not.
; 

;; 2)
;; a_ Signature: BuildingStatus -> Boolean
;; b_ Purpose statement: The function consumes the status of a building
;;                       and produces true if it's old and needs
;;                       to be demolished. Heritage buildings are exempt
;;                       from demolition.
;; c_ Stub: (define (demolish? bs) false)

;; 3) Examples
;; a_ Calling (demolish? "new") should return the boolean "false".
;; b_ Calling (demolish? "old") should return the boolean "true".
;; c_ Calling (demolish? "heritage") should return the boolean "false".

;; 4) Template
#;
(define (demolish? bs)
  (if (string=? bs "old")
      true
      false))

;; 5) Definition
(define (demolish? bs)
  (if (string=? bs "old")
      true
      false))

;; 6) Testing
(check-expect (demolish? "new") false) ; as per 3)a_
(check-expect (demolish? "old") true) ; as per 3)b_
(check-expect (demolish? "heritage") false) ; as per 3)c_