SELECT s.fullname AS student_name, g.grade, s2.name AS subject_name
FROM grades g
JOIN students s ON g.student_id = s.id
JOIN subjects s2  ON g.subject_id = s2.id
WHERE g.subject_id = 2;