SELECT t.fullname, ROUND(AVG(g.grade), 2) AS average_grade
FROM teachers t 
JOIN subjects s2 ON t.id = s2.teacher_id
JOIN grades g ON s2.id = g.subject_id 
GROUP BY t.id, t.fullname
ORDER BY average_grade;