CREATE DATABASE IF NOT EXISTS booksland;
USE booksland;

CREATE TABLE books (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    pages INT NOT NULL,
    publisher VARCHAR(50) NOT NULL
);

CREATE TABLE authors (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50),
    biography VARCHAR(250)
);

CREATE TABLE book_author (
    id_book INT UNSIGNED NOT NULL,
    id_author INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_book, id_author),
    FOREIGN KEY (id_book) REFERENCES books(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
   	FOREIGN KEY (id_author) REFERENCES authors(id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

