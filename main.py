import logging
import psycopg2
import random
import string
from faker import Faker
from psycopg2 import DatabaseError

fake = Faker()

# Підключення до бази даних
conn = psycopg2.connect(host="localhost", database="test", user="postgres", password="mypass")
cur = conn.cursor()

# Додавання груп
for _ in range(3):
    random_letter = random.choice(string.ascii_uppercase)
    two_digit_number = random.randint(10, 99)
    group_name = "{}-{}".format(random_letter, two_digit_number)
    cur.execute("INSERT INTO groups (name) VALUES (%s) RETURNING id", (group_name,))
    group_id = cur.fetchone()[0]

# Додавання викладачів
for _ in range(3):
    cur.execute("INSERT INTO teachers (fullname) VALUES (%s)", (fake.name(),))

# Додавання предметів із вказівкою викладача
for teacher_id in range(1, 4):
    for _ in range(2):
        cur.execute("INSERT INTO subjects (name, teacher_id) VALUES (%s, %s)", (fake.word(), teacher_id))

# Додавання студентів і оцінок
for group_id in range(1, 4):
    for _ in range(10):
        cur.execute("INSERT INTO students (fullname, group_id) VALUES (%s, %s) RETURNING id",
                    (fake.name(), group_id))
        student_id = cur.fetchone()[0]
        for subject_id in range(1, 7):
            for _ in range(3):
                cur.execute("INSERT INTO grades (student_id, subject_id, grade, grade_date) VALUES (%s, %s, %s, %s)",
                            (student_id, subject_id, random.randint(1, 5), fake.date_this_year()))

try:
    # Збереження змін
    conn.commit()
except DatabaseError as e:
    logging.error(e)
    conn.rollback()
finally:
    # Закриття підключення
    cur.close()
    conn.close()
