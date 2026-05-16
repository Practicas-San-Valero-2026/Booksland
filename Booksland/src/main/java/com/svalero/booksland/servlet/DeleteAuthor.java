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

@WebServlet("/remove-author")
public class DeleteAuthor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(400, "Author's id is missing");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            Database.connect();

            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);
            authorDAO.delete(id);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Author deleted correctly");

        } catch (Exception e) {
            e.printStackTrace();
            // Conflict error
            response.sendError(409, "It has been impossible to remove the author because it may have registered books.");
        }
    }
}
