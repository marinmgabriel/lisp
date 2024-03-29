(define (fib x)
  (cond 
    ((= x 0) 0)
    ((= x 1) 1)
    (else (+ (fib (- n 1))
             (fib (- n 2))))))

(define (fib x)
  (define (fib-iter prev sum count)
    (if (= count 0) sum
        (fib-iter (+ sum prev) prev (- count 1))))
  (fib-iter 1 0 x))

(+ 2 2)

(define (add-interval x y)
  (make-interval (+ (lower-bond x) (lower-bond y))
                 (+ (upper-bond x) (upper-bond y))))

(cons (cons 1 2)
      (cons 3 4))
(cons (cons 1 (cons 2 3)) 4)

(define one-through-four (list 1 2 3 4))

(car one-through-four)
(cdr one-through-four)

(car (cdr (cdr one-through-four)))
(cons 10 one-through-four)

(define (list-ref items n)
  (if (= n 0) (car items)
    (list-ref (cdr items) (- n 1))))

;; recursive style
(define (length items)
  (if (null? items) 0
    (+ 1 (length (cdr items)))))

(length one-through-four)

;; iterative style
(define (length items)
  (define (length-iter a count)
    (if (null? a) count
    (length-iter (cdr a) (+ count 1))))
  (length-iter items 0))

(length one-through-four)

(define odds (list 1 3 5 7))
(define squares (list 1 4 9 16 25))
(append odds squares)

(cdr (list2))

(define (last-pair items)
  (if (= (length items) 2) (cdr items)
    (last-pair (cdr items))))

(last-pair squares)

(cons 1 (cons 2 '()))

(length (cons 1 '()))
(length (list 1 2))

(define (reverse items)
  (define (helper a rev)
    (if (= (length a) 1) (append a rev)
      (helper (cdr a) (cons (car a) rev))))
  (helper items '()))

(reverse squares)

(define nil '())

(define (reverse items)
  (define (helper a rev)
    (if (null? a) rev
      (helper (cdr a) (append (car a) rev))))
  (helper items nil))
(reverse squares)

;; ex 2.20
(define (same-parity x . y)
  (define (helper a rev)
    (cond ((null? a) rev)
          ((even? (+ x (car a)))
           (helper (cdr a) (append rev (list (car a)))))
          (else (helper (cdr a) rev))))
  (helper y (list x)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 1 3 4 5 6 7)


(car (cdr (cdr (list 1 2 3 4 5))))


(append nil (list (car '(1 2 3))))

(define (scale-list items factor)
  (if (null? items) nil
    (cons (* (car items) factor)
          (scale-list (cdr items) factor))))

(scale-list (list 1 2 3 4 5) 10)

(map abs (list -10 2.5 -11.47 17))

(map (lambda (x y) (+ x (* 2 y)))
     (list 1 2 3)
     (list 4 5 6))

(define (scale-list items factor)
  (map (lambda (x) (* x factor))
       items))
(scale-list (list 1 2 3 4 5) 10)

(define (square-list items)
  (map square items))
(square-list (list 1 2 3 4 5))

;; ex 2.21
;; square list 
;; cons version
(define (square-list items)
  (if (null? items) nil
    (cons (square (car items)) (square-list (cdr items)))))
(square-list (list 1 2 3 4 5))
;; map version
(define (square-list items)
  (map (lambda (x) (square x))
       items))
(square-list (list 1 2 3 4 5))

;; ex 2.22
;; iter square-list
(define test-list (list 1 2 3 4 5))
(define nil '())
;; wrong version
(define (square-list items)
  (define (iter things answer)
    (if (null? things) answer
      (iter (cdr things)
            (cons (square (car things)) answer))))
  (iter items nil))
;; working version
(define (square-list items)
  (define (iter things answer)
    (if (null? things) answer
      (iter (cdr things)
            (append  answer (list (square (car things)))))))
  (iter items nil))
(square-list test-list)
;; testing
(append (list 1) '())
(cons (cons '(1) '(2)) '(3))
(append (append '(1) '(2)) '(3))

;; ex 2.23
(display 3)
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))
;; for-each implementation
(define (for-each-new expr items)
  (if (null? items) #t
    (and (expr (car items)) (for-each-new expr (cdr items)))))
(for-each-new (lambda (x) (newline) (display x))
              (list 1 2 3 4))

;; Hierarchical structures
(cons (list 1 2) (list 3 4))
(define x (cons (list 1 2) (list 3 4)))
(list x x)
(length (list x x))

(define (count-leaves items)
  (cond ((null? items) 0)
        ((not (pair? items)) 1)
        (else (+ (count-leaves (car items))
                 (count-leaves (cdr items))))))

(count-leaves x)
(count-leaves (list x x))

;; ex 2.24
(list 1 (list 2 (list 3 4)))
;; => (1 (2 (3 4)))

;; ex 2.25
;; (1 3 (5 7) 9) =>
(list 1 3 (list 5 7) 9)
;; ((7)) =>
(list (list 7))
;; (1 (2 (3 (4 (5 (6 7)))))) =>
(list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))

;; ex 2.26
(define x (list 1 2 3))
(define y (list 4 5 6))
(append x y) ;; => (1 2 3 4 5 6)
(cons x y) ;; => ((1 2 3) 4 5 6)
(list x y) ;; => ((1 2 3) (4 5 6))

;; ex 2.27
(define x (list (list 1 2) (list 3 4)))

;; some tests 
(define (reverse items)
  (define (helper a rev)
    (if (= (length a) 1) (append a rev)
      (helper (cdr a) (cons (car a) rev))))
  (helper items nil))

(define (deep-reverse items)
  (define (helper a res)
    (cond ((null? a) res)
          ((not (pair? (car a)))
           (helper (cdr a) (cons (car a) res)))
          (else (deep-reverse 
                  (cdr a)
                  (cons (deep-reverse (car a)) res)))))
  (helper items nil))

(define (reverse items)
  (define (helper a res)
    (if (null? a) res
      (helper (cdr a) (cons (car a) res))))
  (helper items nil))

;; solution
(define (deep-reverse items)
  (define (helper a res)
    (cond ((null? a) res)
          ((not (pair? (car a)))
           (helper (cdr a) (cons (car a) res)))
          (else 
            (helper (cdr a) (cons (deep-reverse (car a)) res)))))
  (helper items nil))
;; shorter solution
(define (deep-reverse items)
  (cond ((null? items) nil)
        ((not (pair? items)) items)
        (else (append (deep-reverse (cdr items))
                      (list (deep-reverse (car items)))))))

(reverse x)
(deep-reverse x)

;; 2.28
(define x (list (list 1 2) (list 3 4)))
(display x)

;; cond variant
(define (fringe items)
  (cond ((null? items) nil)
        ((not (pair? (car items)))
         (cons (car items) (fringe (cdr items))))
        (else
          (append (fringe (car items))
                  (fringe (cdr items))))))
;; let variant 
(define (fringe items)
  (if (null? items)
    nil
    (let ((first (car items)))
      (if (not (pair? first))
        (cons first (fringe (cdr items)))
        (append (fringe first) (fringe (cdr items)))))))
(fringe x)

;; 2.29
;; using list
(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cdr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cdr branch))
;; incomplete

;; Mapping over trees
;; without map
(define (scale-tree tree factor)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (* tree factor))
        (else (cons (scale-tree (car tree) factor)
                    (scale-tree (cdr tree) factor)))))
(define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(display x)
(scale-tree x 10)
;; with map
(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (scale-tree sub-tree factor)
           (* sub-tree factor)))
       tree))
(scale-tree x 10)

;; 2.30
;; without map
(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (square tree))
        (else
          (cons (square-tree (car tree))
                (square-tree (cdr tree))))))
(square-tree x)
;; with map
(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (square-tree sub-tree)
           (square sub-tree)))
       tree))
(square-tree x)

;; 2.31
(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (tree-map f sub-tree)
           (f sub-tree)))
       tree))
