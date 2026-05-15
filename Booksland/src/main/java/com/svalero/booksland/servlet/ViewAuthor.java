package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.AuthorDAO;
import com.svalero.booksland.dao.Database;
import com.svalero.booksland.model.Author;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.svalero.booksland.dao.Database.jdbi;

@WebServlet("/view-author")
public class ViewAuthor extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");

        // Validar id
        if (id == null || id.isEmpty()) {
            response.sendError(400, "Missing the author's id");
            return;
        }

        try {
            Database.connect();

            // DAO
            AuthorDAO authorDAO = jdbi.onDemand(AuthorDAO.class);
            Author author = authorDAO.getById(Integer.parseInt(id));

            // Mandar datos al JSP
            request.setAttribute("author", author);
            request.getRequestDispatcher("/view-author.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Loading error");
        }
    }
}
