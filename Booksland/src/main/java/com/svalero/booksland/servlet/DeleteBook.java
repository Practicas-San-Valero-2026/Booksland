package com.svalero.booksland.servlet;

import com.svalero.booksland.dao.BookDAO;
import com.svalero.booksland.dao.Database;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static com.svalero.booksland.dao.Database.jdbi;

@WebServlet("/remove-book")
public class DeleteBook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(400, "Book's id is missing");
            return;
        }

        int id = Integer.parseInt(idParam);

        try {
            Database.connect();

            BookDAO bookDAO = jdbi.onDemand(BookDAO.class);
            bookDAO.delete(id);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Book deleted correctly");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error: it has been impossible to delete the book");
        }
    }
}
