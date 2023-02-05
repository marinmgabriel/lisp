;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Metalinguistic Abstraction   ;;
;; SICP Chapter 4               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; "the most fundamental idea in
;; programming:
;; The evaluator, which determines the
;; meaning of expresions in a programming
;; language, is just another program."


;; 4.1
;; Clasic version
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval
	     (first-operand exps) env)
	    (list-of-values
	     (rest-operands exps) env))))
;; left to right
(define (list-of-values-lr exps env)
  (if (no-operands? exps)
      '()
      (let ((first (eval (first-operand exps) env)))
	(cons first
	      (list-of-values-lr
	       (rest-operands exps)
	       env)))))
;; right to left
(define (list-of-values-rl exps env)
  (list-of-values-lr (reverse exps)
		     env))
(define (reverse lst)
  (if (null? lst)
      '()
      (append (reverse (cdr lst))
	      (list (car lst)))))
(reverse '(a b c d e f g))

(append '(a) '(b c))
(cons '(a) '(b c))

;; 4.1.2 Representing Expressions
(define false #f)
(define true #t)

(define (self-evaluating? exp)
  (cond ((number? exp) true)
	((string? exp) true)
	(else false)))

(define (variable? exp) (symbol? exp))

(define (quoted? exp)
  (tagged-list? exp 'quote))
(define (text-of-quotation exp)
  (cadr exp))
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

;; Assignments have the form
;; (set! <var> <value>)
(define (assignment? exp)
  (tagged-list? exp 'set))
(define (assignment-variable exp)
  (cadr exp))
(define (assignment-value exp)
  (caddr exp))

;; Definitions have the form
;; (define <var> <value>)
;; or
;; (define (<var> <param-1>...<param-n>))
;; equivalent to
;; (define <va>
;;   (lambda (<param-1> ... <param-n>)
;;     <body>))

(define (definition? exp)
  (tagged-list? exp 'lambda))
(define (lambda-parameters exp)
  (cadr exp))
(define (lambda-body exp)
  (caddr exp))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (caddr exp)))
      (cadddr exp)
      'false))
(define (make-if predicate
		 consequent
		 alternative)
  (list 'if
	predicate
	consequent
	alternative))
(define (begin? exp)
  (tagged-list? exp 'begin))
(define (begin-actions exp)
  (cdr exp))

(define (last-exp? seq)
  (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exp seq) (cdr seq))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
	((last-exp? seq) (first-exp seq))
	(else (make-begin seq))))

(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

;; Derivated expressions

(define cond-expr
  '(cond ((> x 0) x)
	((= x 0) (display 'zero) 0)
	(else (- x))))

(define (tagged-list? exp with)
  (eq? (car exp) with))
(define (cond? exp)
  (tagged-list? exp 'cond))
(cond? cond-expr)

(define (cond-clauses exp)
  (cdr exp))
(cond-clauses cond-expr)

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(cond-else-clause?
 (cond-clauses (cond-expr)))
(define (cond-predicate clause)
  (car clause))
(define (cond-actions clause)
  (cdr clause))
(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
	    (rest (cdr clauses)))
	(if (cond-else-clause? first)
	    (if (null? rest)
		(sequence->exp
		 (cond-actions first))
		(error "ELSE clause isn't last: COND->IF" clauses))
	    (make-if (cond-predicate first)
		     (sequence->exp
		      (cond-actions first))
		     (expand-clauses rest))))))

(expand-clauses (cond-clauses cond-expr))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
	((last-exp? seq) (first-exp seq))
	(else (make-begin seq))))
(define (last-exp? seq)
  (null? (cdr seq)))
(define (first-exp seq)
  (car seq))
(define (make-begin seq)
  (cons 'begin seq))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;; cond expression evaluation
(define cond-exp
  '(cond ((> x 0) x)
	 ((= x 0) (display 'zero) 0)
	 (else (- x))))

(define (cond? exp)
  (tagged-list? exp 'cond))
(define (tagged-list? exp with)
  (eq? (car exp) with))
(cond? cond-exp)

(define (cond-clauses exp)
  (cdr exp))
(cond-clauses cond-exp)

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause)
  (car clause))
(define (cond-actions clause)
  (cdr clause))
(define (cond-if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
	    (rest (cdr clauses)))
	(if (cond-else-clause? first)
	    (if (null? rest)
		(sequence->exp (cond-actions first))
		(error "ELSE clause isn't last: COND->IF" clauses))
	    (make-if (cond-predicate first)
		     (sequence->exp (cond-actions first))
		     (expand-clauses rest))))))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
	((last-exp? seq) (first-exp seq))
	(else (make-begin seq))))
(cond-if cond-exp)

;; Definition of eval:
(define )
