package com.svalero.booksland.dao;

import com.svalero.booksland.mapper.BookMapper;
import com.svalero.booksland.model.Book;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface BookDAO {
    // Insert
    @SqlUpdate("INSERT INTO books (title, genre, pages, publisher, id_author) VALUES (?, ?, ?, ?, ?)")
    void add(String title, String genre, int pages, String publisher, int idAuthor);

    // Delete
    @SqlUpdate("DELETE FROM books WHERE id = ?")
    void delete(int id);

    // Update
    @SqlUpdate("UPDATE books SET title = ?, genre = ?, pages = ?, publisher = ?, id_author = ? WHERE id = ?")
    void modify(String title, String genre, int pages, String publisher, int idAuthor, int id);

    // List
    @SqlQuery("SELECT * FROM books")
    @UseRowMapper(BookMapper.class)
    List<Book> findAll();

    // Get by id
    @SqlQuery("SELECT * FROM books WHERE id = ?")
    @UseRowMapper(BookMapper.class)
    Book getById(int id);

    // List books by author
    @SqlQuery("SELECT * FROM books WHERE id_author = ?")
    @UseRowMapper(BookMapper.class)
    List<Book> getByAuthor(int idAuthor);

    // search
    @SqlQuery("SELECT * FROM books WHERE title LIKE CONCAT('%', ?, '%') AND (? = 0 OR id_author = ?)")
    @UseRowMapper(BookMapper.class)
    List<Book> search(String title, int idAuthor);
}
