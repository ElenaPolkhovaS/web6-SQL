SELECT DISTINCT s2."name"  FROM subjects s2
JOIN grades g ON s2.id = g.subject_id 
JOIN students s ON g.student_id = s.id 
WHERE s.id = 22;