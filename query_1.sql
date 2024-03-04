SELECT s.id AS student_id, s.fullname AS student_name, ROUND(AVG(g.grade), 2) AS average_grade
FROM students s
JOIN grades g ON s.id = g.student_id
GROUP BY s.id, s.fullname
ORDER BY average_grade DESC
LIMIT 5;

