#lang racket/gui

(define myframe (new frame% [label "Route Planner"]
                     [width 200] [height 200] ))

(define combo-field (new combo-field%
                         (label "Starting Point")
                         (parent myframe)
                         (choices (list "A" "B" "C"))
                         ))


(define combo-field2 (new combo-field%
                         (label "Destination Point")
                         (parent myframe)
                         (choices (list "A" "B" "C"))
                         ))

(define options 
  (new radio-box%
       [label "Option"]
       [parent myframe]
       [choices (list "Duration" "Price" "Directions")]
       ))


[new button%
  [parent myframe]
  [label "Start"]
  [callback (lambda (button event)
              (let* ((index (send options get-selection))
                     (starting-point (send combo-field get-value))
                     (destination-point (send combo-field2 get-value)))
               (cond
                  [(= index 0)
                   (let ((time (cond ((and (equal? starting-point "A") (equal? destination-point "B")) 5)
                                     ((and (equal? starting-point "B") (equal? destination-point "C")) 7)
                                     ((and (equal? starting-point "A") (equal? destination-point "C")) 12)
                                     ((and (equal? starting-point "B") (equal? destination-point "A")) 5)
                                     ((and (equal? starting-point "C") (equal? destination-point "B")) 7)
                                     ((and (equal? starting-point "C") (equal? destination-point "A")) 12)
                                     (else "0 "))))
                     (send message set-label (format "Duration: ~a minutes" time)))]
                  [(= index 1)
                   (let ((cost (cond ((and (equal? starting-point "A") (equal? destination-point "B")) 1.75)
                                     ((and (equal? starting-point "B") (equal? destination-point "C")) 1.75)
                                     ((and (equal? starting-point "A") (equal? destination-point "C")) 3.5)
                                      ((and (equal? starting-point "B") (equal? destination-point "A")) 1.75)
                                     ((and (equal? starting-point "C") (equal? destination-point "B")) 1.75)
                                     ((and (equal? starting-point "C") (equal? destination-point "A")) 3.5)
                                     (else "Free" ))))
                     (send message set-label (format "Price: ~a £" cost )))]
                  [(= index 2)
                   (let ((instruction (cond ((and (equal? starting-point "A") (equal? destination-point "B")) "Walk 1min to Stop X")
                                     ((and (equal? starting-point "B") (equal? destination-point "C")) "Across the street to Stop K")
                                     ((and (equal? starting-point "A") (equal? destination-point "C")) "Walk 1min to Stop X and across to the street to Stop K")
                                     ((and (equal? starting-point "B") (equal? destination-point "A")) "Go to Stop Y")
                                     ((and (equal? starting-point "C") (equal? destination-point "B")) "Take bus at Stop J")
                                     ((and (equal? starting-point "C") (equal? destination-point "A")) "Take bus at Stop J and go to Stop Y")
                                     (else  "Please select correct Location" ))))
                     (send message set-label (format "~a" instruction)))]
                  [else (send message set-label "Invalid option")] )))]
]


(define message (new message%
                     (parent myframe)
                     [stretchable-width #t]
                     [stretchable-height #t]
                     [auto-resize #t]
                     (font (make-object font% 15 'default 'normal 'normal))
                     (label "Message"))) 


(send myframe show #t)

