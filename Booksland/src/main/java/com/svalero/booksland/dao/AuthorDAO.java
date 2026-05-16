package com.svalero.booksland.dao;

import com.svalero.booksland.mapper.AuthorMapper;
import com.svalero.booksland.model.Author;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface AuthorDAO {

    // Insert
    @SqlUpdate("INSERT INTO authors (name, last_name, nationality, biography) VALUES (?, ?, ?, ?)")
    void add(String name, String lastName, String nationality, String biography);

    // Delete
    @SqlUpdate("DELETE FROM authors WHERE id = ?")
    void delete(int id);

    // Update
    @SqlUpdate("UPDATE authors SET name = ?, last_name = ?, nationality = ?, biography = ? WHERE id = ?")
    void modify(String name, String lastName, String nationality, String biography, int id);

    // List
    @SqlQuery("SELECT * FROM authors")
    @UseRowMapper(AuthorMapper.class)
    List<Author> findAll();

    // Get by id
    @SqlQuery("SELECT * FROM authors WHERE id = ?")
    @UseRowMapper(AuthorMapper.class)
    Author getById(int id);

    // search by name and/or last name
    @SqlQuery("""
    SELECT * FROM authors
    WHERE name LIKE ?
       OR last_name LIKE ?
       OR CONCAT(name, ' ', last_name) LIKE ?
""")
    @UseRowMapper(AuthorMapper.class)
    List<Author> search(String search1, String search2, String search3);
}
