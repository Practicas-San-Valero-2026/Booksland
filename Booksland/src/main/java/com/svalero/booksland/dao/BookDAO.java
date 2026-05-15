package com.svalero.booksland.dao;

import com.svalero.booksland.mapper.BookMapper;
import com.svalero.booksland.model.Book;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public class BookDAO {
    // Insert
    @SqlUpdate("INSERT INTO books (title, genre, pages, publisher, id_author" VALUES (?, ?, ?, ?, ?)")
    void add(String title, String genre, int pages, String publisher, int idAuthor);

    // Delete
    @SqlUpdate("DELETE FROM books WHERE id = ?")
    void delete(int id);

    // Update
    @SqlUpdate("UPDATE books SET title = ?, genre = ?, pages = ?, publisher = ?, id_author = ? WHERE id = ?")
    void modify(String title, String genre, int pages, String publisher, int idAuthor);

    // List
    @SqlQuery("SELECT * FROM books")
    @UseRowMapper(BookMapper.class)
    List<Book> findAll();

    // Get by id
    @SqlQuery("SELECT * FROM books WHERE id = ?")
    @UseRowMapper(BookMapper.class)
    Book getById(int id);

    // TODO search
}
