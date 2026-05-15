package com.svalero.booksland.mapper;

import com.svalero.booksland.model.Book;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BookMapper implements RowMapper<Book> {
    @Override
    public Book map(ResultSet rs, StatementContext ctx) throws SQLException {
        Book book = new Book();
        book.setId(rs.getInt("id"));
        book.setTitle(rs.getString("title"));
        book.setGenre(rs.getString("genre"));
        book.setPages(rs.getInt("pages"));
        book.setPublisher(rs.getString("publisher"));
        book.setIdAuthor(rs.getInt("id_author"));

        return book;
    }
}
