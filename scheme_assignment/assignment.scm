;;; Base Case: L is empty, return 0
;;; Assumption: (count-numbers M) returns a count of the numbers in M, for
;;; any list M smaller than L (including (car L) and (cdr L)).
;;; Step: If (car L) is a list, then return the sum of the count of the
;;; numbers in (car L) and the count of the numbers in (cdr L).
;;; If (car L) is a number, return 1 plus the count of the numbers in
;;; (cdr L). Otherwise, return the count of the numbers in (cdr L).
(define (count-numbers L)
 (cond ((null? L) 0)
       ((number? (car L)) (+ 1 (count-numbers (cdr L))))
       ((list? (car L)) (+ (count-numbers (car L)) (count-numbers (cdr L))))       
       (else (+ 0 (count-numbers (cdr L))))
 )
)

;;; Base Case: L is empty, return list of just x
;;; Assumption: (insert x M) returns a sorted list of list containing x
;;; and the contents of M for any list M smaller than L.
;;; Step: If x is less than than the first element of L (car L)
;;; return a list of x in the beginning of the list L (cons x L)
;;; Otherwise return the sorted list of x and (cdr L)
(define (insert x L)
 (cond ((null? L) (list x))
       ((< x (car L)) (cons x L))
       (else (cons (car L) (insert x (cdr L))))
 )
)

;;; Base Case: L is empty, return sorted list M
;;; Assumption: (insert-all N M) returns the sorted list containing the
;;; sorted elements of N and M for any list N smalled than L.
;;; Step: Return the sorted list of N (cdr L) and M and insert the first element (car L)
(define (insert-all L M)
 (cond ((null? L) M)
       (else (insert-all (cdr L) (insert (car L) M)))
 )
)

;;; Base Case:  L is empty, return a list with the element to be inserted
;;; Assumption: (sort M) returns a sorted list in ascending order for the elements of M, 
;;; for any list M smaller than L.
;;; Step: Insert of the first element of L (car L) into the sorted list M (cdr L)
;;; Step: If element to be inserted (x) is less than the first element of L (car L), return
;;; a list starting with x and the rest of the elements of L. Otherwise return a list
;;; starting with the first element of L (car L) and the inserted x in the rest of L (cdr L)
(define (sort L)
 (letrec
 	((insert (
 			lambda (x L) 
 				(cond ((null? L) (list x))
 					  ((< x (car L)) (cons x L))
 					  (else (cons (car L) (insert x (cdr L))))
 				)
	  )
 	))
 	(cond ((null? L) L)
 		  (else (insert (car L) (sort (cdr L))))
 	)
 )
)


(define (translate op)
 (cond ((eq? op '+) +)
 	   ((eq? op '-) -)
 	   ((eq? op '*) *)
 	   ((eq? op '/) /)
 )
)

(define (postfix-eval exp)
 (cond ((null? exp) exp)
 	   ((number? exp) exp)
 	   ((list? exp) ((translate (caddr exp)) (postfix-eval (car exp))  (postfix-eval (cadr exp))))
 )
)


;;; Base Case: L is empty, return the set containing the empty set, i.e. ’(()).
;;; Assumption: (powerset M) returns the powerset of M, for any set M smaller 
;;; than L (including (cdr L)).
;;; Step: Return a list whose elements combine the powerset of M and the list 
;;; which inserts the first element of L (car L) into the powerset of M.
(define (powerset L)
 (cond ((null? L) (list L))
 	   (else (append 
 	   			(powerset (cdr L)) 
 	   			(map 
 	   				(lambda (x) (cons (car L) x)) 
 	   				(powerset (cdr L))
 	   			)
 	   	     )
 	   )
 )
)