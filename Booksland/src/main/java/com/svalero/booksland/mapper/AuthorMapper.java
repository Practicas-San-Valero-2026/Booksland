package com.svalero.booksland.mapper;

import com.svalero.booksland.model.Author;
import com.svalero.booksland.model.Book;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthorMapper implements RowMapper<Author> {
    @Override
    public Author map(ResultSet rs, StatementContext ctx) throws SQLException {
        Author author = new Author();
        author.setId(rs.getInt("id"));
        author.setName(rs.getString("name"));
        author.setLastName(rs.getString("last_name"));
        author.setNationality(rs.getString("nationality"));
        author.setBiography(rs.getString("biography"));

        return author;
    }
}