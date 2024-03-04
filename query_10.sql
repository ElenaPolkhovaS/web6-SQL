SELECT DISTINCT s2."name" AS course_name
FROM subjects s2
JOIN grades g ON s2.id = g.subject_id 
JOIN students s ON g.student_id = s.id 
JOIN teachers t ON s2.teacher_id = t.id
WHERE s.id = 18 AND t.id = 2;