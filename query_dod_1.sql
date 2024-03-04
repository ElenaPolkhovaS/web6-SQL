--Середній бал, який певний викладач ставить певному студентові.
SELECT t.fullname AS teacher_name, s.fullname AS student_name, ROUND(AVG(g.grade), 2) AS average_grade
FROM grades g
JOIN subjects s2 ON g.subject_id = s2.id
JOIN teachers t ON s2.teacher_id = t.id
JOIN students s ON s.id = g.student_id 
WHERE g.student_id = 22 AND t.id = 1
GROUP BY t.fullname, s.fullname;