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

@WebServlet("/edit-author")
public class EditAuthor extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String id = request.getParameter("id");

        String nameParam = request.getParameter("name");
        String lastNameParam = request.getParameter("lastName");
        String nationalityParam = request.getParameter("nationality");
        String biographyParam = request.getParameter("biography");

        // Validaciones básicas
        if (isEmpty(nameParam)) {
            sendError(response, "Missing name");
            return;
        }

        if (isEmpty(lastNameParam)) {
            sendError(response, "Missing last name");
            return;
        }

        try {
            Database.connect();
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);

            if ("Registrar".equals(action)) {

                authorDAO.add(nameParam, lastNameParam, nationalityParam, biographyParam);

                sendSuccess(response, "Author added correctly");

            } else {

                if (isEmpty(id)) {
                    sendError(response, "Missing id");
                    return;
                }

                authorDAO.modify(nameParam, lastNameParam, nationalityParam, biographyParam, Integer.parseInt(id));

                sendSuccess(response, "Author modified correctly");
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError(response, "Error while adding author");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
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