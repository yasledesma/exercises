#lang htdp/bsl

;; insert-starter.rkt

; 
; PROBLEM:
; 
; Design a function that consumes an Integer, String and BST, and adds a node
; that has the given key and value to the tree. The node should be inserted in 
; the proper place in the tree. The function can assume there is not already 
; an entry for that number in the tree. The function should produce the new BST.
; 
; Do not worry about keeping the tree balanced. We will come back to this later.
; 


;; Data definitions:

(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree

(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             false))
(define BST10 (make-node 10 "why" BST3 BST42))

; .

#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic-distinct: false
;;  - compound: (make-node Integer String BST BST)
;;  - self reference: (node-l t) has type BST
;;  - self reference: (node-r t) has type BST


;; =================
;; Functions:

;; Integer String BST -> BST
;; add a new node to a BST.
;(define (insert-node 0 "" BST0) BST0) ; stub

;; add node to empty BST
(check-expect (insert-node 2 "djh" BST0) (make-node 2 "djh" false false))
;; add node to single-node BST on R subtree
(check-expect (insert-node 2 "djh" BST1)
              (make-node 1 "abc" false (make-node 2 "djh" false false)))
;; add node to muli-node BST (with L and R subtrees) on L
(check-expect (insert-node 0 "xyz" BST3)
              (make-node 3 "ilk"
                         (make-node 1 "abc"
                                    (make-node 0 "xyz" false false) false)
                         (make-node 4 "dcj" false
                                    (make-node 7 "ruf" false false))))
;; add node to muli-node BST (with L and R subtrees) on R
(check-expect (insert-node 40 "xyz" BST10)
              (make-node 10 "why"
                         (make-node 3 "ilk"
                                    (make-node 1 "abc"
                                               false
                                               false)
                                    (make-node 4 "dcj"
                                               false
                                               (make-node 7 "ruf" false false)))
                         (make-node 42 "ily"
                                    (make-node 27 "wit"
                                               (make-node 14 "olp" false false)
                                               (make-node 40 "xyz" false false))
                                    false)))

;; use template from BST + modifications
#;
(define (fn-for-bst k v t)
  (cond [(false? t) (... k v)]
        [else
         (... k
              v
              (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst k v (node-l t))
              (fn-for-bst k v (node-r t)))]))

(define (insert-node k v t)
  (cond [(false? t) (make-node k v false false)]
        [else
         (cond [(< k (node-key t))
                (make-node (node-key t)
                           (node-val t)
                           (insert-node k v (node-l t))
                           (node-r t))]
               [(> k (node-key t))
                (make-node (node-key t)
                           (node-val t)
                           (node-l t)
                           (insert-node k v (node-r t)))])]))

