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

@WebServlet("/view-author")
public class ViewAuthor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        // Validate id
        if (id == null || id.isEmpty()) {
            response.sendError(400, "Missing the author's id");
            return;
        }

        try {
            Database.connect();

            int authorId = Integer.parseInt(id);

            // DAO
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);
            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);

            Author author = authorDAO.getById(authorId);

            if (author == null) {
                response.sendError(404, "Author not found");
                return;
            }

            List<Book> books = bookDAO.getByAuthor(authorId);

            // Send data to JSP
            request.setAttribute("author", author);
            request.setAttribute("books", books);
            request.getRequestDispatcher("/view-author.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid author's id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Loading error");
        }
    }
}
