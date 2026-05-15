package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.BookDAO;
import com.svalero.booksland.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.svalero.booksland.dao.Database.jdbi;

@WebServlet("/edit-book")
public class EditBook extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

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

            if ("Registrar".equals(action)) {

                bookDAO.add(
                        titleParam,
                        genreParam,
                        pages,
                        publisherParam,
                        idAuthor
                );

                sendSuccess(response, "Book successfully added");

            } else {

                if (isEmpty(id)) {
                    sendError(response, "Missing id");
                    return;
                }

                if (!isPositiveInt(id)) {
                    sendError(response, "Invalid book id");
                    return;
                }

                int bookId = Integer.parseInt(id);

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