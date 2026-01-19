(defun one-pass (lst)
    (cond ((null (cdr lst)) lst)
        ((> (car lst) (cadr lst))
         (cons (cadr lst) (one-pass (cons (car lst) (cddr lst)))))
        (t (cons (car lst) (one-pass (cdr lst))))))

(defun sort-constructive (lst &optional (n (length lst)))
  (if (<= n 1)
      lst
      (sort-constructive (one-pass lst) (1- n))))
(defun check-constructive (name input expected)
    (format t "~:[FAILED~;passed~] ~a~%"
          (equal (sort-constructive input) expected)
          name))

(defun test-constructive ()
  (check-constructive "test 1" '(5 3 4 1 2) '(1 2 3 4 5))
  (check-constructive "test 2" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-constructive "test 3" '(1 1 1 1 1) '(1 1 1 1 1))
  (check-constructive "test 4" '(2 2 3 3 1) '(1 2 2 3 3))
  (check-constructive "test 5" nil nil))

(defun sort-destructive (lst)
   (let* ((copy (copy-list lst))
         (len (length copy)))
    (dotimes (i len)
      (dotimes (j (- len 1))
        (when (> (nth j copy) (nth (1+ j) copy))
          (let ((temp (nth j copy)))
            (setf (nth j copy) (nth (1+ j) copy))
            (setf (nth (1+ j) copy) temp)))))
    copy))

(defun check-destructive (name input expected)
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (sort-destructive input) expected)
          name))

(defun test-second-function ()
  (check-destructive "test 1" '(5 3 4 1 2) '(1 2 3 4 5))
  (check-destructive "test 2" '(1 2 3 4 5) '(1 2 3 4 5))
  (check-destructive "test 3" '(1 1 1 1 1) '(1 1 1 1 1))
  (check-destructive "test 4" '(2 2 3 3 1) '(1 2 2 3 3))
  (check-destructive "test 5" nil nil))
