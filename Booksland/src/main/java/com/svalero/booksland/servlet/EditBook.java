package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.AuthorDAO;
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
            sendError(response, "Missing pages");
            return;
        }
        int pages = Integer.parseInt(pagesParam);

        if (isEmpty(publisherParam)) {
            sendError(response, "Missing publisher");
            return;
        }

        try {
            Database.connect();
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);

            if ("Registrar".equals(action)) {

                authorDAO.add(titleParam, genreParam, pagesParam, publisherParam);

                sendSuccess(response, "Book successfully added");

            } else {

                if (isEmpty(id)) {
                    sendError(response, "Missing id");
                    return;
                }

                authorDAO.modify(titleParam, genreParam, pagesParam, publisherParam);

                sendSuccess(response, "Book successfully updated");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Error while adding Book");
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
