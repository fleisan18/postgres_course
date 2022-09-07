SELECT *
FROM author;

UPDATE author
SET full_name = 'Joh', rating = 55
WHERE author_id = 1;

DELETE FROM author
WHERE rating IS NULL;

DELETE FROM author; -- удалить все строки
