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

