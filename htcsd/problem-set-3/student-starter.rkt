#lang htdp/bsl
;; student-starter.rkt

;; =================
;; Data definitions:

; 
; PROBLEM A:
; 
; Design a data definition to help a teacher organize their next field trip. 
; On the trip, lunch must be provided for all students. For each student, track 
; their name, their grade (from 1 to 12), and whether or not they have allergies.
; 


;; Definition:
(define-struct student (name grade allergies))
;; Type: Student is (make-student String Natural[1,12] Boolean)
;; Interpretation: Personal info of a student.
;; Examples:
(define S1 (make-student "Jane" 12 true)) ; highest grade
(define S2 (make-student "John" 6 false)) ; middle grade, no allergies
(define S3 (make-student "Maria" 1 true)) ; lowest grade

#;
;; Template:
(define (fn-for-student s)
  (... (student-name      s)     ; String
       (student-grade     s)     ; Natural[1,12]
       (student-allergies s)))   ; Boolean

;; Template rules:
;;    - compount: 3 fields


;; =================
;; Functions:

; 
; PROBLEM B:
; 
; To plan for the field trip, if students are in grade 6 or below, the teacher 
; is responsible for keeping track of their allergies. If a student has allergies, 
; and is in a qualifying grade, their name should be added to a special list. 
; Design a function to produce true if a student name should be added to this list.
; 


;; Signature: Student -> Boolean
;; Purpose statement: The function consumes a Student and returns true
;;                    if said student is in grade 6 or bellow and has allergies.
;; Stub: (define (add-to-list? S1) false)

;; Examples/Tests:
(check-expect (add-to-list? S1) false) ; student is above 6 grade
(check-expect (add-to-list? S2) false) ; student does not have allergies
(check-expect (add-to-list? S3) true)  ; student has allergies and is bellow 6 grade

;; Template: <use template from Student> 

;; Definition:
(define (add-to-list? s)
  (and (<(student-grade s) 7) (student-allergies s)))

