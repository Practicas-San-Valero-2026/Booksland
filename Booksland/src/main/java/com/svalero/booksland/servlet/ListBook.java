package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.AuthorDAO;
import com.svalero.booksland.dao.BookDAO;
import com.svalero.booksland.dao.Database;
import com.svalero.booksland.model.Author;
import com.svalero.booksland.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static com.svalero.booksland.dao.Database.jdbi;

@WebServlet("/books")
public class ListBook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Database.connect();

            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);

            String search = request.getParameter("search");

            if (search == null) {
                search = "";
            }

            List<Book> books = bookDAO.search(search);
            List<Author> authors = authorDAO.findAll();

            request.setAttribute("books", books);
            request.setAttribute("authors", authors);
            request.setAttribute("search", search);

            request.getRequestDispatcher("books.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error: it has been impossible to connect to the database");
        }
    }
}