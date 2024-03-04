--1
SELECT s.id AS student_id, s.fullname AS student_name, ROUND(AVG(g.grade), 2) AS average_grade
FROM students s
JOIN grades g ON s.id = g.student_id
GROUP BY s.id, s.fullname
ORDER BY average_grade DESC
LIMIT 5;

--2
SELECT s.id AS student_id, s.fullname AS student_name, ROUND(AVG(g.grade), 2) AS average_grade
FROM students s
JOIN grades g ON s.id = g.student_id
WHERE g.subject_id = 1
GROUP BY s.id, s.fullname
ORDER BY average_grade DESC
LIMIT 1;

--3
SELECT g.subject_id, s.group_id, AVG(g.grade) AS average_grade
FROM grades g
JOIN students s ON g.student_id = s.id
WHERE g.subject_id = 1
GROUP BY g.subject_id, s.group_id;

--4
SELECT AVG(g.grade) AS average_grade
FROM grades g;

--5
SELECT t.fullname, s.name AS subject_name
FROM subjects s 
JOIN teachers t ON t.id = s.teacher_id 
WHERE teacher_id = 2;

--6
SELECT s.fullname, g.name 
FROM students s
JOIN groups g ON s.group_id = g.id
WHERE g.id = 3;

--7
SELECT s.fullname AS student_name, g.grade, s2.name AS subject_name
FROM grades g
JOIN students s ON g.student_id = s.id
JOIN subjects s2  ON g.subject_id = s2.id
WHERE g.subject_id = 2;

--8
SELECT t.fullname, AVG(g.grade) AS average_grade
FROM teachers t 
JOIN subjects s2 ON t.id = s2.teacher_id
JOIN grades g ON s2.id = g.subject_id 
GROUP BY t.id, t.fullname
ORDER BY average_grade;

--9
SELECT DISTINCT s2."name"  FROM subjects s2
JOIN grades g ON s2.id = g.subject_id 
JOIN students s ON g.student_id = s.id 
WHERE s.id = 22;

--10
SELECT DISTINCT s2."name" AS course_name
FROM subjects s2
JOIN grades g ON s2.id = g.subject_id 
JOIN students s ON g.student_id = s.id 
JOIN teachers t ON s2.teacher_id = t.id
WHERE s.id = 18 AND t.id = 2;

--Середній бал, який певний викладач ставить певному студентові.
SELECT t.fullname AS teacher_name, s.fullname AS student_name, ROUND(AVG(g.grade), 2) AS average_grade
FROM grades g
JOIN subjects s2 ON g.subject_id = s2.id
JOIN teachers t ON s2.teacher_id = t.id
JOIN students s ON s.id = g.student_id 
WHERE g.student_id = 22 AND t.id = 1
GROUP BY t.fullname, s.fullname;

--Оцінки студентів у певній групі з певного предмета на останньому занятті.
--(Вибірка шукає останній день,коли взагалі ставилися оцінки, і видає в указаній групі по конкретному предмету
--оцінки в цей день, якщо саме в цей день немає - пусто.)
SELECT s.fullname AS student_name, g.grade, g.grade_date
FROM grades g
JOIN students s ON g.student_id = s.id
JOIN subjects s2 ON g.subject_id = s2.id
JOIN groups gr ON s.group_id = gr.id
WHERE s2.id = 3 AND gr.id = 2 AND g.grade_date = (
    SELECT MAX(g2.grade_date)
    FROM grades g2
    WHERE g2.subject_id = s2.id AND g2.grade_date IS NOT NULL
)
ORDER BY g.grade_date;

