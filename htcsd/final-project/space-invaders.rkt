#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)
;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define SPACESHIP-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)
(define INVADE-RATE 100)

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define SPACESHIP
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define MISSILE (ellipse 5 15 "solid" "red"))

(define SPACESHIP-HEIGHT/2 (/ (image-height SPACESHIP) 2))


;; Data Definitions:

(define-struct game (invaders missiles spaceship))
;; Game is (make-game  (listof Invader) (listof Missile) Spaceship)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and spaceship position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-spaceship (game-spaceship s))))


(define-struct spaceship (x dir))
;; Spaceship is (make-spaceship Number Integer[-1, 1])
;; interp. the spaceship location is x, HEIGHT - SPACESHIP-HEIGHT/2
;;         in screen coordinates.
;;         the spaceship moves SPACESHIP-SPEED pixels per clock tick left
;;         if dir -1, right if dir 1.

(define T0 (make-spaceship (/ WIDTH 2) 1))   ;center going right
(define T1 (make-spaceship 50 1))            ;going right
(define T2 (make-spaceship 50 -1))           ;going left

#;
(define (fn-for-spaceship t)
  (... (spaceship-x t) (spaceship-dir t)))



(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Number)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader along x by dx pixels per clock tick

(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                               ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))


(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T2))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))


;; Function Definitions:

;; Main:

;; Game -> Game
;; starts a space invaders game by evaluating (main G0)
(define (main g)
  (big-bang g
    (name         "Space Invaders")
    (display-mode "fullscreen")
    (on-key       handle-keys)                       ; Game KeyEvent -> Game
    (on-tick      change-game-state SPACESHIP-SPEED) ; Game -> Game
    (to-draw      render-game)                       ; Game -> Image
    (stop-when    game-over?)))                      ; Game -> Boolean


;; Helpers:

;; Game KeyEvent -> Game
;; produce a new game state depending on which key is pressed.
;; keys: "Left", "Right", " " (space key).
;; (define (handle-keys G0 "") G0) ; stub

; do nothing
(check-expect (handle-keys G0 "a") G0)
; change direction to the left
(check-expect (handle-keys G0 "left")
              (make-game
               (game-invaders G0)
               (game-missiles G0)
               (make-spaceship
                (spaceship-x
                 (game-spaceship G0))
                -1)))
; change direction to the right
(check-expect (handle-keys G1 "right")
              (make-game
               (game-invaders G1)
               (game-missiles G1)
               (make-spaceship (spaceship-x (game-spaceship G1)) 1)))
; add missile to empty list
(check-expect (handle-keys G1 " ")
              (make-game
               (game-invaders G1)
               (cons (make-missile (spaceship-x (game-spaceship G1)) 0) (game-missiles G1))
               (game-spaceship G1)))
; add missile to list with multiple elements
(check-expect (handle-keys G2 " ")
              (make-game
               (game-invaders G2)
               (cons (make-missile (spaceship-x (game-spaceship G2)) 0) (game-missiles G2))
               (game-spaceship G2)))

;; use template for Enumeration

(define (handle-keys g ke)
  (cond [(key=? " " ke)
         (make-game (game-invaders g)
                    (add-missile (make-missile (spaceship-x (game-spaceship g)) 0) (game-missiles g))
                    (game-spaceship g))]
        [(key=? "right" ke)
         (make-game (game-invaders g)
                    (game-missiles g)
                    (change-dir (game-spaceship g) 1))]
        [(key=? "left" ke)
         (make-game (game-invaders g)
                    (game-missiles g)
                    (change-dir (game-spaceship g) -1))]
        [else g]))


;; Missile ListOfMissile -> ListOfMissile
;; add a new missile to a list of missiles.
;; (define (add-missile M1 empty) empty) ; stub

; add to empty list
(check-expect (add-missile (make-missile 23 0) empty) (list (make-missile 23 0)))
; add to list with multiple elements
(check-expect (add-missile
               (make-missile 23 0)
               (list
                (make-missile 200 130)
                (make-missile 23 10)))
              (list (make-missile 23 0)
                    (make-missile 200 130)
                    (make-missile 23 10)))

;; use template for Missile

(define (add-missile m lom)
  (cons m lom))


;; Spaceship -> Spaceship
;; change the direction of a Spaceship.
;; (define (change-dir s dir) (make-spaceship 0 -1)) ; stub

; do nothing
(check-expect (change-dir T1 5)
              (make-spaceship (spaceship-x T1) (spaceship-dir T1)))
; move to the left
(check-expect (change-dir T1 -1) (make-spaceship (spaceship-x T1) -1))
; move to the right
(check-expect (change-dir T2 1) (make-spaceship (spaceship-x T2) 1))

;; use template for Spaceship

(define (change-dir s dir)
  (cond [(= -1 dir) (make-spaceship (spaceship-x s) -1)]
        [(= 1 dir) (make-spaceship (spaceship-x s) 1)]
        [else s]))


;; Game -> Game
;; produce the next state of the game.
;; !!!
(define (change-game-state g) G0) ; stub


;; Game -> Image
;; render an image of the current game state.
;; !!!
(define (render-game g) empty-image) ; stub


;; Game -> Boolean
;; produce true if the game lost. otherwise, produce false.
;; ASSUME: a game is lost when an Invader gets in contact with
;;         the base of the Game image, or with the Spaceship.
;; !!!
(define (game-over? g) false) ; stub