(tree-map cube x)

;; 2.32
(define x (list 1 2 3))
(define (subsets items)
  (if (null? items)
    (list nil)
    (let ((rest (subsets (cdr items))))
      (append rest (map (lambda (x) (cons (car items) x)) rest)))))
(subsets x)

;; 2.2.3 Sequences as Conventional Interfaces
(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
        ((not (pair? tree))
         (if (odd? tree) (square tree) 0))
        (else (+ (sum-odd-squares (car tree))
                 (sum-odd-squares (cdr tree))))))
                                  
(define (even-fibs n)
  (define (next k)
    (if (> k n)
      nil
      (let ((f (fib k)))
        (if (even? f)
          (cons f (next (+ k 1)))
          (next (+ k 1))))))
  (next 0))

;; filter implementation
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else
          (filter predicate (cdr sequence)))))
(filter odd? (list 1 2 3 4 5))

;; acumulator implementation
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) 
        (accumulate op initial (cdr sequence)))))
(accumulate + 0 (list 1 2 3 4 5))
(accumulate cons nil (list 1 2 3 4 5))
(accumulate * 1 (list 1 2 3 4 5))

;; enumerator
(define nil '())
(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 1 5)

;; tree enumerator
(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(enumerate-tree (list 1 (list 2 (list 3 4)) 5))

(define x (list 1 (list 2 (list 3 4)) 5))

(define (sum-odd-squares tree)
  (accumulate +
             0
             (map square
                  (filter odd?
                          (enumerate-tree tree)))))
(sum-odd-squares x)

(define (product-of-squares-of-odd-elements sequence)
  (accumulate *
              1
              (map square
                   (filter odd? sequence))))
(product-of-squares-of-odd-elements (list 1 2 3 4 5))

;; Enumerator
(define nil '())
(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))
(enumerate-interval 1 5)

;; Filter
(define (filter predicate items)
  (cond ((null? items) nil)
        ((predicate (car items))
         (cons (car items) (filter predicate (cdr items))))
        (else
          (filter predicate (cdr items)))))
(filter odd? (enumerate-interval 1 5))

;; Transformator -> Map...

;; Acumulator
(define (accumulator op initial items)
  (if (null? items)
    initial
    (op (car items) 
        (accumulator op initial (cdr items)))))
(accumulator + 0 (filter odd? (enumerate-interval 1 5)))

;; --------------------------------------------------------
;; Main takeway
;; Programs can be reasoned about like this:
;; Enumerator -> Filter -> map(Transformator) -> Acumulator
;; EFTA or ETFA
;; --------------------------------------------------------


;; ex 2.33
(define (my-map p items)
  (accumulator (lambda (x y) 
                (cons (p x) y)) 
              nil 
              items))
(map square (list 1 2 3 4))
(my-map square (list 1 2 3 4))

;; ex 2.34
(define (horner-eval x coefficient-sequence)
  (accumulator (lambda (this-coeff higher-term) 
                 (+ this-coeff (* x higher-term)))
                0
                coefficient-sequence))
(horner-eval 2 (list 1 3 0 5 0 1))
;; 1 + 3 * 2 + 2 * 2^2 = 1 + 6 + 2 * 4 = 1 + 6 + 8 = 15
(horner-eval 2 (list 1 3 2))

;; ex 2.35
(define (count-leaves tree)
  (accumulator +
               0
               (map (lambda (node)
                      (if (pair? node) 
                        (count-leaves node)
                        1))
                    tree)))
(count-leaves (list 1 (list 2 (list 3 4) 5)))

;; ex 2.36
(define (accumulate op init seq)
  (if (null? seq)
    init
    (op (car seq) (accumulate op init (cdr seq)))))
(accumulate + 0 (list 1 2 3))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons 
      (accumulate op init (map (lambda (seq) (car seq)) seqs))
      (accumulate-n op init (map (lambda (seq) (cdr seq)) seqs)))))

