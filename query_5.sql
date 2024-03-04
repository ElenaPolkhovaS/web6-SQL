SELECT t.fullname, s.name AS subject_name
FROM subjects s 
JOIN teachers t ON t.id = s.teacher_id 
WHERE teacher_id = 2;