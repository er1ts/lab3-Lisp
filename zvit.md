<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПІСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Функціональний і імперативний
підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>

<p align="right"><b>Студент</b>: Скібчик Арсен група КВ-21</p>
<p align="right"><b>Рік</b>: 2026</p>

## Загальне завдання
Реалізувати алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.

### Вимоги до алгоритмів:
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
списку. Не допускається використання: псевдо-функцій, деструктивних операцій,
циклів . Також реалізована функція не має бути функціоналом (тобто приймати на
вхід функції в якості аргументів).
2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію 
copy-list (в разі необхідності). Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).

Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів

## Варіант 2(17)

Алгоритм сортування обміном №1 (без оптимізацій) за незменшенням
## Лістинг функції з використанням конструктивного підходу
```lisp
(defun one-pass (lst)
    (cond ((null (cdr lst)) lst)
        ((> (car lst) (cadr lst))
         (cons (cadr lst) (one-pass (cons (car lst) (cddr lst)))))
        (t (cons (car lst) (one-pass (cdr lst))))))

(defun sort-constructive (lst &optional (n (length lst)))
  (if (<= n 1)
      lst
      (sort-constructive (one-pass lst) (1- n))))
```
### Тестові набори та утиліти
```lisp
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
```
### Тестування
```lisp
CL-USER> (test-constructive)
passed test 1
passed test 2
passed test 3
passed test 4
passed test 5
NIL
```
## Лістинг функції з використанням деструктивного підходу
```lisp
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
```
### Тестові набори та утиліти
```lisp
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

```
### Тестування
```lisp
CL-USER> (test-destructive)
passed test 1
passed test 2
passed test 3
passed test 4
passed test 5
NIL
```
