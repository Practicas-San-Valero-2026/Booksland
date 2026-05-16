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

import static com.svalero.booksland.dao.Database.jdbi;

@WebServlet("/view-book")
public class ViewBooks extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            response.sendError(400, "Missing the book's id");
            return;
        }

        try {
            Database.connect();

            int bookId = Integer.parseInt(id);

            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);

            Book book = bookDAO.getById(bookId);

            if (book == null) {
                response.sendError(404, "Book not found");
                return;
            }

            Author author = authorDAO.getById(book.getIdAuthor());

            request.setAttribute("book", book);
            request.setAttribute("author", author);
            request.getRequestDispatcher("/view-book.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid book id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Loading error");
        }
    }
}