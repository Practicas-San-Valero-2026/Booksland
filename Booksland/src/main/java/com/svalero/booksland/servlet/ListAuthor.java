package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.AuthorDAO;
import com.svalero.booksland.dao.Database;
import com.svalero.booksland.model.Author;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import static com.svalero.booksland.dao.Database.jdbi;

import java.io.IOException;
import java.util.List;

@WebServlet("/authors")
public class ListAuthor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Database.connect();

            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);

            String search = request.getParameter("search");
            List<Author> authors;

            if (search == null || search.trim().isEmpty()) {
                authors = authorDAO.findAll();
            } else {
                String pattern = "%" + search.trim() + "%";
                authors = authorDAO.search(pattern, pattern, pattern);
            }

            request.setAttribute("authors", authors);
            request.setAttribute("search", search);

            request.getRequestDispatcher("authors.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error: it has been impossible to connect to the database");
        }
    }
}