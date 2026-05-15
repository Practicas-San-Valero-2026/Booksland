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

            // Connecting DAO with DB
            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);

            // get, validate and formar every input
            String title = request.getParameter("title");
            String idAuthorParam = request.getParameter("idAuthor");

            if (title == null) {
                title = "";
            }

            int idAuthor = 0;

            if (idAuthorParam != null && !idAuthorParam.isEmpty()) {
                idAuthor = Integer.parseInt(idAuthorParam);
            }

            // search books
            List<Book> books = bookDAO.search(title, idAuthor);
            // Load authors
            List<Author> authors = authorDAO.findAll();

            // Send data to JSP
            request.setAttribute("title", title);
            request.setAttribute("author", authors);

            // Send response to JSP
            request.getRequestDispatcher("books.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error: it has been impossible to connect to the database");
        }

    }
}
