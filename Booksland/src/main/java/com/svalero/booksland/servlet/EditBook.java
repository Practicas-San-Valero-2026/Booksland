package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.BookDAO;
import com.svalero.booksland.dao.Database;
import com.svalero.booksland.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.IOException;

import static com.svalero.booksland.dao.Database.jdbi;

@MultipartConfig
@WebServlet("/edit-book")
public class EditBook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        try {
            Database.connect();

            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);

            if (idParam != null && idParam.isEmpty() && isPositiveInt(idParam)) {
                int bookId = Integer.parseInt(idParam);
                Book book = bookDAO.getById(bookId);

                if (book != null) {
                    request.setAttribute("book", book);
                }
            }

            request.getRequestDispatcher("/edit-book.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Loading error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        String titleParam = request.getParameter("title");
        String genreParam = request.getParameter("genre");
        String pagesParam = request.getParameter("pages");
        String publisherParam = request.getParameter("publisher");
        String idAuthorParam = request.getParameter("idAuthor");

        // Validaciones básicas
        if (isEmpty(titleParam)) {
            sendError(response, "Missing title");
            return;
        }

        if (isEmpty(genreParam)) {
            sendError(response, "Missing genre");
            return;
        }

        if (!isPositiveInt(pagesParam)) {
            sendError(response, "Pages must be a number greater than 0");
            return;
        }

        if (isEmpty(publisherParam)) {
            sendError(response, "Missing publisher");
            return;
        }

        if (!isPositiveInt(idAuthorParam)) {
            sendError(response, "Missing author");
            return;
        }

        int pages = Integer.parseInt(pagesParam);
        int idAuthor = Integer.parseInt(idAuthorParam);

        try {
            Database.connect();

            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);

            if (!isPositiveInt(idParam)) {

                bookDAO.add(
                        titleParam,
                        genreParam,
                        pages,
                        publisherParam,
                        idAuthor
                );

                sendSuccess(response, "Book successfully added");

            } else {

                int bookId = Integer.parseInt(idParam);

                bookDAO.modify(
                        titleParam,
                        genreParam,
                        pages,
                        publisherParam,
                        idAuthor,
                        bookId
                );

                sendSuccess(response, "Book successfully updated");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Error while saving book");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isPositiveInt(String value) {
        try {
            return Integer.parseInt(value) > 0;
        } catch (Exception e) {
            return false;
        }
    }

    private void sendSuccess(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "success", message);
    }

    private void sendError(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "danger", message);
    }

    private void sendMessage(HttpServletResponse response, String type, String message) throws IOException {
        response.getWriter().println(
                "<div class=\"alert alert-" + type + "\" role=\"alert\">" +
                        message +
                        "</div>"
        );
    }
}