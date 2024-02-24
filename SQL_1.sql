Drop table books;
Drop table readers;
Drop table records;

/* упражнение 1 */

CREATE TABLE books(
	id INT PRIMARY KEY NOT NULL,
	author TEXT ,
	title TEXT,
	publish_year INTEGER NOT NULL
);

INSERT INTO books
VALUES
    (1, 'Paul', 'название_1', strftime('%Y-%m-%d', '1978-06-19')),
    (2, 'Allen', 'название_2', strftime('%Y-%m-%d', '1999-01-29')),
	(4, 'Paul', 'название_4', strftime('%Y-%m-%d', '1978-06-20')),
    (3, 'Teddy', 'название_3', strftime('%Y-%m-%d', '2062-01-01'));

CREATE TABLE readers(
	id INT PRIMARY KEY NOT NULL,
	name TEXT NOT NULL
);

INSERT INTO readers
VALUES
	(1, 'читатель_1'),
	(2, 'читатель_2'),
	(3, 'читатель_3'),
	(4, 'читатель_4'),
	(5, 'читатель_5'),
	(6, 'читатель_6');

CREATE TABLE records(
	reader_id INT NOT NULL,
	book_id INT NOT NULL,
	taking_date INT,
	returning_date INT,
	FOREIGN KEY (book_id) REFERENCES books (id),
	FOREIGN KEY (reader_id) REFERENCES readers (id)
);

INSERT INTO records
VALUES
	(1, 1, strftime('%Y-%m-%d', 'now'), strftime('%Y-%m-%d', 'now', '+24 days')),
	(1, 4, strftime('%Y-%m-%d', 'now', '-1 month'), strftime('%Y-%m-%d', 'now', '+1 days')),
	(3, 2, strftime('%Y-%m-%d', 'now', '-4 month'), strftime('%Y-%m-%d', 'now', '-1 month'));
	
/* упражнение 2 */

/*Запрос возвращает id и названия книг, находящихся в данный момент на руках у читателей.*/
SELECT book_id, title
FROM records
JOIN books ON book_id = id
WHERE returning_date >= strftime('%Y-%m-%d', 'now');

/*Запрос возвращает имена читателей и названия книг, которые они когда либо брали.*/
SELECT name, title
FROM records
INNER JOIN readers ON readers.id = records.reader_id
INNER JOIN books ON books.id = records.book_id;

/*Запрос возвращает количество книг для каждого автора.*/
SELECT author, COUNT(*) as book_count
FROM books
GROUP BY author;