(define x (list (list 1 2 3) 
                (list 4 5 6) 
                (list 7 8 9)
                (list 10 11 12)))
(car x)
(display x)
(accumulate-n + 0 x)

(map * (list 1 2 3) (list 1 2 3))

;; ex 2.37
(define vec (list 1 2 3))
(define mat (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
(dot-product vec vec)

(define (matrix-*-vector m v)
  (map (lambda (mv)
         (dot-product mv v)) m))
(matrix-*-vector mat vec)

(define (transpose mat)
  (accumulate-n cons nil mat))
(transpose mat)

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (mv)
           (matrix-*-vector cols mv))
         m)))
(matrix-*-matrix mat mat)

;; ex 2.38
(define (fold-right op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (op (car rest)
          (iter result (cdr rest)))))
  (iter initial sequence))

(define (fold-left op initial sequence) 
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))

(fold-right + 0 (list 1 2 3))
(fold-left + 0 (list 1 2 3))
(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list nil (list 1 2 3))
;; (1 (2 (3 ())))
(fold-left list nil (list 1 2 3))
;; (((() 1 ) 2) 3)

;; ex 2.39
(fold-left 
  (lambda (x y) (cons y x))
  nil 
  (list 1 2 3))
(define (reverse-right sequence)
  (fold-right (lambda (x y) 
                (append y (list x))) 
              nil 
              sequence))
(define (reverse-left sequence)
  (fold-left (lambda (x y)
               (cons y x))
             nil
             sequence))
(reverse-right (list 1 2 3))
(reverse-left (list 1 2 3))

;; Nested mappings >>> nested loops
;; 1 <= j < i <= n with i + j is prime
;; generate pairs (i j (+ i j))
(define nil '())
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (prime? x)
  (= x (smallest-divisor x)))
(define (smallest-divisor x)
  (find-divisor x 2))
(define (find-divisor x test-divisor)
  (cond ((> (square test-divisor) x) x)
	((divides? test-divisor x) test-divisor)
	(else (find-divisor x (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
(define (enumerate-interval low high)
  (if (> low high)
    nil
    (cons low (enumerate-interval (+ low 1) high))))
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence) 
        (accumulate op initial (cdr sequence)))))
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap
                 (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 n)))))
(prime-sum-pairs 6)

;; enumerate all ordered pairs less than equal to n
;; filter those pairs whose sum is prime
;; for each pair that pass the filter produce a triple (i,j,i+j)
(define nil '())
(define (permutations s)
  (if (null? s)
    (list nil)
    (flatmap (lambda (x)
               (map (lambda (p) (cons x p))
                    (permutations (remove x s))))
             s)))
(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))
(permutations (list 1 2 3))
